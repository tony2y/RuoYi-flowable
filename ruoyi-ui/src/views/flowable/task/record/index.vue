<template>
  <div class="app-container">
    <el-card class="box-card" >
        <div slot="header" class="clearfix">
          <span class="el-icon-document">基础信息</span>
          <el-button style="float: right;" type="primary" @click="goBack">关闭</el-button>
        </div>

      <!--流程处理表单模块-->
      <el-col :span="16" :offset="6" v-if="variableOpen">
          <div>
            <parser :key="new Date().getTime()" :form-conf="variablesData" />
          </div>
          <div style="margin-left:10%;margin-bottom: 20px;font-size: 14px;" v-if="finished === 'true'">
            <el-button  icon="el-icon-edit-outline" type="success" size="mini" @click="handleComplete">审批</el-button>
<!--                <el-button  icon="el-icon-edit-outline" type="primary" size="mini" @click="handleDelegate">委派</el-button>-->
<!--                <el-button  icon="el-icon-edit-outline" type="primary" size="mini" @click="handleAssign">转办</el-button>-->
<!--                <el-button  icon="el-icon-edit-outline" type="primary" size="mini" @click="handleDelegate">签收</el-button>-->
            <el-button  icon="el-icon-refresh-left" type="warning" size="mini" @click="handleReturn">退回</el-button>
            <el-button  icon="el-icon-circle-close" type="danger" size="mini" @click="handleReject">驳回</el-button>
          </div>
     </el-col>

      <!--初始化流程加载表单信息-->
      <el-col :span="16" :offset="4" v-if="formConfOpen">
        <div class="test-form">
          <parser :key="new Date().getTime()"  :form-conf="formConf" @submit="submitForm" ref="parser" @getData="getData" />
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
                        <template slot="label"><i class="el-icon-user"></i>办理人</template>
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

<!--                    <p  v-if="item.comment">-->
<!--                      <el-tag type="success" v-if="item.comment.type === '1'">  {{item.comment.comment}}</el-tag>-->
<!--                      <el-tag type="warning" v-if="item.comment.type === '2'">  {{item.comment.comment}}</el-tag>-->
<!--                      <el-tag type="danger" v-if="item.comment.type === '3'">  {{item.comment.comment}}</el-tag>-->
<!--                    </p>-->
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
    <el-dialog :title="completeTitle" :visible.sync="completeOpen" :width="checkSendUser? '60%':'40%'" append-to-body>
      <el-form ref="taskForm" :model="taskForm" label-width="80px" >
        <el-form-item  v-if="checkSendUser" prop="targetKey">
          <el-row :gutter="20">
            <!--部门数据-->
            <el-col :span="6" :xs="24">
              <h6>部门列表</h6>
              <div class="head-container">
                <el-input
                  v-model="deptName"
                  placeholder="请输入部门名称"
                  clearable
                  size="small"
                  prefix-icon="el-icon-search"
                  style="margin-bottom: 20px"
                />
              </div>
              <div class="head-container">
                <el-tree
                  :data="deptOptions"
                  :props="defaultProps"
                  :expand-on-click-node="false"
                  :filter-node-method="filterNode"
                  ref="tree"
                  default-expand-all
                  @node-click="handleNodeClick"
                />
              </div>
            </el-col>
            <el-col :span="10" :xs="24">
              <h6>待选人员</h6>
              <el-table
                ref="singleTable"
                :data="userList"
                border
                style="width: 100%"
                @selection-change="handleSelectionChange">
                <el-table-column type="selection" width="50" align="center" />
                <el-table-column label="用户名" align="center" prop="nickName" />
                <el-table-column label="部门" align="center" prop="dept.deptName" />
              </el-table>
            </el-col>
            <el-col :span="8" :xs="24">
              <h6>已选人员</h6>
              <el-tag
                v-for="(user,index) in userData"
                :key="index"
                closable
                @close="handleClose(user)">
                {{user.nickName}} {{user.dept.deptName}}
              </el-tag>
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item label="处理意见" prop="comment" :rules="[{ required: true, message: '请输入处理意见', trigger: 'blur' }]">
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
import Parser from '@/components/parser/Parser'
import {definitionStart, getProcessVariables, readXml, getFlowViewer} from "@/api/flowable/definition";
import {complete, rejectTask, returnList, returnTask, getNextFlowNode, delegate} from "@/api/flowable/todo";
import flow from '@/views/flowable/task/record/flow'
import {treeselect} from "@/api/system/dept";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
import Treeselect from "@riophae/vue-treeselect";
import {listUser} from "@/api/system/user";

