<template>
  <div class="containers">
    <el-container style="align-items: stretch">
      <el-main class="flow-viewer">
        <div class="process-status">
          <span class="intro">状态：</span>
          <div class="finish">已办理</div>
          <div class="processing">处理中</div>
          <div class="todo">未进行</div>
        </div>
        <!-- 流程图显示 -->
        <div v-loading="loading" class="canvas" ref="flowCanvas"></div>
        <!--  按钮区域  -->
        <el-button-group class="button-group">
          <el-tooltip effect="dark" content="适中" placement="bottom">
            <el-button size="small" icon="el-icon-rank" @click="fitViewport" />
          </el-tooltip>
          <el-tooltip effect="dark" content="放大" placement="bottom">
            <el-button size="small" icon="el-icon-zoom-in" @click="zoomViewport(true)" />
          </el-tooltip>
          <el-tooltip effect="dark" content="缩小" placement="bottom">
            <el-button size="small" icon="el-icon-zoom-out" @click="zoomViewport(false)" />
          </el-tooltip>
        </el-button-group>
      </el-main>
    </el-container>
  </div>
</template>

<script>
import { CustomViewer as BpmnViewer } from "@/components/Process/common";
export default {
  name: "BpmnViewer",
  /** 组件传值  */
  props: {
    // 回显数据传值
    flowData: {
      type: Object,
      default: () => {
      },
      required: false
    },
    procInsId: {
      type: String,
      default: ''
    },
  },
  data() {
    return {
       bpmnViewer: null,
       flowDetail: {},
       loading: true,
    }
  },
  /** 传值监听 */
  watch: {
    flowData: {
      handler(newValue) {
        if (Object.keys(newValue).length > 0) {
          // 生成实例
          this.bpmnViewer && this.bpmnViewer.destroy();
          this.bpmnViewer = new BpmnViewer({
            container: this.$refs.flowCanvas,
            height: 'calc(100vh - 200px)',
          });
          this.loadFlowCanvas(newValue);
        }
      }
    },
  },
  created() {

  },
  methods: {
    // 加载流程图片
    async loadFlowCanvas(flowData) {
      try {
        await this.bpmnViewer.importXML(flowData.xmlData);
        await this.fitViewport();
        // 流程线高亮设置
        if (flowData.nodeData !== undefined && flowData.nodeData.length > 0 && this.procInsId) {
          await this.fillColor(flowData.nodeData);
        }
      } catch (err) {
        console.error(err.message, err.warnings)
      }
    },

    // 让图能自适应屏幕
    fitViewport() {
      this.zoom = this.bpmnViewer.get('canvas').zoom("fit-viewport", "auto");
      this.loading = false;
    },

    // 放大缩小
    zoomViewport(zoomIn = true) {
      this.zoom = this.bpmnViewer.get('canvas').zoom()
      this.zoom += (zoomIn ? 0.1 : -0.1)
      if (this.zoom >= 0.2) this.bpmnViewer.get('canvas').zoom(this.zoom);
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
                if (todoTask && completeTask.key === todoTask.key && !todoTask.completed) {
                  canvas.addMarker(nn.id, todoTask.completed ? 'highlight' : 'highlight-todo')
                  canvas.addMarker(nn.targetRef.id, todoTask.completed ? 'highlight' : 'highlight-todo')
                } else {
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
        } else if (n.$type === 'bpmn:StartEvent') {
          n.outgoing.forEach(nn => {
            const completeTask = nodeData.find(m => m.key === nn.targetRef.id)
            if (completeTask) {
              canvas.addMarker(nn.id, 'highlight')
              canvas.addMarker(n.id, 'highlight')
              return;
            }
          })
        } else if (n.$type === 'bpmn:EndEvent') {
          if (endTask.key === n.id && endTask.completed) {
            canvas.addMarker(n.id, 'highlight')
            return;
          }
        }
      })
    }
    }
}

</script>

<style lang="scss">
@import "../style/flow-viewer.scss";
</style>
