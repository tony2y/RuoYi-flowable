<template>
  <div>
    <el-form label-width="80px" size="small">
      <el-form-item label="异步">
        <el-switch v-model="bpmnFormData.async" active-text="是" inactive-text="否" @change="updateElementTask('async')"/>
      </el-form-item>
      <el-form-item label="用户类型">
        <el-select v-model="bpmnFormData.userType" placeholder="选择人员" @change="updateUserType">
          <el-option
            v-for="item in userTypeOption"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>

      <el-form-item label="指定人员" v-if="bpmnFormData.userType === 'assignee'">
        <el-input-tag v-model="bpmnFormData.assignee" :value="bpmnFormData.assignee"/>
        <el-button-group class="ml-4" style="margin-top: 4px">
          <!--指定人员-->
          <el-tooltip class="box-item" effect="dark" content="指定人员" placement="bottom">
            <el-button size="mini" type="primary" icon="el-icon-user" @click="singleUserCheck"/>
          </el-tooltip>
          <!--选择表达式-->
          <el-tooltip class="box-item" effect="dark" content="选择表达式" placement="bottom">
            <el-button size="mini" type="warning" icon="el-icon-postcard" @click="singleExpCheck"/>
          </el-tooltip>
        </el-button-group>
      </el-form-item>

      <el-form-item label="候选人员" v-else-if="bpmnFormData.userType === 'candidateUsers'">
        <el-input-tag v-model="bpmnFormData.candidateUsers" :value="bpmnFormData.candidateUsers"/>
        <el-button-group class="ml-4" style="margin-top: 4px">
          <!--候选人员-->
          <el-tooltip class="box-item" effect="dark" content="候选人员" placement="bottom">
            <el-button size="mini" type="primary" icon="el-icon-user" @click="multipleUserCheck"/>
          </el-tooltip>
          <!--选择表达式-->
          <el-tooltip class="box-item" effect="dark" content="选择表达式" placement="bottom">
            <el-button size="mini" type="warning" icon="el-icon-postcard" @click="singleExpCheck"/>
          </el-tooltip>
        </el-button-group>
      </el-form-item>

      <el-form-item label="候选角色" v-else>
        <el-input-tag v-model="bpmnFormData.candidateGroups" :value="bpmnFormData.candidateGroups"/>
        <el-button-group class="ml-4" style="margin-top: 4px">
          <!--候选角色-->
          <el-tooltip class="box-item" effect="dark" content="候选角色" placement="bottom">
            <el-button size="mini" type="primary" icon="el-icon-user"  @click="multipleRoleCheck"/>
          </el-tooltip>
          <!--选择表达式-->
          <el-tooltip class="box-item" effect="dark" content="选择表达式" placement="bottom">
            <el-button size="mini" type="warning" icon="el-icon-postcard" @click="singleExpCheck"/>
          </el-tooltip>
        </el-button-group>
      </el-form-item>

      <el-form-item label="优先级">
        <el-input v-model="bpmnFormData.priority" @change="updateElementTask('priority')"/>
      </el-form-item>
      <el-form-item label="到期时间">
        <el-input v-model="bpmnFormData.dueDate" @change="updateElementTask('dueDate')"/>
      </el-form-item>
    </el-form>

    <!--选择人员-->
    <el-dialog
      title="选择人员"
      :visible.sync="userVisible"
      width="60%"
      :close-on-press-escape="false"
      :show-close="false"
    >
      <flow-user v-if="userVisible" :checkType="checkType" :selectValues="selectData.assignee || selectData.candidateUsers" @handleUserSelect="userSelect"></flow-user>
      <div slot="footer" class="dialog-footer">
        <el-button size="small" @click="userVisible = false">取 消</el-button>
        <el-button size="small" type="primary" @click="checkUserComplete">确 定</el-button>
      </div>
    </el-dialog>

    <!--选择角色-->
    <el-dialog
      title="选择候选角色"
      :visible.sync="roleVisible"
      width="60%"
      :close-on-press-escape="false"
      :show-close="false"
    >
      <flow-role v-if="roleVisible" :selectValues="selectData.candidateGroups" @handleRoleSelect="roleSelect"></flow-role>
      <div slot="footer" class="dialog-footer">
        <el-button size="small" @click="roleVisible = false">取 消</el-button>
        <el-button size="small" type="primary" @click="checkRoleComplete">确 定</el-button>
      </div>
    </el-dialog>

    <!--选择表达式-->
    <el-dialog
      title="选择表达式"
      :visible.sync="expVisible"
      width="60%"
      :close-on-press-escape="false"
      :show-close="false"
    >
      <flow-exp v-if="expVisible" :selectValues="selectData.exp" @handleSingleExpSelect="expSelect"></flow-exp>
      <div slot="footer" class="dialog-footer">
        <el-button size="small" @click="expVisible = false">取 消</el-button>
        <el-button size="small" type="primary" @click="checkExpComplete">确 定</el-button>
      </div>
    </el-dialog>


  </div>