export default {
  name: "Record",
  components: {
    Parser,
    flow,
    Treeselect
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
      deptOptions: undefined,
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
      userDataList:[], // 流程候选人
      assignee: null,
      formConf: {}, // 默认表单数据
      formConfOpen: false, // 是否加载默认表单数据
      variables: [], // 流程变量数据
      variablesData: {}, // 流程变量数据
      variableOpen: false, // 是否加载流程变量数据
      returnTaskList: [],  // 回退列表数据
      finished: 'false',
      completeTitle: null,
      completeOpen: false,
      returnTitle: null,
      returnOpen: false,
      rejectOpen: false,
      rejectTitle: null,
      userData:[],
      checkSendUser: false // 是否展示选择人员模块
    };
  },
  created() {
    this.taskForm.deployId = this.$route.query && this.$route.query.deployId;
    this.taskForm.taskId  = this.$route.query && this.$route.query.taskId;
    this.taskForm.procInsId = this.$route.query && this.$route.query.procInsId;
    this.taskForm.executionId = this.$route.query && this.$route.query.executionId;
    this.taskForm.instanceId = this.$route.query && this.$route.query.procInsId;
    // 初始化表单
    this.taskForm.procDefId  = this.$route.query && this.$route.query.procDefId;
    // 回显流程记录
    this.getFlowViewer(this.taskForm.procInsId,this.taskForm.executionId);
    this.getModelDetail(this.taskForm.deployId);
    // 流程任务重获取变量表单
    if (this.taskForm.taskId){
      this.processVariables( this.taskForm.taskId)
      this.getNextFlowNode(this.taskForm.taskId)
      this.taskForm.deployId = null
    }
    this.getFlowRecordList( this.taskForm.procInsId, this.taskForm.deployId);
    this.finished =  this.$route.query && this.$route.query.finished
  },
  methods: {
    /** 查询部门下拉树结构 */
    getTreeselect() {
      treeselect().then(response => {
        this.deptOptions = response.data;
      });
    },
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
    // 多选框选中数据
    handleSelectionChange(selection) {
      if (selection) {
        this.userData = selection
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
    // 关闭标签
    handleClose(tag) {
      this.userData.splice(this.userData.indexOf(tag), 1);
      this.$refs.singleTable.toggleRowSelection(tag, false)
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
        // 流程过程中不存在初始化表单 直接读取的流程变量中存储的表单值
        if (res.data.formData) {
          that.formConf = res.data.formData;
          that.formConfOpen = true
        }
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
          this.variableOpen = true
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
          this.checkSendUser = true
          if (data.type === 'assignee') { // 指定人员
            this.userDataList = res.data.userList;
          } else if (data.type === 'candidateUsers') {  // 指定人员(多个)
            this.userDataList = res.data.userList;
            this.taskForm.multiple = true;
          } else if (data.type === 'candidateGroups') { // 指定组(所属角色接收任务)
            res.data.roleList.forEach(role => {
              role.userId = role.roleId;
              role.nickName = role.roleName;
            })
            this.userDataList = res.data.roleList;
            this.taskForm.multiple = false;
          } else if (data.type === 'multiInstance') { // 会签?
            this.userDataList = res.data.userList;
            this.taskForm.multiple = true;
          }else if (data.type === 'fixed') { // 已经固定人员接收下一任务
            this.checkSendUser = false;
          }
        }
      })
    },
    /** 审批任务选择 */
    handleComplete() {
      this.completeOpen = true;
      this.completeTitle = "审批流程";
      this.getTreeselect();
    },
    /** 审批任务 */
    taskComplete() {
      if (!this.taskForm.values && this.checkSendUser){
        this.msgError("请选择流程接收人员");
        return;
      }
      if (!this.taskForm.comment){
        this.msgError("请输入审批意见");
        return;
      }
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
      if (data) {
        const variables = data.valData;
        const formData = data.formData;
        formData.disabled = true;
        formData.formBtns = false;
        if (this.taskForm.procDefId) {
          variables.variables = formData;
           // 启动流程并将表单数据加入流程变量
          definitionStart(this.taskForm.procDefId, JSON.stringify(variables)).then(res => {
           this.$modal.msgSuccess(res.msg);
            this.goBack();
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
