<template>
  <div class="panel-tab__content">
    <el-form label-width="70px" @submit.native.prevent size="small">
      <el-form-item label="参数说明">
        <el-button size="small" type="primary" @click="dialogVisible = true">查看</el-button>
      </el-form-item>
      <el-form-item label="回路特性">
        <el-select v-model="loopCharacteristics" @change="changeLoopCharacteristicsType">
          <!--bpmn:MultiInstanceLoopCharacteristics-->
          <el-option label="并行多重事件" value="ParallelMultiInstance" />
          <el-option label="时序多重事件" value="SequentialMultiInstance" />
          <!--bpmn:StandardLoopCharacteristics-->
          <el-option label="循环事件" value="StandardLoop" />
          <el-option label="无" value="Null" />
        </el-select>
      </el-form-item>
      <template v-if="loopCharacteristics === 'ParallelMultiInstance' || loopCharacteristics === 'SequentialMultiInstance'">
        <el-form-item label="循环基数" key="loopCardinality">
          <el-input v-model="loopInstanceForm.loopCardinality" clearable @change="updateLoopCardinality" />
        </el-form-item>
        <el-form-item label="集合" key="collection">
          <el-input v-model="loopInstanceForm.collection" clearable @change="updateLoopBase" />
        </el-form-item>
        <el-form-item label="元素变量" key="elementVariable">
          <el-input v-model="loopInstanceForm.elementVariable" clearable @change="updateLoopBase" />
        </el-form-item>
        <el-form-item label="完成条件" key="completionCondition">
          <el-input v-model="loopInstanceForm.completionCondition" clearable @change="updateLoopCondition" />
        </el-form-item>
        <el-form-item label="异步状态" key="async">
          <el-checkbox v-model="loopInstanceForm.asyncBefore" label="异步前" @change="updateLoopAsync('asyncBefore')" />
          <el-checkbox v-model="loopInstanceForm.asyncAfter" label="异步后" @change="updateLoopAsync('asyncAfter')" />
          <el-checkbox
              v-model="loopInstanceForm.exclusive"
              v-if="loopInstanceForm.asyncAfter || loopInstanceForm.asyncBefore"
              label="排除"
              @change="updateLoopAsync('exclusive')"
          />
        </el-form-item>
        <el-form-item label="重试周期" prop="timeCycle" v-if="loopInstanceForm.asyncAfter || loopInstanceForm.asyncBefore" key="timeCycle">
          <el-input v-model="loopInstanceForm.timeCycle" clearable @change="updateLoopTimeCycle" />
        </el-form-item>
      </template>
    </el-form>

  <!-- 参数说明 -->
  <el-dialog title="多实例参数" :visible.sync="dialogVisible" width="680px" @closed="$emit('close')">
    <el-descriptions :column="1" border>
      <el-descriptions-item label="使用说明">按照BPMN2.0规范的要求，用于为每个实例创建执行的父执行，会提供下列变量:</el-descriptions-item>
      <el-descriptions-item label="collection(集合变量)">传入List参数, 一般为用户ID集合</el-descriptions-item>
      <el-descriptions-item label="elementVariable(元素变量)">List中单个参数的名称</el-descriptions-item>
      <el-descriptions-item label="loopCardinality(基数)">List循环次数</el-descriptions-item>
      <el-descriptions-item label="isSequential(串并行)">Parallel: 并行多实例，Sequential: 串行多实例</el-descriptions-item>
      <el-descriptions-item label="completionCondition(完成条件)">任务出口条件</el-descriptions-item>
      <el-descriptions-item label="nrOfInstances(实例总数)">实例总数</el-descriptions-item>
      <el-descriptions-item label="nrOfActiveInstances(未完成数)">当前活动的（即未完成的），实例数量。对于顺序多实例，这个值总为1</el-descriptions-item>
      <el-descriptions-item label="nrOfCompletedInstances(已完成数)">已完成的实例数量</el-descriptions-item>
      <el-descriptions-item label="loopCounter">给定实例在for-each循环中的index</el-descriptions-item>
    </el-descriptions>
  </el-dialog>
  </div>
</template>
<script>
import {StrUtil} from '@/utils/StrUtil'


