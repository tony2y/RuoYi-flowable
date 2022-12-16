<template>
  <div>
    <!--<bpmn-modeler
      ref="refNode"
      :xml="xmlData"
      :is-view="true"
      :taskList="taskData"
    />-->
    <flow-view :xmlData="xmlData"/>
  </div>
</template>
<script>
import bpmnModeler from '@/components/Process/index'
import FlowView from './flowview'

export default {
  name: "Flow",
  components: {
    bpmnModeler,
    FlowView
  },
  props: {
    xmlData: {
      type: String,
      default: ''
    },
  },
  data() {
    return {};
  }
};
</script>
