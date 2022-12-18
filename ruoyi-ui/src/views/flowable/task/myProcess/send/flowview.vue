<template>
  <div class="containers main-box">
    <el-button type="success"
               size="small"
               icon="el-icon-zoom-in"
               @click="zoomViewport(true)">放大</el-button>
    <el-button type="warning"
               size="small"
               icon="el-icon-zoom-out"
               @click="zoomViewport(false)">缩小</el-button>
    <el-button type="info"
               size="small"
               icon="el-icon-rank"
               @click="fitViewport">适中</el-button>
    <div class="canvas" ref="flowCanvas"></div>
  </div>
</template>
<script>
import { CustomViewer as BpmnViewer } from "@/components/customBpmn";

export default {
  name: "FlowView",
  props: {
    flowData: {
      type: Object,
      default: () => {}
    },
  },
  data() {
    return {
      bpmnViewer: null
    };
  },
  watch: {
    flowData: {
      handler(newVal) {
        if (Object.keys(newVal).length > 0) {
          // 生成实例
          this.bpmnViewer && this.bpmnViewer.destroy();
          this.bpmnViewer = new BpmnViewer({
            container: this.$refs.flowCanvas,
            height: 'calc(100vh - 200px)',
          });
          this.loadFlowCanvas(newVal)
        }
      },
      immediate: true, // 立即生效
      deep: true  //监听对象或数组的时候，要用到深度监听
    }
  },
  mounted() {},
  methods: {
    // 加载流程图片
    async loadFlowCanvas(flowData) {
      const self = this
      try {
        await self.bpmnViewer.importXML(flowData.xmlData);
        self.fitViewport()
      } catch (err) {
        console.error(err.message, err.warnings)
      }
    },
    // 让图能自适应屏幕
    fitViewport() {
      this.zoom = this.bpmnViewer.get('canvas').zoom("fit-viewport", "auto")
    },
    // 放大缩小
    zoomViewport(zoomIn = true) {
      this.zoom = this.bpmnViewer.get('canvas').zoom()
      this.zoom += (zoomIn ? 0.1 : -0.1)
      if(this.zoom >= 0.2) this.bpmnViewer.get('canvas').zoom(this.zoom)
    },
  }
};
</script>
<style lang="scss">
  .bjs-powered-by {
    display: none;
  }
  .view-mode {
    .el-header, .el-aside, .djs-palette, .bjs-powered-by {
      display: none;
    }
    .el-loading-mask {
      background-color: initial;
    }
    .el-loading-spinner {
      display: none;
    }
  }
  .containers {
    // background-color: #ffffff;
    width: 100%;
    height: 100%;
    .canvas {
      width: 100%;
      height: 100%;
    }
    .panel {
      position: absolute;
      right: 0;
      top: 50px;
      width: 300px;
    }
    .load {
      margin-right: 10px;
    }
    .el-form-item__label{
      font-size: 13px;
    }

    .djs-palette{
      left: 0px!important;
      top: 0px;
      border-top: none;
    }

    .djs-container svg {
      min-height: 650px;
    }

    .overlays-div {
      font-size: 10px;
      color: red;
      width: 100px;
      top: -20px !important;
    }
  }
</style>
