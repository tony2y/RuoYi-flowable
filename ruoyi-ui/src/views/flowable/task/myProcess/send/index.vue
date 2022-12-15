<template>
  <div class="app-container">
    <el-card class="box-card" >
      <div slot="header" class="clearfix">
        <span class="el-icon-document">基础信息</span>
        <el-button style="float: right;" type="primary" @click="goBack">返回</el-button>
      </div>
      <!--初始化流程加载表单信息-->
      <el-col :span="16" :offset="4">
        <div class="test-form">
          <parser :key="new Date().getTime()"  :form-conf="formConf" @submit="submitForm" ref="parser" @getData="getData" />
        </div>
      </el-col>
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

    <!--流程图-->
    <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span class="el-icon-picture-outline">流程图</span>
        </div>
        <flow :xmlData="xmlData" :taskData="taskList"></flow>
    </el-card>
  </div>
</template>

<script>
import Parser from '@/components/parser/Parser'
import {definitionStart, readXml} from "@/api/flowable/definition";
import flow from '@/views/flowable/task/record/flow'
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
import {listUser} from "@/api/system/user";
import {flowFormData} from "@/api/flowable/process";
import {getNextFlowNodeByStart} from "@/api/flowable/todo";

export default {
  name: "Record",
  components: {
    Parser,
    flow,
  },
  props: {},
  data() {
    return {
      // 模型xml数据
      xmlData: "",
      taskList: [],
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
      rules: {}, // 表单校验
      variablesForm: {}, // 流程变量数据
      taskForm:{
        multiple: false,
        comment:"", // 意见内容
        procInsId: "", // 流程实例编号
        instanceId: "", // 流程实例编号
        deployId: "",  // 流程定义编号
        taskId: "" ,// 流程任务编号
        procDefId: "",  // 流程编号
        vars: "",
        targetKey:""
      },
      formConf: {}, // 默认表单数据
      variables: [], // 流程变量数据
      completeTitle: null,
      completeOpen: false,
      checkSendUser: false, // 是否展示人员选择模块
      checkSendRole: false,// 是否展示角色选择模块
      checkType: 'single', // 选择类型
    };
  },
  created() {
    this.taskForm.deployId = this.$route.query && this.$route.query.deployId;
    // 初始化表单
    this.taskForm.procDefId  = this.$route.query && this.$route.query.procDefId;
    this.getNextFlowNode(this.taskForm.deployId);
    this.getFlowFormData(this.taskForm.deployId);
    // 回显流程记录
    this.loadModelXml(this.taskForm.deployId);
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
    /** xml 文件 */
    loadModelXml(deployId) {
      // 发送请求，获取xml
      readXml(deployId).then(res => {
        this.xmlData = res.data
      })
    },
    /** 流程表单数据 */
    getFlowFormData(deployId) {
      const that = this
      const params = {deployId: deployId}
      flowFormData(params).then(res => {
        // 流程过程中不存在初始化表单 直接读取的流程变量中存储的表单值
          that.formConf = res.data;
      }).catch(res => {
        this.goBack();
      })
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
      if (data) {
        const variables = data.valData;
        const formData = data.formData;
        formData.disabled = true;
        formData.formBtns = false;
        if (this.taskForm.procDefId) {
          variables.variables = formData;
          // 启动流程并将表单数据加入流程变量
          definitionStart(this.taskForm.procDefId, JSON.stringify(variables)).then(res => {
            this.msgSuccess(res.msg);
            this.goBack();
          })
        }
      }
    },
    /** 根据当前任务获取流程设计配置的下一步节点 */
    getNextFlowNode(deploymentId) {
      // 根据当前任务或者流程设计配置的下一步节点 todo 暂时未涉及到考虑网关、表达式和多节点情况
      const params = {deploymentId: deploymentId}
      getNextFlowNodeByStart(params).then(res => {
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
    // 用户信息选中数据
    handleUserSelect(selection) {
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
