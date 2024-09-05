<template>
  <div class="panel-tab__content">
    <el-table :data="elementListenersList" border size="mini">
      <el-table-column label="序号" width="50px" type="index" />
      <el-table-column label="类型" width="60px" show-overflow-tooltip :formatter="row => listenerEventTypeObject[row.event]" />
<!--      <el-table-column label="事件id" min-width="70px" prop="id" show-overflow-tooltip />-->
      <el-table-column label="监听类型" width="85px" show-overflow-tooltip :formatter="row => listenerTypeObject[row.listenerType]" />
      <el-table-column label="操作" >
        <template  slot-scope="scope">
          <el-button size="mini" type="primary" @click="openListenerForm(scope.row, scope.$index)">编辑</el-button>
          <el-divider direction="vertical" />
          <el-button size="mini" type="danger" @click="removeListener(scope.row, scope.$index)">移除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="element-drawer__button_save">
      <el-button type="primary" icon="el-icon-plus" size="small" @click="listenerSystemVisible = true">内置监听器</el-button>
      <el-button type="primary" icon="el-icon-plus" size="small" @click="openListenerForm(null)">自定义监听器</el-button>
    </div>

    <!-- 监听器 编辑/创建 部分 -->
    <el-drawer :visible.sync="listenerFormModelVisible" title="任务监听器" size="480px" append-to-body destroy-on-close>
      <el-form :model="listenerForm" size="small" label-width="110px" ref="listenerFormRef" @submit.native.prevent>
        <el-form-item prop="event" :rules="{ required: true, trigger: ['blur', 'change'] }">
          <template slot="label">
            <span>
               事件类型
               <el-tooltip placement="top">
                  <template slot="content">
                     <div>
                              create（创建）：当任务已经创建，并且所有任务参数都已经设置时触发。
                        <br />assignment（指派）：当任务已经指派给某人时触发。请注意：当流程执行到达用户任务时，
                        <br />在触发create事件之前，会首先触发assignment事件。这顺序看起来不太自然，
                        <br />但是有实际原因的：当收到create事件时，我们通常希望能看到任务的所有参数，包括办理人。
                        <br />complete（完成）：当任务已经完成，从运行时数据中删除前触发。
                        <br />delete（删除）：在任务即将被删除前触发。请注意任务由completeTask正常完成时也会触发。
                     </div>
                  </template>
                  <i class="el-icon-question" />
               </el-tooltip>
            </span>
          </template>
          <el-select v-model="listenerForm.event">
            <el-option v-for="i in Object.keys(listenerEventTypeObject)" :key="i" :label="listenerEventTypeObject[i]" :value="i" />
          </el-select>
        </el-form-item>
