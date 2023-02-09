<template>
  <div class="app-container">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span class="el-icon-document">待办任务</span>
        <el-tag style="margin-left:10px">发起人:{{ startUser }}</el-tag>
        <el-tag>任务节点:{{ taskName }}</el-tag>
        <el-button style="float: right;" size="mini" type="danger" @click="goBack">关闭</el-button>
      </div>
      <el-tabs tab-position="top" v-model="activeName" @tab-click="handleClick">
        <!--表单信息-->
        <el-tab-pane label="表单信息" name="1">
          <el-col :span="16" :offset="4">
            <div class="test-form">
              <!--              <parser :key="new Date().getTime()" :form-conf="variablesData"/>-->
              <parser :key="new Date().getTime()" :form-conf="variablesData" @submit="submitForm" ref="parser"/>

            </div>
            <div style="margin-left:15%;margin-bottom: 20px;font-size: 14px;">
              <el-button v-if="!formKeyExist" icon="el-icon-edit-outline" type="success" size="mini"
                         @click="handleComplete">审批
              </el-button>
              <!--                <el-button  icon="el-icon-edit-outline" type="primary" size="mini" @click="handleDelegate">委派</el-button>-->
              <!--                <el-button  icon="el-icon-edit-outline" type="primary" size="mini" @click="handleAssign">转办</el-button>-->
              <!--                <el-button  icon="el-icon-edit-outline" type="primary" size="mini" @click="handleDelegate">签收</el-button>-->
              <!--              <el-button icon="el-icon-refresh-left" type="warning" size="mini" @click="handleReturn">退回</el-button>-->
              <!--              <el-button icon="el-icon-circle-close" type="danger" size="mini" @click="handleReject">驳回</el-button>-->
            </div>
          </el-col>
        </el-tab-pane>
        <!--流程流转记录-->
        <el-tab-pane label="流转记录" name="2">
          <!--flowRecordList-->
          <el-col :span="16" :offset="4">
            <div class="block">
              <el-timeline>
                <el-timeline-item
                  v-for="(item,index ) in flowRecordList"
                  :key="index"
                  :icon="setIcon(item.finishTime)"
                  :color="setColor(item.finishTime)"
                >
                  <p style="font-weight: 700">{{ item.taskName }}</p>
                  <el-card :body-style="{ padding: '10px' }">
                    <el-descriptions class="margin-top" :column="1" size="small" border>
                      <el-descriptions-item v-if="item.assigneeName" label-class-name="my-label">
                        <template slot="label"><i class="el-icon-user"></i>办理人</template>
                        {{ item.assigneeName }}
                        <el-tag type="info" size="mini">{{ item.deptName }}</el-tag>
                      </el-descriptions-item>
                      <el-descriptions-item v-if="item.candidate" label-class-name="my-label">
                        <template slot="label"><i class="el-icon-user"></i>候选办理</template>
                        {{ item.candidate }}
                      </el-descriptions-item>
                      <el-descriptions-item label-class-name="my-label">
                        <template slot="label"><i class="el-icon-date"></i>接收时间</template>
                        {{ item.createTime }}
                      </el-descriptions-item>
                      <el-descriptions-item v-if="item.finishTime" label-class-name="my-label">
                        <template slot="label"><i class="el-icon-date"></i>处理时间</template>
                        {{ item.finishTime }}
                      </el-descriptions-item>
                      <el-descriptions-item v-if="item.duration" label-class-name="my-label">
                        <template slot="label"><i class="el-icon-time"></i>耗时</template>
                        {{ item.duration }}
                      </el-descriptions-item>
                      <el-descriptions-item v-if="item.comment" label-class-name="my-label">
                        <template slot="label"><i class="el-icon-tickets"></i>处理意见</template>
                        {{ item.comment.comment }}
                      </el-descriptions-item>
                    </el-descriptions>
                  </el-card>
                </el-timeline-item>
              </el-timeline>
            </div>
          </el-col>
        </el-tab-pane>
        <!--流程图-->
        <el-tab-pane label="流程图" name="3">
          <flow :flowData="flowData"/>
        </el-tab-pane>
      </el-tabs>
      <!--审批任务-->
      <el-dialog :title="completeTitle" :visible.sync="completeOpen" width="60%" append-to-body>
        <el-form ref="taskForm" :model="taskForm">
          <el-form-item prop="targetKey">
            <flow-user v-if="checkSendUser" :checkType="checkType" @handleUserSelect="handleUserSelect"></flow-user>
            <flow-role v-if="checkSendRole" @handleRoleSelect="handleRoleSelect"></flow-role>
          </el-form-item>
          <el-form-item label="处理意见" label-width="80px" prop="comment"
                        :rules="[{ required: true, message: '请输入处理意见', trigger: 'blur' }]">
            <el-input type="textarea" v-model="taskForm.comment" placeholder="请输入处理意见"/>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="completeOpen = false">取 消</el-button>
          <el-button type="primary" @click="taskComplete">确 定</el-button>
        </span>
      </el-dialog>
      <!--退回流程-->
      <el-dialog :title="returnTitle" :visible.sync="returnOpen" width="40%" append-to-body>
        <el-form ref="taskForm" :model="taskForm" label-width="80px">
          <el-form-item label="退回节点" prop="targetKey">
            <el-radio-group v-model="taskForm.targetKey">
              <el-radio-button
                v-for="item in returnTaskList"
                :key="item.id"
                :label="item.id"
              >{{ item.name }}
              </el-radio-button>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="退回意见" prop="comment"
                        :rules="[{ required: true, message: '请输入意见', trigger: 'blur' }]">
            <el-input style="width: 50%" type="textarea" v-model="taskForm.comment" placeholder="请输入意见"/>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
              <el-button @click="returnOpen = false">取 消</el-button>
              <el-button type="primary" @click="taskReturn">确 定</el-button>
          </span>
      </el-dialog>
      <!--驳回流程-->
      <el-dialog :title="rejectTitle" :visible.sync="rejectOpen" width="40%" append-to-body>
        <el-form ref="taskForm" :model="taskForm" label-width="80px">
          <el-form-item label="驳回意见" prop="comment"
                        :rules="[{ required: true, message: '请输入意见', trigger: 'blur' }]">
            <el-input style="width: 50%" type="textarea" v-model="taskForm.comment" placeholder="请输入意见"/>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
            <el-button @click="rejectOpen = false">取 消</el-button>
            <el-button type="primary" @click="taskReject">确 定</el-button>
          </span>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
