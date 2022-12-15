<template>
  <div class="app-container">
    <el-card class="box-card" >
        <div slot="header" class="clearfix">
          <span class="el-icon-document">基础信息</span>
          <el-button style="float: right;" type="primary" @click="goBack">返回</el-button>
        </div>
      <!--流程处理表单模块-->
      <el-col :span="16" :offset="6">
          <div>
            <parser :key="new Date().getTime()" :form-conf="variablesData" />
          </div>
          <div style="margin-left:10%;margin-bottom: 20px;font-size: 14px;">
            <el-button  icon="el-icon-edit-outline" type="success" size="mini" @click="handleComplete">审批</el-button>
<!--                <el-button  icon="el-icon-edit-outline" type="primary" size="mini" @click="handleDelegate">委派</el-button>-->
<!--                <el-button  icon="el-icon-edit-outline" type="primary" size="mini" @click="handleAssign">转办</el-button>-->
<!--                <el-button  icon="el-icon-edit-outline" type="primary" size="mini" @click="handleDelegate">签收</el-button>-->
            <el-button  icon="el-icon-refresh-left" type="warning" size="mini" @click="handleReturn">退回</el-button>
            <el-button  icon="el-icon-circle-close" type="danger" size="mini" @click="handleReject">驳回</el-button>
          </div>
     </el-col>
    </el-card>

    <!--流程流转记录-->
    <el-card class="box-card" v-if="flowRecordList">
          <div slot="header" class="clearfix">
            <span class="el-icon-notebook-1">审批记录</span>
          </div>
          <el-col :span="16" :offset="4" >
            <div class="block">
              <el-timeline>
                <el-timeline-item
                  v-for="(item,index ) in flowRecordList"
                  :key="index"
                  :icon="setIcon(item.finishTime)"
                  :color="setColor(item.finishTime)"
                >
                  <p style="font-weight: 700">{{item.taskName}}</p>
                  <el-card :body-style="{ padding: '10px' }">
                    <el-descriptions class="margin-top" :column="1" size="small" border>
                      <el-descriptions-item v-if="item.assigneeName" label-class-name="my-label">
                        <template slot="label"><i class="el-icon-user"></i>实际办理</template>
                        {{item.assigneeName}}
                        <el-tag type="info" size="mini">{{item.deptName}}</el-tag>
                      </el-descriptions-item>
                      <el-descriptions-item v-if="item.candidate" label-class-name="my-label">
                        <template slot="label"><i class="el-icon-user"></i>候选办理</template>
                        {{item.candidate}}
                      </el-descriptions-item>
                      <el-descriptions-item label-class-name="my-label">
                        <template slot="label"><i class="el-icon-date"></i>接收时间</template>
                        {{item.createTime}}
                      </el-descriptions-item>
                      <el-descriptions-item v-if="item.finishTime" label-class-name="my-label">
                        <template slot="label"><i class="el-icon-date"></i>处理时间</template>
                        {{item.finishTime}}
                      </el-descriptions-item>
                      <el-descriptions-item v-if="item.duration"  label-class-name="my-label">
                        <template slot="label"><i class="el-icon-time"></i>耗时</template>
                        {{item.duration}}
                      </el-descriptions-item>
                      <el-descriptions-item v-if="item.comment" label-class-name="my-label">
                        <template slot="label"><i class="el-icon-tickets"></i>处理意见</template>
                        {{item.comment.comment}}
                      </el-descriptions-item>
                    </el-descriptions>
                  </el-card>
                </el-timeline-item>
              </el-timeline>
            </div>
          </el-col>
      </el-card>
    <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span class="el-icon-picture-outline">流程图</span>
        </div>
        <flow :xmlData="xmlData" :taskData="taskList"></flow>
    </el-card>

    <!--审批正常流程-->
    <el-dialog :title="completeTitle" :visible.sync="completeOpen" width="60%" append-to-body>
      <el-form ref="taskForm" :model="taskForm">
        <el-form-item prop="targetKey">
<!--          <el-row :gutter="24">-->
            <flow-user v-if="checkSendUser" :checkType="checkType"  @handleUserSelect="handleUserSelect"></flow-user>
            <flow-role v-if="checkSendRole" @handleRoleSelect="handleRoleSelect"></flow-role>
