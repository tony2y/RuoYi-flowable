<template>
  <div>
    <el-form label-width="100px" size="small" @submit.native.prevent>
      <el-form-item>
        <template slot="label">
            <span>
               流转类型
               <el-tooltip placement="top">
                  <template slot="content">
                     <div>
                              普通流转路径：流程执行过程中，一个元素被访问后，会沿着其所有出口顺序流继续执行。
                        <br />默认流转路径：只有当没有其他顺序流可以选择时，才会选择默认顺序流作为活动的出口顺序流。流程会忽略默认顺序流上的条件。
                        <br />条件流转路径：是计算其每个出口顺序流上的条件。当条件计算为true时，选择该出口顺序流。如果该方法选择了多条顺序流，则会生成多个执行，流程会以并行方式继续。
                     </div>
                  </template>
                  <i class="el-icon-question" />
               </el-tooltip>
            </span>
        </template>
        <el-select v-model="bpmnFormData.type" @change="updateFlowType">
          <el-option label="普通流转路径" value="normal" />
          <el-option label="默认流转路径" value="default" />
          <el-option label="条件流转路径" value="condition" />
        </el-select>
      </el-form-item>
      <el-form-item label="条件格式" v-if="bpmnFormData.type === 'condition'" key="condition">
        <el-select v-model="bpmnFormData.conditionType">
          <el-option label="表达式" value="expression" />
          <el-option label="脚本" value="script" />
        </el-select>
      </el-form-item>
      <el-form-item label="表达式" v-if="bpmnFormData.conditionType && bpmnFormData.conditionType === 'expression'" key="express">
        <el-input v-model="bpmnFormData.body" clearable @change="updateFlowCondition" />
      </el-form-item>
      <template v-if="bpmnFormData.conditionType && bpmnFormData.conditionType === 'script'">
        <el-form-item label="脚本语言" key="language">
          <el-input v-model="bpmnFormData.language" clearable @change="updateFlowCondition" />
        </el-form-item>
        <el-form-item label="脚本类型" key="scriptType">
          <el-select v-model="bpmnFormData.scriptType">
            <el-option label="内联脚本" value="inlineScript" />
            <el-option label="外部脚本" value="externalScript" />
          </el-select>
        </el-form-item>
        <el-form-item label="脚本" v-if="bpmnFormData.scriptType === 'inlineScript'" key="body">
          <el-input v-model="bpmnFormData.body" type="textarea" clearable @change="updateFlowCondition" />
        </el-form-item>
        <el-form-item label="资源地址" v-if="bpmnFormData.scriptType === 'externalScript'" key="resource">
          <el-input v-model="bpmnFormData.resource" clearable @change="updateFlowCondition" />
        </el-form-item>
      </template>
    </el-form>
  </div>
</template>

<script>

import {StrUtil} from "@/utils/StrUtil";
export default {
  name: "BpmnModel",
  /** 组件传值  */
  props : {
    id: {
      type: String,
      required: true
    },
  },
  data() {
    return {
      bpmnElementSource: {},
      bpmnElementSourceRef: {},
      bpmnFormData: {}
    }
  },

  /** 传值监听 */
  watch: {
    id: {
      handler(newVal) {
        if (StrUtil.isNotBlank(newVal)) {
          this.resetFlowCondition();
        }
      },
      immediate: true, // 立即生效
    },
  },
  created() {

  },
  methods: {
    // 方法区
    resetFlowCondition() {
      this.bpmnFormData = {
        body: null
      };
      this.bpmnElementSource = this.modelerStore.element.source;
      this.bpmnElementSourceRef = this.modelerStore.element.businessObject.sourceRef;
      if (this.bpmnElementSourceRef && this.bpmnElementSourceRef.default && this.bpmnElementSourceRef.default.id === this.modelerStore.element.id) {
        // 默认
        this.$set(this.bpmnFormData, "type", "default");
      } else if (!this.modelerStore.element.businessObject.conditionExpression) {
        // 普通
        this.$set(this.bpmnFormData, "type", "normal");
      } else {
        // 带条件
        const conditionExpression = this.modelerStore.element.businessObject.conditionExpression;
        this.bpmnFormData = {...conditionExpression, type: "condition"};
        // resource 可直接标识 是否是外部资源脚本
        if (this.bpmnFormData.resource) {
          this.$set(this.bpmnFormData, "conditionType", "script");
          this.$set(this.bpmnFormData, "scriptType", "externalScript");
          return;
        }
        if (conditionExpression.language) {
          this.$set(this.bpmnFormData, "conditionType", "script");
          this.$set(this.bpmnFormData, "scriptType", "inlineScript");
          return;
        }
        this.$set(this.bpmnFormData, "conditionType", "expression");
      }
    },

    updateFlowType(flowType) {
      // 正常条件类
      if (flowType === "condition") {
        const flowConditionRef = this.modelerStore.moddle.create("bpmn:FormalExpression");
        this.modelerStore.modeling.updateProperties(this.modelerStore.element, {
          conditionExpression: flowConditionRef
        });
        return;
      }
      // 默认路径
      if (flowType === "default") {
        this.modelerStore.modeling.updateProperties(this.modelerStore.element, {
          conditionExpression: null
        });
        this.modelerStore.modeling.updateProperties(this.bpmnElementSource, {
          default: this.modelerStore.element
        });
        // 清空条件格式
        this.bpmnFormData.conditionType = null;
        return;
      }
      // 清空条件格式
      this.bpmnFormData.conditionType = null;
      // 正常路径，如果来源节点的默认路径是当前连线时，清除父元素的默认路径配置
      if (this.bpmnElementSourceRef.default && this.bpmnElementSourceRef.default.id === this.modelerStore.element.id) {
        this.modelerStore.modeling.updateProperties(this.bpmnElementSource, {
          default: null
        });
      }
      this.modelerStore.modeling.updateProperties(this.modelerStore.element, {
        conditionExpression: null
      });
    },

    updateFlowCondition() {
      let {conditionType, scriptType, body, resource, language} = this.bpmnFormData;
      let condition;
      if (conditionType === "expression") {
        condition = this.modelerStore.moddle.create("bpmn:FormalExpression", {body});
      } else {
        if (scriptType === "inlineScript") {
          condition = this.modelerStore.moddle.create("bpmn:FormalExpression", {body, language});
          this.$set(this.bpmnFormData, "resource", "");
        } else {
          this.$set(this.bpmnFormData, "body", "");
          condition = this.modelerStore.moddle.create("bpmn:FormalExpression", {resource, language});
        }
      }
      this.modelerStore.modeling.updateProperties(this.modelerStore.element, {conditionExpression: condition});
    }
  }
}
</script>
