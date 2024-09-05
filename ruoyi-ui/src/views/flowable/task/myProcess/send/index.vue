<template>
  <div class="app-container">
    <el-card class="box-card" >
      <div slot="header" class="clearfix">
        <span class="el-icon-document">发起任务</span>
        <el-button style="float: right;" size="mini" type="danger" @click="goBack">关闭</el-button>
      </div>
      <el-tabs  tab-position="top" v-model="activeName"  @tab-click="handleClick">
        <!--表单信息-->
        <el-tab-pane label="表单信息" name="1">
          <!--初始化流程加载表单信息-->
          <el-col :span="16" :offset="4">
            <v-form-render :form-data="formRenderData" ref="vFormRef"/>
            <div style="margin-left:15%;margin-bottom: 20px;font-size: 14px;">
              <el-button type="primary" @click="submitForm">提 交</el-button>
              <el-button type="primary" @click="resetForm">重 置</el-button>
            </div>
          </el-col>
        </el-tab-pane>
        <!--流程图-->
        <el-tab-pane label="流程图" name="2">
          <bpmn-viewer :flowData="flowData"/>
        </el-tab-pane>
      </el-tabs>
      <!--选择流程接收人-->
      <el-dialog :title="taskTitle" :visible.sync="taskOpen" width="65%" append-to-body>
        <flow-user v-if="checkSendUser" :checkType="checkType"  @handleUserSelect="handleUserSelect"/>
        <flow-role v-if="checkSendRole" @handleRoleSelect="handleRoleSelect"/>
        <span slot="footer" class="dialog-footer">
          <el-button @click="taskOpen = false">取 消</el-button>
          <el-button type="primary" @click="submitTask">提 交</el-button>
        </span>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
import {definitionStart, flowXmlAndNode} from "@/api/flowable/definition";
import BpmnViewer from '@/components/Process/viewer';
import {flowFormData} from "@/api/flowable/process";
import {getNextFlowNodeByStart} from "@/api/flowable/todo";
import FlowUser from '@/components/flow/User'
import FlowRole from '@/components/flow/Role'

export default {
  name: "Record",
  components: {
    BpmnViewer,
    FlowUser,
    FlowRole,
  },
  props: {},
  data() {
    return {
      // 模型xml数据
      flowData: {},
      activeName: '1', // 切换tab标签
      // 查询参数
      queryParams: {
        deptId: undefined
      },
      // 遮罩层
      loading: true,
      deployId: "",  // 流程定义编号
      procDefId: "",  // 流程实例编号
      formRenderData: {},
      variables: [], // 流程变量数据
      taskTitle: null,
      taskOpen: false,
      checkSendUser: false, // 是否展示人员选择模块
      checkSendRole: false,// 是否展示角色选择模块
      checkType: '', // 选择类型
      checkValues: null, // 选中任务接收人员数据
      formData: {}, // 填写的表单数据,
      multiInstanceVars: '', // 会签节点
      formJson: {} // 表单json
    };
  },
  created() {
    this.deployId = this.$route.query && this.$route.query.deployId;
    // 初始化表单
    this.procDefId  = this.$route.query && this.$route.query.procDefId;
    // this.getNextFlowNodeByStart(this.deployId);
    this.getFlowFormData(this.deployId);
  },
  methods: {
    handleClick(tab, event) {
      if (tab.name === '2'){
        flowXmlAndNode({deployId:this.deployId}).then(res => {
          this.flowData = res.data;
        })
      }
    },
    /** 流程表单数据 */
    getFlowFormData(deployId) {
      const params = {deployId: deployId}
      flowFormData(params).then(res => {
        // 流程过程中不存在初始化表单 直接读取的流程变量中存储的表单值
        this.$nextTick(() => {
          // 回显数据
          this.$refs.vFormRef.setFormJson(res.data);
          this.formJson = res.data;
        })
      }).catch(res => {
        this.goBack();
      })
    },
    /** 返回页面 */
    goBack() {
      // 关闭当前标签页并返回上个页面
      const obj = { path: "/task/process", query: { t: Date.now()} };
      this.$tab.closeOpenPage(obj);
    },
    /** 申请流程表单数据提交 */
    submitForm() {
      this.$refs.vFormRef.getFormData().then(formData => {
        // 根据当前任务或者流程设计配置的下一步节点 todo 暂时未涉及到考虑网关、表达式和多节点情况
        getNextFlowNodeByStart({deploymentId: this.deployId, variables: formData}).then(res => {
          const data = res.data;
          if (data) {
            this.formData = formData;
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
              this.taskOpen = true;
              this.taskTitle = "选择任务接收";
            } else {
              if (this.procDefId) {
                const param = {
                  formJson:  this.formJson,
                }
                // 复制对象的属性值给新的对象
                Object.assign(param, formData);
                // 启动流程并将表单数据加入流程变量
                definitionStart(this.procDefId, param).then(res => {
                  this.$modal.msgSuccess(res.msg);
                  this.goBack();
                })
              }
            }
          }
        })
      }).catch(error => {
        // this.$modal.msgError(error)
      })
    },
    /** 重置表单 */
    resetForm() {
      this.$refs.vFormRef.resetForm();
    },
    /** 提交流程 */
    submitTask() {
      if (!this.checkValues && this.checkSendUser){
        this.$modal.msgError("请选择任务接收!");
        return;
      }
      if (!this.checkValues && this.checkSendRole){
        this.$modal.msgError("请选择流程接收角色组!");
        return;
      }
      if (this.formData) {
        const param = {
          formJson:  this.formJson,
        }
        // 复制对象的属性值给新的对象
        Object.assign(param, this.formData);
        if (this.multiInstanceVars) {
          this.$set(param, this.multiInstanceVars, this.checkValues);
        } else {
          this.$set(param, "approval", this.checkValues);
        }
        // 启动流程并将表单数据加入流程变量
        definitionStart(this.procDefId, param).then(res => {
          this.$modal.msgSuccess(res.msg);
          this.goBack();
        })
      }
    },
    // 用户信息选中数据
    handleUserSelect(selection) {
      if (selection) {
        if (selection instanceof Array) {
          const selectVal = selection.map(item => item.userId);
          if (this.multiInstanceVars) {
            this.checkValues = selectVal;
          } else {
            this.checkValues = selectVal.join(',');
          }
        } else {
          this.checkValues = selection.userId;
        }
      }
    },
    // 角色信息选中数据
    handleRoleSelect(selection) {
      if (selection) {
        if (selection instanceof Array) {
          const selectVal = selection.map(item => item.roleId);
          this.checkValues = selectVal.join(',')
        } else {
          this.checkValues = selection;
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