<!--          </el-row>-->
        </el-form-item>
        <el-form-item label="处理意见" label-width="80px" prop="comment" :rules="[{ required: true, message: '请输入处理意见', trigger: 'blur' }]">
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
        <el-form ref="taskForm" :model="taskForm" label-width="80px" >
            <el-form-item label="退回节点" prop="targetKey">
              <el-radio-group v-model="taskForm.targetKey">
                <el-radio-button
                  v-for="item in returnTaskList"
                  :key="item.id"
                  :label="item.id"
                >{{item.name}}</el-radio-button>
              </el-radio-group>
            </el-form-item>
          <el-form-item label="退回意见" prop="comment" :rules="[{ required: true, message: '请输入意见', trigger: 'blur' }]">
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
      <el-form ref="taskForm" :model="taskForm" label-width="80px" >
        <el-form-item label="驳回意见" prop="comment" :rules="[{ required: true, message: '请输入意见', trigger: 'blur' }]">
          <el-input style="width: 50%" type="textarea" v-model="taskForm.comment" placeholder="请输入意见"/>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
          <el-button @click="rejectOpen = false">取 消</el-button>
          <el-button type="primary" @click="taskReject">确 定</el-button>
        </span>
    </el-dialog>
  </div>
</template>

<script>
import {flowRecord} from "@/api/flowable/finished";
import FlowUser from '@/components/flow/User'
import FlowRole from '@/components/flow/Role'
import Parser from '@/components/parser/Parser'
import {definitionStart, getProcessVariables, readXml, getFlowViewer} from "@/api/flowable/definition";
import {complete, rejectTask, returnList, returnTask, getNextFlowNode, delegate} from "@/api/flowable/todo";
import flow from '@/views/flowable/task/record/flow'
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
      taskList: [],
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
      taskForm:{
        returnTaskShow: false, // 是否展示回退表单
        delegateTaskShow: false, // 是否展示回退表单
        defaultTaskShow: true, // 默认处理
        sendUserShow: false, // 审批用户
        comment:"", // 意见内容
        procInsId: "", // 流程实例编号
        instanceId: "", // 流程实例编号
        deployId: "",  // 流程定义编号
        taskId: "" ,// 流程任务编号
        procDefId: "",  // 流程编号
        vars: "",
        targetKey:""
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
      userData:[],
      checkSendUser: false, // 是否展示人员选择模块
      checkSendRole: false,// 是否展示角色选择模块
      checkType: 'single', // 选择类型
    };
  },
  created() {
    this.taskForm.deployId = this.$route.query && this.$route.query.deployId;
    this.taskForm.taskId  = this.$route.query && this.$route.query.taskId;
    this.taskForm.procInsId = this.$route.query && this.$route.query.procInsId;
    this.taskForm.executionId = this.$route.query && this.$route.query.executionId;
    this.taskForm.instanceId = this.$route.query && this.$route.query.procInsId;
    // 回显流程记录
    this.getFlowViewer(this.taskForm.procInsId,this.taskForm.executionId);
    this.getModelDetail(this.taskForm.deployId);
    // 流程任务重获取变量表单
    if (this.taskForm.taskId){
      this.processVariables(this.taskForm.taskId)
      this.getNextFlowNode(this.taskForm.taskId)
    }
    this.getFlowRecordList(this.taskForm.procInsId, this.taskForm.deployId);
  },
  methods: {
    /** 查询用户列表 */
    getList() {
      listUser(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
          this.userList = response.rows;
          this.total = response.total;
        }
      );
    },
    // 筛选节点
    filterNode(value, data) {
      if (!value) return true;
      return data.label.indexOf(value) !== -1;
    },
    // 节点单击事件
    handleNodeClick(data) {
      this.queryParams.deptId = data.id;
      this.getList();
    },
    /** xml 文件 */
    getModelDetail(deployId) {
      // 发送请求，获取xml
      readXml(deployId).then(res => {
        this.xmlData = res.data
      })
    },
    getFlowViewer(procInsId,executionId) {
      getFlowViewer(procInsId,executionId).then(res => {
        this.taskList = res.data
      })
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
      console.log(selection,"handleUserSelect")
      if (selection) {
        const selectVal = selection.map(item => item.userId);
        if (selectVal instanceof Array) {
          this.taskForm.values = {
            "approval": selectVal.join(',')
          }
        } else {
          this.taskForm.values = {
            "approval": selectVal
          }
        }
      }
    },
    // 角色信息选中数据
    handleRoleSelect(selection) {
      console.log(selection,"handleRoleSelect")
      if (selection) {
        if (selection instanceof Array) {
          const selectVal = selection.map(item => item.roleId);
          this.taskForm.values = {
            "approval": selectVal.join(',')
          }
        } else {
          this.taskForm.values = {
            "approval": selection
          }
        }
      }
    },
    /** 流程变量赋值 */
    handleCheckChange(val) {
      if (val instanceof Array) {
        this.taskForm.values = {
          "approval": val.join(',')
        }
      } else {
        this.taskForm.values = {
          "approval": val
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
          this.variablesData = res.data.variables;
        });
      }
    },
    /** 根据当前任务或者流程设计配置的下一步节点 */
    getNextFlowNode(taskId) {
      // 根据当前任务或者流程设计配置的下一步节点 todo 暂时未涉及到考虑网关、表达式和多节点情况
      const params = {taskId: taskId}
      getNextFlowNode(params).then(res => {
        const data = res.data;
        if (data) {
          if (data.type === 'assignee') { // 指定人员
            this.checkSendUser = true;
            this.checkType = "single";
          } else if (data.type === 'candidateUsers') {  // 候选人员(多个)
            this.checkSendUser = true;
            this.checkType = "multiple";
          } else if (data.type === 'candidateGroups') { // 指定组(所属角色接收任务)
            this.checkSendRole = true;
          } else if (data.type === 'multiInstance') { // 会签?
            this.checkSendUser = true;
          }
        }
      })
    },
    /** 加载审批任务弹框 */
    handleComplete() {
      this.completeOpen = true;
      this.completeTitle = "流程审批";
    },
    /** 用户审批任务 */
    taskComplete() {
      if (!this.taskForm.values && this.checkSendUser){
        this.$modal.msgError("请选择流程接收人员!");
        return;
      }
      if (!this.taskForm.values && this.checkSendRole){
        this.$modal.msgError("请选择流程接收角色组!");
        return;
      }
      if (!this.taskForm.comment){
        this.$modal.msgError("请输入审批意见!");
        return;
      }
      console.log(this.taskForm,"流程审批提交表单数据")
      complete(this.taskForm).then(response => {
        this.$modal.msgSuccess(response.msg);
        this.goBack();
      });
    },
    /** 委派任务 */
    handleDelegate() {
      this.taskForm.delegateTaskShow = true;
      this.taskForm.defaultTaskShow = false;
    },
    handleAssign(){

    },
    /** 返回页面 */
    goBack() {
      // 关闭当前标签页并返回上个页面
      this.$store.dispatch("tagsView/delView", this.$route);
      this.$router.go(-1)
    },
    /** 接收子组件传的值 */
    getData(data) {
      if (data) {
        const variables = [];
        data.fields.forEach(item => {
          let variableData = {};
          variableData.label = item.__config__.label
          // 表单值为多个选项时
          if (item.__config__.defaultValue instanceof Array) {
            const array = [];
            item.__config__.defaultValue.forEach(val => {
              array.push(val)
            })
            variableData.val = array;
          } else {
            variableData.val = item.__config__.defaultValue
          }
          variables.push(variableData)
        })
        this.variables = variables;
      }
    },
    /** 申请流程表单数据提交 */
    submitForm(data) {
      const that = this
      if (data) {
        const variables = data.valData;
        const formData = data.formData;
        formData.disabled = true;
        formData.formBtns = false;
        if (that.taskForm.procDefId) {
          variables.variables = formData;
           // 启动流程并将表单数据加入流程变量
          definitionStart(that.taskForm.procDefId, JSON.stringify(variables)).then(res => {
            that.$modal.msgSuccess(res.msg);
            that.goBack();
          })
        }
      }
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
        this.taskForm.values = null;
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
      this.taskForm.sendUserShow = true;
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
      this.taskForm.sendUserShow = true;
      this.returnTaskList = [];
    },
  }
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