<!--        <el-form-item label="监听器ID" prop="id" :rules="{ required: true, trigger: ['blur', 'change'] }">-->
<!--          <el-input v-model="listenerForm.id" clearable />-->
<!--        </el-form-item>-->
        <el-form-item label="监听器类型" prop="listenerType" :rules="{ required: true, trigger: ['blur', 'change'] }">
          <template slot="label">
            <span>
               监听类型
               <el-tooltip placement="top">
                  <template slot="content">
                     <div>
                              class：需要调用的委托类。这个类必须实现org.flowable.engine.delegate.TaskListener接口。
                        <br />assignment（指派）：当任务已经指派给某人时触发。请注意：当流程执行到达用户任务时，
                        <br />  在触发create事件之前，会首先触发assignment事件。这顺序看起来不太自然，
                        <br />  但是有实际原因的：当收到create事件时，我们通常希望能看到任务的所有参数，包括办理人。
                        <br />complete（完成）：当任务已经完成，从运行时数据中删除前触发。
                        <br />delete（删除）：在任务即将被删除前触发。请注意任务由completeTask正常完成时也会触发。
                     </div>
                  </template>
                  <i class="el-icon-question" />
               </el-tooltip>
            </span>
          </template>
          <el-select v-model="listenerForm.listenerType">
            <el-option v-for="i in Object.keys(listenerTypeObject)" :key="i" :label="listenerTypeObject[i]" :value="i" />
          </el-select>
        </el-form-item>
        <el-form-item
            v-if="listenerForm.listenerType === 'classListener'"
            label="Java类"
            prop="class"
            key="listener-class"
            :rules="{ required: true, trigger: ['blur', 'change'] }"
        >
          <el-input v-model="listenerForm.class" clearable />
        </el-form-item>
        <el-form-item
            v-if="listenerForm.listenerType === 'expressionListener'"
            label="表达式"
            prop="expression"
            key="listener-expression"
            :rules="{ required: true, trigger: ['blur', 'change'] }"
        >
          <el-input v-model="listenerForm.expression" clearable />
        </el-form-item>
        <el-form-item
            v-if="listenerForm.listenerType === 'delegateExpressionListener'"
            label="代理表达式"
            prop="delegateExpression"
            key="listener-delegate"
            :rules="{ required: true, trigger: ['blur', 'change'] }"
        >
          <el-input v-model="listenerForm.delegateExpression" clearable />
        </el-form-item>
        <template v-if="listenerForm.listenerType === 'scriptListener'">
          <el-form-item
              label="脚本格式"
              prop="scriptFormat"
              key="listener-script-format"
              :rules="{ required: true, trigger: ['blur', 'change'], message: '请填写脚本格式' }"
          >
            <el-input v-model="listenerForm.scriptFormat" clearable />
          </el-form-item>
          <el-form-item
              label="脚本类型"
              prop="scriptType"
              key="listener-script-type"
              :rules="{ required: true, trigger: ['blur', 'change'], message: '请选择脚本类型' }"
          >
            <el-select v-model="listenerForm.scriptType">
              <el-option label="内联脚本" value="inlineScript" />
              <el-option label="外部脚本" value="externalScript" />
            </el-select>
          </el-form-item>
          <el-form-item
              v-if="listenerForm.scriptType === 'inlineScript'"
              label="脚本内容"
              prop="value"
              key="listener-script"
              :rules="{ required: true, trigger: ['blur', 'change'], message: '请填写脚本内容' }"
          >
            <el-input v-model="listenerForm.value" clearable />
          </el-form-item>
          <el-form-item
              v-if="listenerForm.scriptType === 'externalScript'"
              label="资源地址"
              prop="resource"
              key="listener-resource"
              :rules="{ required: true, trigger: ['blur', 'change'], message: '请填写资源地址' }"
          >
            <el-input v-model="listenerForm.resource" clearable />
          </el-form-item>
        </template>

        <template v-if="listenerForm.event === 'timeout'">
          <el-form-item label="定时器类型" prop="eventDefinitionType" key="eventDefinitionType">
            <el-select v-model="listenerForm.eventDefinitionType">
              <el-option label="日期" value="date" />
              <el-option label="持续时长" value="duration" />
              <el-option label="循环" value="cycle" />
              <el-option label="无" value="null" />
            </el-select>
          </el-form-item>
          <el-form-item
              v-if="!!listenerForm.eventDefinitionType && listenerForm.eventDefinitionType !== 'null'"
              label="定时器"
              prop="eventTimeDefinitions"
              key="eventTimeDefinitions"
              :rules="{ required: true, trigger: ['blur', 'change'], message: '请填写定时器配置' }"
          >
            <el-input v-model="listenerForm.eventTimeDefinitions" clearable />
          </el-form-item>
        </template>
      </el-form>

      <el-divider />
      <p class="listener-filed__title">
        <span><i class="el-icon-menu"></i>注入字段：</span>
        <el-button size="small" type="primary" @click="openListenerFieldForm(null)">添加字段</el-button>
      </p>
      <el-table :data="fieldsListOfListener" size="mini" max-height="240" border fit style="flex: none">
        <el-table-column label="序号" width="50px" type="index" />
        <el-table-column label="字段名称" width="80px" prop="name" />
        <el-table-column label="字段类型" width="80px" show-overflow-tooltip :formatter="row => fieldTypeObject[row.fieldType]" />
        <el-table-column label="值内容" width="80px" show-overflow-tooltip :formatter="row => row.string || row.expression" />
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button size="mini" type="primary"  @click="openListenerFieldForm(scope.row, scope.$index)">编辑</el-button>
            <el-divider direction="vertical" />
            <el-button size="mini" type="danger" @click="removeListenerField(scope.row, scope.$index)">移除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="element-drawer__button">
        <el-button size="small" @click="listenerFormModelVisible = false">取 消</el-button>
        <el-button size="small" type="primary" @click="saveListenerConfig">保 存</el-button>
      </div>
    </el-drawer>

    <!-- 注入西段 编辑/创建 部分 -->
    <el-dialog title="字段配置" :visible.sync="listenerFieldFormModelVisible" width="600px" append-to-body destroy-on-close>
      <el-form :model="listenerFieldForm"  label-width="96px" ref="listenerFieldFormRef" style="height: 136px" @submit.native.prevent>
        <el-form-item label="字段名称：" prop="name" :rules="{ required: true, trigger: ['blur', 'change'] }">
          <el-input v-model="listenerFieldForm.name" clearable />
        </el-form-item>
        <el-form-item label="字段类型：" prop="fieldType" :rules="{ required: true, trigger: ['blur', 'change'] }">
          <el-select v-model="listenerFieldForm.fieldType">
            <el-option v-for="i in Object.keys(fieldTypeObject)" :key="i" :label="fieldTypeObject[i]" :value="i" />
          </el-select>
        </el-form-item>
        <el-form-item
            v-if="listenerFieldForm.fieldType === 'string'"
            label="字段值："
            prop="string"
            key="field-string"
            :rules="{ required: true, trigger: ['blur', 'change'] }"
        >
          <el-input v-model="listenerFieldForm.string" clearable />
        </el-form-item>
        <el-form-item
            v-if="listenerFieldForm.fieldType === 'expression'"
            label="表达式："
            prop="expression"
            key="field-expression"
            :rules="{ required: true, trigger: ['blur', 'change'] }"
        >
          <el-input v-model="listenerFieldForm.expression" clearable />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
          <el-button size="small" @click="listenerFieldFormModelVisible= false">取 消</el-button>
          <el-button size="small" type="primary" @click="saveListenerFiled">确 定</el-button>
      </div>
    </el-dialog>

    <!-- 内置监听器 -->
    <el-drawer :visible.sync="listenerSystemVisible" title="任务监听器" size="580px" append-to-body destroy-on-close>
      <el-table v-loading="loading" :data="listenerList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="名称" align="center" prop="name" />
        <el-table-column label="类型" align="center" prop="eventType"/>
        <el-table-column label="监听类型" align="center" prop="valueType">
          <template slot-scope="scope">
            <dict-tag :options="dict.type.sys_listener_value_type" :value="scope.row.valueType"/>
          </template>
        </el-table-column>
        <el-table-column label="执行内容" align="center" prop="value" :show-overflow-tooltip="true"/>
      </el-table>

      <pagination
          v-show="total>0"
          :total="total"
          layout="prev, pager, next"
          :page.sync="queryParams.pageNum"
          :limit.sync="queryParams.pageSize"
          @pagination="getList"
      />

      <div class="element-drawer__button">
        <el-button size="small" @click="listenerSystemVisible = false">取 消</el-button>
        <el-button size="small" type="primary" :disabled="listenerSystemChecked" @click="saveSystemListener">保 存</el-button>
      </div>
    </el-drawer>
  </div>
