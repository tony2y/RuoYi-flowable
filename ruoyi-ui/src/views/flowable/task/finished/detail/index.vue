<template>
  <div class="app-container">
    <el-card class="box-card" >
        <div slot="header" class="clearfix">
          <span class="el-icon-document">基础信息</span>
          <el-button style="float: right;" type="primary" @click="goBack">返回</el-button>
        </div>

      <!--流程处理表单模块-->
      <el-col :span="16" :offset="6" v-if="variableOpen">
          <div>
            <parser :key="new Date().getTime()" :form-conf="variablesData" />
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
  </div>
</template>

<script>
import {flowRecord} from "@/api/flowable/finished";
import Parser from '@/components/parser/Parser'
import {getProcessVariables, readXml, getFlowViewer} from "@/api/flowable/definition";
import flow from '@/views/flowable/task/record/flow'
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
import Treeselect from "@riophae/vue-treeselect";

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
      flowRecordList: [], // 流程流转数据
      formConfCopy: {},
      src: null,
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
      variables: [], // 流程变量数据
      variablesData: {}, // 流程变量数据
      variableOpen: false, // 是否加载流程变量数据
    };
  },
  created() {
    this.taskForm.deployId = this.$route.query && this.$route.query.deployId;
    this.taskForm.taskId  = this.$route.query && this.$route.query.taskId;
    this.taskForm.procInsId = this.$route.query && this.$route.query.procInsId;
    // 回显流程记录
    this.getFlowViewer(this.taskForm.procInsId,this.taskForm.executionId);
    this.getModelDetail(this.taskForm.deployId);
    // 流程任务重获取变量表单
    if (this.taskForm.taskId){
      this.processVariables( this.taskForm.taskId)
    }
    this.getFlowRecordList( this.taskForm.procInsId, this.taskForm.deployId);
  },
  methods: {
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
    /** 返回页面 */
    goBack() {
      // 关闭当前标签页并返回上个页面
      this.$store.dispatch("tagsView/delView", this.$route);
      this.$router.go(-1)
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
