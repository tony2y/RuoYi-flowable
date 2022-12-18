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
  mounted() {
  },
  methods: {
    // 加载流程
    async loadFlowCanvas(flowData) {
      const self = this
      try {
        await self.bpmnViewer.importXML(flowData.xmlData);
        self.fitViewport()
        if (flowData.nodeData !==undefined && flowData.nodeData.length > 0 ) {
          self.fillColor(flowData.nodeData)
        }
      } catch (err) {
        console.error(err.message, err.warnings)
      }
    },
    // 设置高亮颜色的class
    setNodeColor(nodeCodes, colorClass, canvas) {
      for (let i = 0; i < nodeCodes.length; i++) {
        canvas.addMarker(nodeCodes[i], colorClass);
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

    // 设置高亮颜色的
    fillColor(nodeData) {
      const canvas = this.bpmnViewer.get('canvas')
      this.bpmnViewer.getDefinitions().rootElements[0].flowElements.forEach(n => {
        const completeTask = nodeData.find(m => m.key === n.id)
        const todoTask = nodeData.find(m => !m.completed)
        const endTask = nodeData[nodeData.length - 1]
        if (n.$type === 'bpmn:UserTask') {
          if (completeTask) {
            canvas.addMarker(n.id, completeTask.completed ? 'highlight' : 'highlight-todo')
            n.outgoing?.forEach(nn => {
              const targetTask = nodeData.find(m => m.key === nn.targetRef.id)
              if (targetTask) {
                if (todoTask && completeTask.key === todoTask.key && !todoTask.completed){
                  canvas.addMarker(nn.id, todoTask.completed ? 'highlight' : 'highlight-todo')
                  canvas.addMarker(nn.targetRef.id, todoTask.completed ? 'highlight' : 'highlight-todo')
                }else {
                  canvas.addMarker(nn.id, targetTask.completed ? 'highlight' : 'highlight-todo')
                  canvas.addMarker(nn.targetRef.id, targetTask.completed ? 'highlight' : 'highlight-todo')
                }
              }
            })
          }
        }
        // 排他网关
        else if (n.$type === 'bpmn:ExclusiveGateway') {
          if (completeTask) {
            canvas.addMarker(n.id, completeTask.completed ? 'highlight' : 'highlight-todo')
            n.outgoing?.forEach(nn => {
              const targetTask = nodeData.find(m => m.key === nn.targetRef.id)
              if (targetTask) {

                canvas.addMarker(nn.id, targetTask.completed ? 'highlight' : 'highlight-todo')
                canvas.addMarker(nn.targetRef.id, targetTask.completed ? 'highlight' : 'highlight-todo')
              }

            })
          }

        }
        // 并行网关
        else if (n.$type === 'bpmn:ParallelGateway') {
          if (completeTask) {
            canvas.addMarker(n.id, completeTask.completed ? 'highlight' : 'highlight-todo')
            n.outgoing?.forEach(nn => {
              const targetTask = nodeData.find(m => m.key === nn.targetRef.id)
              if (targetTask) {
                canvas.addMarker(nn.id, targetTask.completed ? 'highlight' : 'highlight-todo')
                canvas.addMarker(nn.targetRef.id, targetTask.completed ? 'highlight' : 'highlight-todo')
              }
            })
          }
        }
        else if (n.$type === 'bpmn:StartEvent') {
          n.outgoing.forEach(nn => {
            const completeTask = nodeData.find(m => m.key === nn.targetRef.id)
            if (completeTask) {
              canvas.addMarker(nn.id, 'highlight')
              canvas.addMarker(n.id, 'highlight')
              return
            }
          })
        }
        else if (n.$type === 'bpmn:EndEvent') {
          if (endTask.key === n.id && endTask.completed) {
            canvas.addMarker(n.id, 'highlight')
            return
          }
        }
      })
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

    .highlight.djs-shape .djs-visual > :nth-child(1) {
      fill: green !important;
      stroke: green !important;
      fill-opacity: 0.2 !important;
    }
    .highlight.djs-shape .djs-visual > :nth-child(2) {
      fill: green !important;
    }
    .highlight.djs-shape .djs-visual > path {
      fill: green !important;
      fill-opacity: 0.2 !important;
      stroke: green !important;
    }
    .highlight.djs-connection > .djs-visual > path {
      stroke: green !important;
    }
    .highlight-todo.djs-connection > .djs-visual > path {
      stroke: orange !important;
      stroke-dasharray: 4px !important;
      fill-opacity: 0.2 !important;
    }
    .highlight-todo.djs-shape .djs-visual > :nth-child(1) {
      fill: orange !important;
      stroke: orange !important;
      stroke-dasharray: 4px !important;
      fill-opacity: 0.2 !important;
    }
    .overlays-div {
      font-size: 10px;
      color: red;
      width: 100px;
      top: -20px !important;
    }
  }
</style>