</template>
<script>
import { listListener } from "@/api/flowable/listener";
import {
  changeListenerObject,
  createListenerObject,
  createSystemListenerObject,
  updateElementExtensions
} from "../common/bpmnUtils";

import {StrUtil} from "@/utils/StrUtil";

export default {
  name: "TaskListener",
  // 内置监听器相关信息
  dicts: ['sys_listener_value_type', 'sys_listener_event_type'],
  /** 组件传值  */
  props : {
    id: {
      type: String,
      required: true
    },
  },
  data() {
    return {
      elementListenersList: [], // 监听器列表
      listenerForm: {},// 监听器详情表单
      listenerFormModelVisible: false, // 监听器 编辑 侧边栏显示状态
      fieldsListOfListener: [],
      bpmnElementListeners: [],
      otherExtensionList: [],
      listenerFieldForm: {}, // 监听器 注入字段 详情表单
      listenerFieldFormModelVisible: false, // 监听器 注入字段表单弹窗 显示状态
      editingListenerIndex: -1, // 监听器所在下标，-1 为新增
      editingListenerFieldIndex: -1, // 字段所在下标，-1 为新增

      listenerList: [],
      checkedListenerData: [],
      listenerSystemVisible: false,
      listenerSystemChecked: true,
      loading: true,
      total: 0,
      listenerTypeObject: {
        classListener: "Java 类",
        expressionListener: "表达式",
        delegateExpressionListener: "代理表达式",
        scriptListener: "脚本"
      },
      listenerEventTypeObject:{
        create: "创建",
        assignment: "指派",
        complete: "完成",
        delete: "删除",
        // update: "更新",
        // timeout: "超时"
      },
      fieldTypeObject:{
        string: "字符串",
        expression: "表达式"
      },
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        type: 1,
      },
    }
  },

  /** 传值监听 */
  watch: {
    id: {
      handler(newVal) {
        if (StrUtil.isNotBlank(newVal)) {
          this.resetListenersList();
        }
      },
      immediate: true, // 立即生效
    },
  },
  created() {
    this.getList();

  },
  methods: {
    resetListenersList() {
      this.bpmnElementListeners =
        this.modelerStore.element.businessObject?.extensionElements?.values?.filter(ex => ex.$type === `flowable:TaskListener`) ?? [];
      this.elementListenersList = this.bpmnElementListeners.map(listener => this.initListenerType(listener));
      this.$emit('getTaskListenerCount', this.elementListenersList.length)
    },

    // 打开 监听器详情 侧边栏
    openListenerForm(listener, index) {
      if (listener) {
        this.listenerForm = this.initListenerForm(listener);
        this.editingListenerIndex = index;
      } else {
        this.listenerForm = {};
        this.editingListenerIndex = -1; // 标记为新增
      }
      if (listener && listener.fields) {
        this.fieldsListOfListener = listener.fields.map(field => ({
          ...field,
          fieldType: field.string ? "string" : "expression"
        }));
      } else {
        this.fieldsListOfListener = [];
        this.$set(this.listenerForm, "fields", []);
      }
      // 打开侧边栏并清楚验证状态
      this.listenerFormModelVisible = true;
      this.$nextTick(() => {
        if (this.$refs["listenerFormRef"]) this.$refs["listenerFormRef"].clearValidate();
      });
    },

    // 打开监听器字段编辑弹窗
    openListenerFieldForm(field, index) {
      this.listenerFieldForm = field ? JSON.parse(JSON.stringify(field)) : {};
      this.editingListenerFieldIndex = field ? index : -1;
      this.listenerFieldFormModelVisible = true;
      this.$nextTick(() => {
        if (this.$refs["listenerFieldFormRef"]) this.$refs["listenerFieldFormRef"].clearValidate();
      });
    },

    // 保存监听器注入字段
    async saveListenerFiled() {
      let validateStatus = await this.$refs["listenerFieldFormRef"].validate();
      if (!validateStatus) return; // 验证不通过直接返回
      if (this.editingListenerFieldIndex === -1) {
        this.fieldsListOfListener.push(this.listenerFieldForm);
        this.listenerForm.fields.push(this.listenerFieldForm);
      } else {
        this.fieldsListOfListener.splice(this.editingListenerFieldIndex, 1, this.listenerFieldForm);
        this.listenerForm.fields.splice(this.editingListenerFieldIndex, 1, this.listenerFieldForm);
      }
      this.listenerFieldFormModelVisible = false;
      this.$nextTick(() => (this.listenerFieldForm = {}));
    },

    // 移除监听器字段
    removeListenerField(field, index) {
      this.$confirm("确认移除该字段吗？", "提示", {
        confirmButtonText: "确 认",
        cancelButtonText: "取 消"
      }).then(() => {
        this.fieldsListOfListener.splice(index, 1);
        this.listenerForm.fields.splice(index, 1);
      }).catch(() => console.info("操作取消"));
    },

    // 移除监听器
    removeListener(listener, index) {
      this.$confirm("确认移除该监听器吗？", "提示", {
        confirmButtonText: "确 认",
        cancelButtonText: "取 消"
      }).then(() => {
        this.bpmnElementListeners.splice(index, 1);
        this.elementListenersList.splice(index, 1);
        updateElementExtensions(this.modelerStore.moddle, this.modelerStore.modeling, this.modelerStore.element, this.otherExtensionList.concat(this.bpmnElementListeners));
        this.$emit('getTaskListenerCount', this.elementListenersList.length)
      }).catch((r) => console.info(r, "操作取消"));
    },

    // 保存监听器配置
    async saveListenerConfig() {
      let validateStatus = await this.$refs["listenerFormRef"].validate();
      if (!validateStatus) return; // 验证不通过直接返回
      const listenerObject = createListenerObject(this.modelerStore.moddle, this.listenerForm, false, "flowable");
      if (this.editingListenerIndex === -1) {
        this.bpmnElementListeners.push(listenerObject);
        this.elementListenersList.push(this.listenerForm);
      } else {
        this.bpmnElementListeners.splice(this.editingListenerIndex, 1, listenerObject);
        this.elementListenersList.splice(this.editingListenerIndex, 1, this.listenerForm);
      }
      // 保存其他配置
      this.otherExtensionList = this.modelerStore.element.businessObject?.extensionElements?.values?.filter(ex => ex.$type !== `flowable:TaskListener`) ?? [];
      updateElementExtensions(this.modelerStore.moddle, this.modelerStore.modeling, this.modelerStore.element, this.otherExtensionList.concat(this.bpmnElementListeners));
      this.$emit('getTaskListenerCount', this.elementListenersList.length)
      // 4. 隐藏侧边栏
      this.listenerFormModelVisible = false;
      this.listenerForm = {};
    },

    initListenerType(listener) {
      let listenerType;
      if (listener.class) listenerType = "classListener";
      if (listener.expression) listenerType = "expressionListener";
      if (listener.delegateExpression) listenerType = "delegateExpressionListener";
      if (listener.script) listenerType = "scriptListener";
      return {
        ...JSON.parse(JSON.stringify(listener)),
        ...(listener.script ?? {}),
        listenerType: listenerType
      };
    },

    // 初始化表单数据
    initListenerForm(listener) {
      let self = {
        ...listener
      };
      if (listener.script) {
        self = {
          ...listener,
          ...listener.script,
          scriptType: listener.script.resource ? "externalScript" : "inlineScript"
        };
      }
      if (listener.event === "timeout" && listener.eventDefinitions) {
        if (listener.eventDefinitions.length) {
          let k = "";
          for (let key in listener.eventDefinitions[0]) {
            console.log(listener.eventDefinitions, key);
            if (key.indexOf("time") !== -1) {
              k = key;
              self.eventDefinitionType = key.replace("time", "").toLowerCase();
            }
          }
          console.log(k);
          self.eventTimeDefinitions = listener.eventDefinitions[0][k].body;
        }
      }
      return self;
    },


    /** 查询流程达式列表 */
    getList() {
      this.loading = true;
      listListener(this.queryParams).then(response => {
        this.listenerList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },

    // 多选框选中数据
    handleSelectionChange(selection) {
      // ids.value = selection.map(item => item.id);
      // TODO 应该使用 push?
      this.checkedListenerData = selection;
      this.listenerSystemChecked = selection.length !== 1;
    },

    // 保存内置监听器
    saveSystemListener() {
      if (this.checkedListenerData.length > 0) {
        this.checkedListenerData.forEach(value => {
          // 保存其他配置
          const listenerObject = createSystemListenerObject(this.modelerStore.moddle, value, true, "flowable");
          this.bpmnElementListeners.push(listenerObject);
          this.elementListenersList.push(changeListenerObject(value));
          this.otherExtensionList = this.modelerStore.element.businessObject?.extensionElements?.values?.filter(ex => ex.$type !== `flowable:TaskListener`) ?? [];
          updateElementExtensions(this.modelerStore.moddle, this.modelerStore.modeling, this.modelerStore.element, this.otherExtensionList.concat(this.bpmnElementListeners));
        })
        // 回传显示数量
        this.$emit('getTaskListenerCount', this.elementListenersList.length)
      }
      this.checkedListenerData = [];
      this.listenerSystemChecked = true;
      // 隐藏侧边栏
      this.listenerSystemVisible = false;
    }
  }
}
</script>

<style lang="scss">
@import '../style/process-panel';
.flow-containers  .el-badge__content.is-fixed {
  top: 18px;
}
.dialog-footer button:first-child {
  margin-right: 10px;
}
</style>