import {flowRecord} from "@/api/flowable/finished";
import FlowUser from '@/components/flow/User'
import FlowRole from '@/components/flow/Role'
import Parser from '@/components/parser/Parser'
import {getProcessVariables, flowXmlAndNode, definitionStart} from "@/api/flowable/definition";
import {
  complete,
  rejectTask,
  returnList,
  returnTask,
  getNextFlowNode,
  delegate,
  flowTaskForm,
} from "@/api/flowable/todo";
import flow from '@/views/flowable/task/todo/detail/flow'
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
import {listUser} from "@/api/system/user";

export default {
  name: "Record",
  components: {
    Parser,
    flow,
    FlowUser,
    FlowRole,
  },
  props: {},
  data() {
    return {
      // 模型xml数据
      xmlData: "",
      flowData: {},
      activeName: '1',
      // 部门名称
      deptName: undefined,
      // 部门树选项
      // 用户表格数据
      userList: null,
      defaultProps: {
        children: "children",
        label: "label"
      },
      // 查询参数
      queryParams: {
        deptId: undefined
      },
      // 遮罩层
      loading: true,
      flowRecordList: [], // 流程流转数据
      formConfCopy: {},
      src: null,
      rules: {}, // 表单校验
      variablesForm: {}, // 流程变量数据
      taskForm: {
        returnTaskShow: false, // 是否展示回退表单
        delegateTaskShow: false, // 是否展示回退表单
        defaultTaskShow: true, // 默认处理
        comment: "", // 意见内容
        procInsId: "", // 流程实例编号
        instanceId: "", // 流程实例编号
        deployId: "",  // 流程定义编号
        taskId: "",// 流程任务编号
        procDefId: "",  // 流程编号
        targetKey: "",
        variables: {
          variables: {}
        },
      },
      assignee: null,
      formConf: {}, // 默认表单数据
      variables: [], // 流程变量数据
      variablesData: {}, // 流程变量数据
      returnTaskList: [],  // 回退列表数据
      completeTitle: null,
      completeOpen: false,
      returnTitle: null,
      returnOpen: false,
      rejectOpen: false,
      rejectTitle: null,
      userData: [],
      checkSendUser: false, // 是否展示人员选择模块
      checkSendRole: false,// 是否展示角色选择模块
      checkType: 'single', // 选择类型
      taskName: null, // 任务节点
      startUser: null, // 发起人信息,
      multiInstanceVars: '', // 会签节点
      formKeyExist: false, // 当前节点是否存在表单
    };
  },
  created() {
    if (this.$route.query) {
      this.taskName = this.$route.query.taskName;
      this.startUser = this.$route.query.startUser;
      this.taskForm.deployId = this.$route.query.deployId;
      this.taskForm.taskId = this.$route.query.taskId;
      this.taskForm.procInsId = this.$route.query.procInsId;
      this.taskForm.executionId = this.$route.query.executionId;
      this.taskForm.instanceId = this.$route.query.procInsId;
      // 流程任务获取变量信息
      if (this.taskForm.taskId) {
        this.processVariables(this.taskForm.taskId)
        this.getFlowTaskForm(this.taskForm.taskId)
      }
      this.getFlowRecordList(this.taskForm.procInsId, this.taskForm.deployId);
    }
  },
  methods: {
    handleClick(tab, event) {
      if (tab.name === '3') {
        flowXmlAndNode({procInsId: this.taskForm.procInsId, deployId: this.taskForm.deployId}).then(res => {
          this.flowData = res.data;
        })
      }
    },
    setIcon(val) {
      if (val) {
        return "el-icon-check";
      } else {
        return "el-icon-time";
      }
    },
    setColor(val) {
      if (val) {
        return "#2bc418";
      } else {
        return "#b3bdbb";
      }
    },
    // 用户信息选中数据
    handleUserSelect(selection) {
      if (selection) {
        if (selection instanceof Array) {
          const selectVal = selection.map(item => item.userId);
          if (this.multiInstanceVars) {
            this.$set(this.taskForm.variables, this.multiInstanceVars, selectVal);
          } else {
            this.$set(this.taskForm.variables, "approval", selectVal.join(','));
          }
        } else {
          this.$set(this.taskForm.variables, "approval", selection.userId.toString());
        }
      }
    },
    // 角色信息选中数据
    handleRoleSelect(selection) {
      if (selection) {
        if (selection instanceof Array) {
          const selectVal = selection.map(item => item.roleId);
          this.$set(this.taskForm.variables, "approval", selectVal.join(','));
        } else {
          this.$set(this.taskForm.variables, "approval", selection);
        }
      }
    },
    /** 流程流转记录 */
    getFlowRecordList(procInsId, deployId) {
      const that = this
      const params = {procInsId: procInsId, deployId: deployId}
      flowRecord(params).then(res => {
        that.flowRecordList = res.data.flowList;
      }).catch(res => {
        this.goBack();
      })
    },
    fillFormData(form, data) {
      form.fields.forEach(item => {
        const val = data[item.__vModel__]
        if (val) {
          item.__config__.defaultValue = val
        }
      })
    },
    /** 获取流程变量内容 */
    processVariables(taskId) {
      if (taskId) {
        // 提交流程申请时填写的表单存入了流程变量中后续任务处理时需要展示
        getProcessVariables(taskId).then(res => {
          // this.variablesData = res.data.variables;
        });
      }
    },
    /** 流程节点表单 */
    getFlowTaskForm(taskId) {
      if (taskId) {
        // 提交流程申请时填写的表单存入了流程变量中后续任务处理时需要展示
        flowTaskForm({taskId: taskId}).then(res => {
          this.variablesData = res.data.formData;
          this.taskForm.variables = res.data.formData;
          this.formKeyExist = res.data.formKeyExist;
        });
      }
    },
    /** 加载审批任务弹框 */
    handleComplete() {
      // this.completeOpen = true;
      // this.completeTitle = "流程审批";
      this.submitForm(null);
    },
    /** 用户审批任务 */
    taskComplete() {
      if (!this.taskForm.variables && this.checkSendUser) {
        this.$modal.msgError("请选择流程接收人员!");
        return;
      }
      if (!this.taskForm.variables && this.checkSendRole) {
        this.$modal.msgError("请选择流程接收角色组!");
        return;
      }
      if (!this.taskForm.comment) {
        this.$modal.msgError("请输入审批意见!");
        return;
      }
      if (this.taskForm && this.formKeyExist) {
        // 表单是否禁用
        this.taskForm.formData.formData.disabled = true;
        // 是否显示按钮
        this.taskForm.formData.formData.formBtns = false;
        this.taskForm.variables = Object.assign({}, this.taskForm.variables, this.taskForm.formData.valData);
        this.taskForm.variables.variables = this.taskForm.formData.formData;
        complete(this.taskForm).then(response => {
          this.$modal.msgSuccess(response.msg);
          this.goBack();
        });
      } else {
        // 流程设计人员类型配置为固定人员接收任务时,直接提交任务到下一步
        complete(this.taskForm).then(response => {
          this.$modal.msgSuccess(response.msg);
          this.goBack();
        });
      }
    },
    /** 委派任务 */
    handleDelegate() {
      this.taskForm.delegateTaskShow = true;
      this.taskForm.defaultTaskShow = false;
    },
    handleAssign() {

    },
    /** 返回页面 */
    goBack() {
      // 关闭当前标签页并返回上个页面
      this.$store.dispatch("tagsView/delView", this.$route);
      this.$router.go(-1)
    },
    /** 驳回任务 */
    handleReject() {
      this.rejectOpen = true;
      this.rejectTitle = "驳回流程";
    },
    /** 驳回任务 */
    taskReject() {
      this.$refs["taskForm"].validate(valid => {
        if (valid) {
          rejectTask(this.taskForm).then(res => {
            this.$modal.msgSuccess(res.msg);
            this.goBack();
          });
        }
      });
    },
    /** 可退回任务列表 */
    handleReturn() {
      this.returnOpen = true;
      this.returnTitle = "退回流程";
      returnList(this.taskForm).then(res => {
        this.returnTaskList = res.data;
        this.taskForm.variables = null;
      })
    },
    /** 提交退回任务 */
    taskReturn() {
      this.$refs["taskForm"].validate(valid => {
        if (valid) {
          returnTask(this.taskForm).then(res => {
            this.$modal.msgSuccess(res.msg);
            this.goBack()
          });
        }
      });
    },
    /** 取消回退任务按钮 */
    cancelTask() {
      this.taskForm.returnTaskShow = false;
      this.taskForm.defaultTaskShow = true;
      this.returnTaskList = [];
    },
    /** 委派任务 */
    submitDeleteTask() {
      this.$refs["taskForm"].validate(valid => {
        if (valid) {
          delegate(this.taskForm).then(response => {
            this.$modal.msgSuccess(response.msg);
            this.goBack();
          });
        }
      });
    },
    /** 取消回退任务按钮 */
    cancelDelegateTask() {
      this.taskForm.delegateTaskShow = false;
      this.taskForm.defaultTaskShow = true;
      this.returnTaskList = [];
    },
    /** 申请流程表单数据提交 */
    submitForm(formData) {
      // 根据当前任务或者流程设计配置的下一步节点 todo 暂时未涉及到考虑网关、表达式和多节点情况
      const params = {taskId: this.taskForm.taskId}
      getNextFlowNode(params).then(res => {
        const data = res.data;
        this.taskForm.formData = formData;
        if (data) {
          if (data.dataType === 'dynamic') {
            if (data.type === 'assignee') { // 指定人员
              this.checkSendUser = true;
              this.checkType = "single";
            } else if (data.type === 'candidateUsers') {  // 候选人员(多个)
              this.checkSendUser = true;
              this.checkType = "multiple";
            } else if (data.type === 'candidateGroups') { // 指定组(所属角色接收任务)
              this.checkSendRole = true;
            } else { // 会签
              // 流程设计指定的 elementVariable 作为会签人员列表
              this.multiInstanceVars = data.vars;
              this.checkSendUser = true;
              this.checkType = "multiple";
            }
          }
        }
        this.completeOpen = true;
        this.completeTitle = "流程审批";
      })
    },
  },
};
</script>
<style lang="scss" scoped>
.test-form {
  margin: 15px auto;
  width: 800px;
  padding: 15px;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both
}

.box-card {
  width: 100%;
  margin-bottom: 20px;
}

.el-tag + .el-tag {
  margin-left: 10px;
}

.my-label {
  background: #E1F3D8;
}
</style>