</template>

<script>
import FlowUser from '@/components/flow/User'
import FlowRole from '@/components/flow/Role'
import FlowExp from '@/components/flow/Expression'
import ElInputTag from '@/components/flow/ElInputTag'
import {StrUtil} from '@/utils/StrUtil'

export default {
  name: "TaskPanel",
  components: {
    FlowUser,
    FlowRole,
    FlowExp,
    ElInputTag
  },
  /** 组件传值  */
  props : {
    id: {
      type: String,
      required: true
    },
  },
  data() {
    return {
      userVisible: false,
      roleVisible: false,
      expVisible: false,
      isIndeterminate: true,
      checkType: 'single', // 选类
      userType: '',
      userTypeOption: [
        {label: '指定人员', value: 'assignee'},
        {label: '候选人员', value: 'candidateUsers'},
        {label: '候选角色', value: 'candidateGroups'}
      ],
      checkAll: false,
      bpmnFormData: {
        userType: "",
        assignee: "",
        candidateUsers: "",
        candidateGroups: "",
        dueDate: "",
        priority: "",
        dataType: "",
        expId: "",
      },
      // 数据回显
      selectData: {
        assignee: null,
        candidateUsers: null,
        candidateGroups: null,
        exp: null,
      },
      otherExtensionList:[],
    }
  },

  /** 传值监听 */
  watch: {
    id: {
      handler(newVal) {
        if (StrUtil.isNotBlank(newVal)) {
          this.resetTaskForm();
        }
      },
      immediate: true, // 立即生效
    },
  },
  created() {

  },
  methods: {
    // 初始化表单
    resetTaskForm() {
      // 初始化设为空值
      this.bpmnFormData = {
        userType: "",
        assignee: "",
        candidateUsers: "",
        candidateGroups: "",
        dueDate: "",
        priority: "",
        dataType: "",
        expId: "",
      }
      this.selectData = {
        assignee: null,
        candidateUsers: null,
        candidateGroups: null,
        exp: null,
      }
      // 流程节点信息上取值
      for (let key in this.bpmnFormData) {
        const value = this.modelerStore.element?.businessObject[key] || this.bpmnFormData[key];
        this.$set(this.bpmnFormData, key, value);
      }
      // 人员信息回显
      this.checkValuesEcho(this.bpmnFormData);
    },

    // 更新节点信息
    updateElementTask(key) {
      const taskAttr = Object.create(null);
      taskAttr[key] = this.bpmnFormData[key] || "";
      this.modelerStore.modeling.updateProperties(this.modelerStore.element, taskAttr);
    },

    // 更新自定义流程节点/参数信息
    updateCustomElement(key, value) {
      const taskAttr = Object.create(null);
      taskAttr[key] = value;
      this.modelerStore.modeling.updateProperties(this.modelerStore.element, taskAttr);
    },

    // 更新人员类型
    updateUserType(val) {
      // 删除xml中已选择数据类型节点
      this.deleteFlowAttar();
      delete this.modelerStore.element.businessObject[`userType`]
      // 清除已选人员数据
      this.bpmnFormData[val] = null;
      this.selectData = {
        assignee: null,
        candidateUsers: null,
        candidateGroups: null,
        exp: null,
      }
      // 写入userType节点信息到xml
      this.updateCustomElement('userType', val);
    },

    // 设计器右侧表单数据回显
    checkValuesEcho(formData) {
      if (StrUtil.isNotBlank(formData.expId)) {
        this.getExpList(formData.expId, formData.userType);
      } else {
        if ("candidateGroups" === formData.userType) {
          this.getRoleList(formData[formData.userType], formData.userType);
        } else {
          this.getUserList(formData[formData.userType], formData.userType);
        }
      }
    },

    // 获取表达式信息
    getExpList(val, key) {
      if (StrUtil.isNotBlank(val)) {
        this.bpmnFormData[key] = this.modelerStore.expList?.find(item => item.id.toString() === val).name;
        this.selectData.exp = this.modelerStore.expList?.find(item => item.id.toString() === val).id;
      }
    },

    // 获取人员信息
    getUserList(val, key) {
      if (StrUtil.isNotBlank(val)) {
        const newArr = this.modelerStore.userList?.filter(i => val.split(',').includes(i.userId.toString()))
        this.bpmnFormData[key] = newArr.map(item => item.nickName).join(',');
        if ('assignee' === key) {
          this.selectData[key] = newArr.find(item => item.userId.toString() === val).userId;
        } else {
          this.selectData[key] = newArr.map(item => item.userId);
        }
      }
    },

    // 获取角色信息
    getRoleList(val, key) {
      if (StrUtil.isNotBlank(val)) {
        const newArr = this.modelerStore.roleList?.filter(i => val.split(',').includes(i.roleId.toString()))
        this.bpmnFormData[key] = newArr.map(item => item.roleName).join(',');
        if ('assignee' === key) {
          this.selectData[key] = newArr.find(item => item.roleId.toString() === val).roleId;
        } else {
          this.selectData[key] = newArr.map(item => item.roleId);
        }
      }
    },

    // ------ 流程审批人员信息弹出框 start---------

    /*单选人员*/
    singleUserCheck() {
      this.userVisible = true;
      this.checkType = "single";
    },

    /*多选人员*/
    multipleUserCheck() {
      this.userVisible = true;
      this.checkType = "multiple";
    },

    /*单选角色*/
    singleRoleCheck() {
      this.roleVisible = true;
      this.checkType = "single";
    },

    /*多选角色*/
    multipleRoleCheck() {
      this.roleVisible = true;
    },

    /*单选表达式*/
    singleExpCheck() {
      this.expVisible = true;
    },

    // 表达式选中数据
    expSelect(selection) {
      if (selection) {
        this.deleteFlowAttar();
        this.bpmnFormData[this.bpmnFormData.userType] = selection.name;
        this.updateCustomElement('dataType', selection.dataType);
        this.updateCustomElement('expId', selection.id.toString());
        this.updateCustomElement(this.bpmnFormData.userType, selection.expression);
        this.handleSelectData("exp", selection.id);
      }
    },

    // 用户选中数据 TODO: 后面更改为 点击确认按钮再赋值人员信息
    userSelect(selection) {
      if (selection) {
        this.deleteFlowAttar();
        this.updateCustomElement('dataType', 'fixed');
        if (selection instanceof Array) {
          const userIds = selection.map(item => item.userId);
          const nickName = selection.map(item => item.nickName);
          // userType = candidateUsers
          this.bpmnFormData[this.bpmnFormData.userType] = nickName.join(',');
          this.updateCustomElement(this.bpmnFormData.userType, userIds.join(','));
          this.handleSelectData(this.bpmnFormData.userType, userIds);
        } else {
          // userType = assignee
          this.bpmnFormData[this.bpmnFormData.userType] = selection.nickName;
          this.updateCustomElement(this.bpmnFormData.userType, selection.userId);
          this.handleSelectData(this.bpmnFormData.userType, selection.userId);
        }
      }
    },

    // 角色选中数据
    roleSelect(selection, name) {
      if (selection && name) {
        this.deleteFlowAttar();
        this.bpmnFormData[this.bpmnFormData.userType] = name;
        this.updateCustomElement('dataType', 'fixed');
        // userType = candidateGroups
        this.updateCustomElement(this.bpmnFormData.userType, selection);
        this.handleSelectData(this.bpmnFormData.userType, selection);
      }
    },

    // 处理人员回显
    handleSelectData(key, value) {
      for (let oldKey in this.selectData) {
        if (key !== oldKey) {
          this.$set(this.selectData, oldKey, null);
        } else {
          this.$set(this.selectData, oldKey, value);
        }
      }
    },

    /*用户选中赋值*/
    checkUserComplete() {
      this.userVisible = false;
      this.checkType = "";
    },

    /*候选角色选中赋值*/
    checkRoleComplete() {
      this.roleVisible = false;
    },

    /*表达式选中赋值*/
    checkExpComplete() {
      this.expVisible = false;
    },

    // 删除节点
    deleteFlowAttar() {
      delete this.modelerStore.element.businessObject[`dataType`]
      delete this.modelerStore.element.businessObject[`expId`]
      delete this.modelerStore.element.businessObject[`assignee`]
      delete this.modelerStore.element.businessObject[`candidateUsers`]
      delete this.modelerStore.element.businessObject[`candidateGroups`]
    },

    // 去重数据
    unique(arr, code) {
      const res = new Map();
      return arr.filter((item) => !res.has(item[code]) && res.set(item[code], 1));
    },

    // 更新扩展属性信息
    updateElementExtensions(properties) {
      const extensions = this.modelerStore.moddle.create("bpmn:ExtensionElements", {
        values: this.otherExtensionList.concat([properties])
      });

      this.modelerStore.modeling.updateProperties(this.modelerStore.element, {
        extensionElements: extensions
      });
    }
  }
}
</script>
