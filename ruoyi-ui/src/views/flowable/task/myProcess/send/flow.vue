<template>
  <div>
    <flow-view :xmlData="xmlData"/>
  </div>
</template>
<script>
import FlowView from './flowview'

export default {
  name: "Flow",
  components: {
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
