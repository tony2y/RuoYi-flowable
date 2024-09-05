<template>
  <div>
    <template slot="header">
      <div class="card-header">
        <span>{{ translateNodeName(elementType) }}</span>
      </div>
    </template>
    <el-collapse v-model="activeName" >
        <!--   常规信息     -->
        <el-collapse-item name="common">
          <template slot="title"><i class="el-icon-info"></i> 常规信息</template>
          <common-panel :id="elementId"/>
        </el-collapse-item>

        <!--   任务信息     -->
        <el-collapse-item name="Task" v-if="elementType.indexOf('Task') !== -1">
          <template slot="title"><i class="el-icon-s-claim"></i> 任务配置</template>
          <user-task-panel :id="elementId"/>
        </el-collapse-item>

        <!--   表单     -->
        <el-collapse-item name="form" v-if="formVisible">
          <template slot="title"><i class="el-icon-s-order"></i> 表单配置</template>
          <form-panel :id="elementId"/>
        </el-collapse-item>

        <!--   执行监听器     -->
        <el-collapse-item name="executionListener">
          <template slot="title"><i class="el-icon-s-promotion"></i> 执行监听器
             <el-badge :value="executionListenerCount" class="item" type="primary"/>
           </template>
          <execution-listener :id="elementId" @getExecutionListenerCount="getExecutionListenerCount"/>
        </el-collapse-item>

        <!--   任务监听器     -->
        <el-collapse-item name="taskListener" v-if="elementType === 'UserTask'" >
          <template slot="title"><i class="el-icon-s-flag"></i> 任务监听器
            <el-badge :value="taskListenerCount" class="item" type="primary"/>
          </template>
          <task-listener :id="elementId" @getTaskListenerCount="getTaskListenerCount"/>
        </el-collapse-item>

        <!--   多实例     -->
        <el-collapse-item name="multiInstance" v-if="elementType.indexOf('Task') !== -1" >
          <template slot="title"><i class="el-icon-s-grid"></i> 多实例</template>
          <multi-instance :id="elementId"/>
        </el-collapse-item>
        <!--   流转条件     -->
        <el-collapse-item name="condition" v-if="conditionVisible" >
          <template slot="title"><i class="el-icon-share"></i> 流转条件</template>
          <condition-panel :id="elementId"/>
        </el-collapse-item>

        <!--   扩展属性     -->
        <el-collapse-item name="properties" >
          <template slot="title"><i class="el-icon-circle-plus"></i> 扩展属性</template>
          <properties-panel :id="elementId"/>
        </el-collapse-item>

    </el-collapse>
  </div>
</template>

<script>
import ExecutionListener from './panel/executionListener'
import TaskListener from './panel/taskListener'
import MultiInstance from './panel/multiInstance'
import CommonPanel from './panel/commonPanel'
import UserTaskPanel from './panel/taskPanel'
import ConditionPanel from './panel/conditionPanel'
import FormPanel from './panel/formPanel'
import OtherPanel from './panel/otherPanel'
import PropertiesPanel from './panel/PropertiesPanel'

import { translateNodeName } from "./common/bpmnUtils";
import FlowUser from "@/components/flow/User/index.vue";
import FlowRole from "@/components/flow/Role/index.vue";
import FlowExp from "@/components/flow/Expression/index.vue";
export default {
  name: "Designer",
  components: {
    ExecutionListener,
    TaskListener,
    MultiInstance,
    CommonPanel,
    UserTaskPanel,
    ConditionPanel,
    FormPanel,
    OtherPanel,
    PropertiesPanel,
    FlowUser,
    FlowRole,
    FlowExp,
  },
  data() {
    return {
      activeName : 'common',
      executionListenerCount: 0,
      taskListenerCount:0,
      elementId:"",
      elementType:"",
      conditionVisible:false,// 流转条件设置
      formVisible:false, // 表单配置
      rules:{
        id: [
          { required: true, message: '节点Id 不能为空', trigger: 'blur' },
        ],
        name: [
          { required: true, message: '节点名称不能为空', trigger: 'blur' },
        ],
      },
    }
  },

  /** 传值监听 */
  watch: {
    elementId: {
      handler() {
        this.activeName = "common";
      }
    },
  },
  created() {
    this.initModels();
  },
  methods: {
    // 初始化流程设计器
    initModels() {
      this.getActiveElement();
    },

    // 注册节点事件
    getActiveElement() {
      // 初始第一个选中元素 bpmn:Process
      this.initFormOnChanged(null);
      this.modelerStore.modeler.on("import.done", e => {
        this.initFormOnChanged(null);
      });
      // 监听选择事件，修改当前激活的元素以及表单
      this.modelerStore.modeler.on("selection.changed", ({newSelection}) => {
        this.initFormOnChanged(newSelection[0] || null);
      });
      this.modelerStore.modeler.on("element.changed", ({element}) => {
        // 保证 修改 "默认流转路径" 类似需要修改多个元素的事件发生的时候，更新表单的元素与原选中元素不一致。
        if (element && element.id === this.elementId) {
          this.initFormOnChanged(element);
        }
      });
    },

    // 初始化数据
    initFormOnChanged(element) {
      let activatedElement = element;
      if (!activatedElement) {
        activatedElement =
          this.modelerStore.elRegistry.find(el => el.type === "bpmn:Process") ??
          this.modelerStore.elRegistry.find(el => el.type === "bpmn:Collaboration");
      }
      if (!activatedElement) return;
      this.modelerStore.element = activatedElement;
      this.elementId = activatedElement.id;
      this.elementType = activatedElement.type.split(":")[1] || "";
      this.conditionVisible = !!(
        this.elementType === "SequenceFlow" &&
        activatedElement.source &&
        activatedElement.source.type.indexOf("StartEvent") === -1
      );
      this.formVisible = this.elementType === "UserTask" || this.elementType === "StartEvent";
    },

    /** 获取执行监听器数量 */
    getExecutionListenerCount(value) {
      this.executionListenerCount = value;
    },
    /** 获取任务监听器数量 */
    getTaskListenerCount(value) {
      this.taskListenerCount = value;
    },
    translateNodeName(val){
      return translateNodeName(val);
    }
  }
}
</script>

<style lang="scss">
</style>
