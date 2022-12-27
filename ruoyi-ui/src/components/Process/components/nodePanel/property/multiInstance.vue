<template>
  <div>
    <el-dialog
      title="多实例配置"
      :visible.sync="dialogVisible"
      width="600px"
      :close-on-click-modal="false"
      :close-on-press-escape="false"
      class="muti-instance"
      @closed="$emit('close')"
    >
      <el-descriptions :column="1" size="mini" border>
        <el-descriptions-item label="使用说明">按照BPMN2.0规范的要求，用于为每个实例创建执行的父执行，会提供下列变量:</el-descriptions-item>
        <el-descriptions-item label="nrOfInstances">实例总数。</el-descriptions-item>
        <el-descriptions-item label="nrOfActiveInstances">当前活动的（即未完成的），实例数量。对于顺序多实例，这个值总为1。</el-descriptions-item>
        <el-descriptions-item label="nrOfCompletedInstances">已完成的实例数量。</el-descriptions-item>
        <el-descriptions-item label="loopCounter">给定实例在for-each循环中的index。</el-descriptions-item>
      </el-descriptions>
      <div class="app-container">
       <x-form ref="xForm" v-model="formData" :config="formConfig" />
      </div>
    </el-dialog>
  </div>
</template>

<script>
import mixinPanel from '@/components/Process/common/mixinPanel'
import {formatJsonKeyValue} from '@/components/Process/common/parseElement'

export default {
  mixins: [mixinPanel],
  data() {
    return {
      dialogVisible: true,
      formData: {},
      prefix: 'flowable:',
    }
  },
  computed: {
    formConfig() {
      const _this = this
      return {
        inline: false,
        item: [
          {
            xType: 'input',
            name: 'collection',
            label: '集合',
            tooltip: 'collection: 属性会作为表达式进行解析。如果表达式解析为字符串而不是一个集合，<br />不论是因为本身配置的就是静态字符串值，还是表达式计算结果为字符串，<br />这个字符串都会被当做变量名，并从流程变量中用于获取实际的集合。',
            // rules: [{ required: true, message: '请输入集合名称', trigger: ['blur', 'change'] }]
          },
          {
            xType: 'input',
            name: 'elementVariable',
            label: '元素变量',
            tooltip: 'elementVariable: 每创建一个用户任务前，先以该元素变量为label，集合中的一项为value，<br />创建（局部）流程变量，该局部流程变量被用于指派用户任务。<br />一般来说，该字符串应与指定人员变量相同。',
            // rules: [{ required: true, message: '请输入元素变量', trigger: ['blur', 'change'] }]
          },
          {
            xType: 'select',
            name: 'isSequential',
            label: '执行方式',
            tooltip: '并行会签（parallel）、串行会签(sequential)，其中并行会签的意思是 多个人同时执行任务。串行会签是按顺序执行任务。',
            dic: [{label: '串行', value: true}, {label: '并行', value: false}],
            // rules: [{ required: true, message: '请选择执行方式', trigger: ['blur', 'change'] }]
          },
          {
            xType: 'input',
            name: 'completionCondition',
            label: '完成条件',
            tooltip: 'completionCondition: 多实例活动在所有实例都完成时结束，然而也可以指定一个表达式，在每个实例<br />结束时进行计算。当表达式计算为true时，将销毁所有剩余的实例，并结束多实例<br />活动，继续执行流程。例如 ${nrOfCompletedInstances/nrOfInstances >= 0.6 }，<br />表示当任务完成60%时，该节点就算完成',
            // rules: [{ required: true, message: '请输入完成条件', trigger: ['blur', 'change'] }]
          }
        ],
        operate: [
          { text: '确定', show: true, click: _this.save },
          { text: '清空', show: true, click: () => { _this.formData = {} } }
        ]
      }
    }
  },
  mounted() {
    const cache = JSON.parse(JSON.stringify(this.element.businessObject.loopCharacteristics ?? {}))
    cache.completionCondition = cache.completionCondition?.body
    // 拼接多实例对象
    if (this.element.businessObject.loopCharacteristics) {
      Object.assign(cache, this.element.businessObject.loopCharacteristics.$attrs)
    }
    this.formData = formatJsonKeyValue(cache)
  },
  methods: {
    updateElement() {
      if (this.formData.isSequential !== null && this.formData.isSequential !== undefined) {
        // const model = this.modeler.get('moddle');
        let loopCharacteristics = this.element.businessObject.get('loopCharacteristics')
        if (!loopCharacteristics) {
          loopCharacteristics = this.modeler.get('moddle').create('bpmn:MultiInstanceLoopCharacteristics')
        }
        loopCharacteristics['isSequential'] = this.formData.isSequential
        loopCharacteristics['collection'] = this.formData.collection
        loopCharacteristics['elementVariable'] = this.formData.elementVariable
        // let loopCardinality = model.create("bpmn:Expression",{
        //   body: "4"
        // });
        // loopCharacteristics['loopCardinality'] = loopCardinality

        loopCharacteristics.$attrs['isSequential'] = this.formData.isSequential
        loopCharacteristics.$attrs[this.prefix + 'collection'] = this.formData.collection
        loopCharacteristics.$attrs[this.prefix + 'elementVariable'] = this.formData.elementVariable

        if (this.formData.completionCondition) {
          loopCharacteristics['completionCondition'] = this.modeler.get('moddle').create('bpmn:Expression', {body: this.formData.completionCondition})
        }
        this.updateProperties({loopCharacteristics: loopCharacteristics})
      } else {
        delete this.element.businessObject.loopCharacteristics
      }
    },
    save() {
      this.$refs['xForm'].validate().then(() => {
        this.updateElement()
        this.dialogVisible = false
      }).catch(e => console.error(e));
    }
  }
}
</script>

<style>
.muti-instance .el-form-item {
  margin-bottom: 22px;
}
</style>