export default {
  name: "MultiInstance",
  /** 组件传值  */
  props: {
    id: {
      type: String,
      required: true
    },
  },
  data() {
    return {
      dialogVisible: false,
      loopCharacteristics: "",
      loopInstanceForm: {},
      multiLoopInstance: {},
      defaultLoopInstanceForm: {
        completionCondition: "",
        loopCardinality: "",
        extensionElements: [],
        asyncAfter: false,
        asyncBefore: false,
        exclusive: false
      },
    }
  },

  /** 传值监听 */
  watch: {
    id: {
      handler(newVal) {
        if (StrUtil.isNotBlank(newVal)) {
          this.getElementLoop(this.modelerStore.element.businessObject);        }
      },
      immediate: true, // 立即生效
    },
  },
  created() {

  },
  methods: {
    // 方法区
    getElementLoop(businessObject) {
      if (!businessObject.loopCharacteristics) {
        this.loopCharacteristics = "Null";
        this.loopInstanceForm = {};
        return;
      }
      if (businessObject.loopCharacteristics.$type === "bpmn:StandardLoopCharacteristics") {
        this.loopCharacteristics = "StandardLoop";
        this.loopInstanceForm = {};
        return;
      }
      if (businessObject.loopCharacteristics.isSequential) {
        this.loopCharacteristics = "SequentialMultiInstance";
      } else {
        this.loopCharacteristics = "ParallelMultiInstance";
      }
      // 合并配置
      this.loopInstanceForm = {
        ...this.defaultLoopInstanceForm,
        ...businessObject.loopCharacteristics,
        completionCondition: businessObject.loopCharacteristics?.completionCondition?.body ?? "",
        loopCardinality: businessObject.loopCharacteristics?.loopCardinality?.body ?? ""
      };
      // 保留当前元素 businessObject 上的 loopCharacteristics 实例
      this.multiLoopInstance = this.modelerStore.element.businessObject.loopCharacteristics;
      // 更新表单
      if (
        businessObject.loopCharacteristics.extensionElements &&
        businessObject.loopCharacteristics.extensionElements.values &&
        businessObject.loopCharacteristics.extensionElements.values.length
      ) {
        this.$set(this.loopInstanceForm, "timeCycle", businessObject.loopCharacteristics.extensionElements.values[0].body);
      }
    },

    changeLoopCharacteristicsType(type) {
      // 切换类型取消原表单配置
      this.loopInstanceForm = {...this.defaultLoopInstanceForm};
      // 取消多实例配置
      if (type === "Null") {
        this.modelerStore.modeling.updateProperties(this.modelerStore.element, {loopCharacteristics: null});
        return;
      }
      // 配置循环
      if (type === "StandardLoop") {
        const loopCharacteristicsObject = this.modelerStore.moddle.create("bpmn:StandardLoopCharacteristics");
        this.modelerStore.modeling.updateProperties(this.modelerStore.element, {
          loopCharacteristics: loopCharacteristicsObject
        });
        this.multiLoopInstance = null;
        return;
      }
      // 时序
      if (type === "SequentialMultiInstance") {
        this.multiLoopInstance = this.modelerStore.moddle.create("bpmn:MultiInstanceLoopCharacteristics", {
          isSequential: true
        });
      } else {
        this.multiLoopInstance = this.modelerStore.moddle.create("bpmn:MultiInstanceLoopCharacteristics");
      }
      this.modelerStore.modeling.updateProperties(this.modelerStore.element, {
        loopCharacteristics: this.multiLoopInstance
      });
    },

    // 循环基数
    updateLoopCardinality(cardinality) {
      let loopCardinality = null;
      if (cardinality && cardinality.length) {
        loopCardinality = this.modelerStore.moddle.create("bpmn:FormalExpression", {body: cardinality});
      }
      this.modelerStore.modeling.updateModdleProperties(this.modelerStore.element, this.multiLoopInstance, {
        loopCardinality
      });
    },

    // 完成条件
    updateLoopCondition(condition) {
      let completionCondition = null;
      if (condition && condition.length) {
        completionCondition = this.modelerStore.moddle.create("bpmn:FormalExpression", {body: condition});
      }
      this.modelerStore.modeling.updateModdleProperties(this.modelerStore.element, this.multiLoopInstance, {
        completionCondition
      });
    },

    // 重试周期
    updateLoopTimeCycle(timeCycle) {
      const extensionElements = this.modelerStore.moddle.create("bpmn:ExtensionElements", {
        values: [
          this.modelerStore.moddle.create(`flowable:FailedJobRetryTimeCycle`, {
            body: timeCycle
          })
        ]
      });
      this.modelerStore.modeling.updateModdleProperties(this.modelerStore.element, this.multiLoopInstance, {
        extensionElements
      });
    },

    // 直接更新的基础信息
    updateLoopBase() {
      this.modelerStore.modeling.updateModdleProperties(this.modelerStore.element, this.multiLoopInstance, {
        collection: this.loopInstanceForm.collection || null,
        elementVariable: this.loopInstanceForm.elementVariable || null
      });
    },

    // 各异步状态
    updateLoopAsync(key) {
      const {asyncBefore, asyncAfter} = this.loopInstanceForm;
      let asyncAttr = Object.create(null);
      if (!asyncBefore && !asyncAfter) {
        this.$set(this.loopInstanceForm, "exclusive", false);
        asyncAttr = {asyncBefore: false, asyncAfter: false, exclusive: false, extensionElements: null};
      } else {
        asyncAttr[key] = this.loopInstanceForm[key];
      }
      this.modelerStore.modeling.updateModdleProperties(this.modelerStore.element, this.multiLoopInstance, asyncAttr);
    }
  }
}

</script>
<style lang="scss">
@import '../style/process-panel';
</style>

