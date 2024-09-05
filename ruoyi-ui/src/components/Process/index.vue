<template>
  <div v-loading="isView" class="flow-containers" :class="{ 'view-mode': isView }">
    <el-container style="height: 100%">
      <el-header style="border-bottom: 1px solid rgb(218 218 218);height: auto;padding-left:0">
        <div style="display: flex; padding: 10px 0; justify-content: space-between;">
          <el-button-group>
            <el-upload action="" :before-upload="openBpmn" style="margin-right: 10px; display:inline-block;">
              <el-tooltip effect="dark" content="加载xml" placement="bottom">
                <el-button size="mini" icon="el-icon-folder-opened" />
              </el-tooltip>
            </el-upload>
            <el-tooltip effect="dark" content="新建" placement="bottom">
              <el-button size="mini" icon="el-icon-circle-plus" @click="newDiagram" />
            </el-tooltip>
            <el-tooltip effect="dark" content="自适应屏幕" placement="bottom">
              <el-button size="mini" icon="el-icon-rank" @click="fitViewport" />
            </el-tooltip>
            <el-tooltip effect="dark" content="放大" placement="bottom">
              <el-button size="mini" icon="el-icon-zoom-in" @click="zoomViewport(true)" />
            </el-tooltip>
            <el-tooltip effect="dark" content="缩小" placement="bottom">
              <el-button size="mini" icon="el-icon-zoom-out" @click="zoomViewport(false)" />
            </el-tooltip>
            <el-tooltip effect="dark" content="后退" placement="bottom">
              <el-button size="mini" icon="el-icon-back" @click="modeler.get('commandStack').undo()" />
            </el-tooltip>
            <el-tooltip effect="dark" content="前进" placement="bottom">
              <el-button size="mini" icon="el-icon-right" @click="modeler.get('commandStack').redo()" />
            </el-tooltip>
<!--            <el-button size="mini" icon="el-icon-share" @click="processSimulation">-->
<!--              {{ this.simulationStatus ? '退出模拟' : '开启模拟' }}-->
<!--            </el-button>-->
<!--            <el-button size="mini" icon="el-icon-first-aid-kit" @click="handlerIntegrityCheck">-->
<!--              {{ this.bpmnlintStatus ? '关闭检查' : '开启检查' }}-->
<!--            </el-button>-->
          </el-button-group>
          <el-button-group>
            <el-button size="mini" icon="el-icon-view" @click="showXML">查看xml</el-button>
            <el-button size="mini" icon="el-icon-download" @click="saveXML(true)">下载xml</el-button>
            <el-button size="mini" icon="el-icon-picture" @click="saveImg('svg', true)">下载svg</el-button>
            <el-button size="mini" type="primary" @click="save">保存模型</el-button>
            <el-button size="mini" type="danger" @click="goBack">关闭</el-button>
          </el-button-group>
        </div>
      </el-header>
      <!-- 流程设计页面 -->
      <el-container style="align-items: stretch">
        <el-main>
          <div ref="canvas" class="canvas" />
        </el-main>

        <!--右侧属性栏-->
        <el-card shadow="never" class="normalPanel">
          <designer v-if="loadCanvas"></designer>
        </el-card>
      </el-container>
    </el-container>
  </div>
</template>

<script>
// 汉化
import customTranslate from './customPanel/customTranslate'
import Modeler from 'bpmn-js/lib/Modeler'
import Designer from './designer'
import getInitStr from './flowable/init'
import {StrUtil} from '@/utils/StrUtil'
// 引入flowable的节点文件
import FlowableModule from './flowable/flowable.json'
import customControlsModule from './customPanel'
export default {
  name: "BpmnModel",
  components: {Designer},
  /** 组件传值  */
  props : {
    xml: {
      type: String,
      default: ''
    },
    isView: {
      type: Boolean,
      default: false
    },
  },
  data() {
    return {
      modeler: null,
      zoom: 1,
      loadCanvas: false,  // 当前组件渲染然后再加载canvas
      simulationStatus: false,
      bpmnlintStatus: false,
      simulation: true,
      designer: true,
    }
  },
  /** 传值监听 */
  watch: {
    xml: {
      handler(newVal) {
        if (StrUtil.isNotBlank(newVal)) {
          this.createNewDiagram(newVal)
        } else {
          this.newDiagram()
        }
      },
      immediate: true, // 立即生效
    },
  },
  computed: {
    additionalModules() {
      const Modules = [];
      Modules.push(customControlsModule);
      Modules.push({ //汉化
        translate: ['value', customTranslate]
      });
      return Modules;
    },
  },
  mounted() {
    /** 创建bpmn 实例 */
    const modeler = new Modeler({
      container: this.$refs.canvas,
      additionalModules: this.additionalModules,
      moddleExtensions: {
        flowable: FlowableModule
      },
      keyboard: { bindTo: document },
    })
    this.modeler = modeler;
    // 注册 modeler 相关信息
    this.modelerStore.modeler = modeler;
    this.modelerStore.modeling = modeler.get("modeling");
    this.modelerStore.moddle = modeler.get("moddle");
    this.modelerStore.canvas = modeler.get("canvas");
    this.modelerStore.bpmnFactory = modeler.get("bpmnFactory");
    this.modelerStore.elRegistry = modeler.get("elementRegistry");
    // 直接点击新建按钮时,进行新增流程图
    if (StrUtil.isBlank(this.xml)) {
      this.newDiagram()
    } else {
      this.createNewDiagram(this.xml)
    }
  },
  methods: {
    // 根据默认文件初始化流程图
    newDiagram() {
      this.createNewDiagram(getInitStr())
    },

    // 根据提供的xml创建流程图
    async createNewDiagram(data) {
      // 将字符串转换成图显示出来
      // data = data.replace(/<!\[CDATA\[(.+?)]]>/g, '&lt;![CDATA[$1]]&gt;')
      if (StrUtil.isNotBlank(this.modelerStore.modeler)) {
        data = data.replace(/<!\[CDATA\[(.+?)]]>/g, function (match, str) {
            return str.replace(/</g, '&lt;')
          }
        )
        try {
          await this.modelerStore.modeler.importXML(data)
          this.fitViewport()
        } catch (err) {
          console.error(err.message, err.warnings)
        }
      }
    },

    // 让图能自适应屏幕
    fitViewport() {
      this.zoom = this.modelerStore.canvas.zoom('fit-viewport')
      const bbox = document.querySelector('.flow-containers .viewport').getBBox()
      const currentViewBox = this.modelerStore.canvas.viewbox()
      const elementMid = {
        x: bbox.x + bbox.width / 2 - 65,
        y: bbox.y + bbox.height / 2
      }
      this.modelerStore.canvas.viewbox({
        x: elementMid.x - currentViewBox.width / 2,
        y: elementMid.y - currentViewBox.height / 2,
        width: currentViewBox.width,
        height: currentViewBox.height
      })
      this.zoom = bbox.width / currentViewBox.width * 1.8
      this.loadCanvas = true;
    },

    // 放大缩小
    zoomViewport(zoomIn = true) {
      this.zoom = this.modelerStore.canvas.zoom()
      this.zoom += (zoomIn ? 0.1 : -0.1)
      this.modelerStore.canvas.zoom(this.zoom)
    },

    // 获取流程基础信息
    getProcess() {
      const element = this.getProcessElement()
      return {
        id: element.id,
        name: element.name,
        category: element.processCategory
      }
    },

    // 获取流程主面板节点
    getProcessElement() {
      const rootElements = this.modelerStore.modeler.getDefinitions().rootElements
      for (let i = 0; i < rootElements.length; i++) {
        if (rootElements[i].$type === 'bpmn:Process') return rootElements[i]
      }
    },

    // 保存xml
    async saveXML(download = false) {
      try {
        const {xml} = await this.modelerStore.modeler.saveXML({format: true})
        if (download) {
          this.downloadFile(`${this.getProcessElement().name}.bpmn20.xml`, xml, 'application/xml')
        }
        return xml
      } catch (err) {
        console.log(err)
      }
    },

    // 在线查看xml
    async showXML() {
      try {
        const xmlStr = await this.saveXML()
        this.$emit('showXML', xmlStr)
      } catch (err) {
        console.log(err)
      }
    },

    // 保存流程图为svg
    async saveImg(type = 'svg', download = false) {
      try {
        const {svg} = await this.modelerStore.modeler.saveSVG({format: true})
        if (download) {
          this.downloadFile(this.getProcessElement().name, svg, 'image/svg+xml')
        }
        return svg
      } catch (err) {
        console.log(err)
      }
    },

    // 保存流程图
    async save() {
      const process = this.getProcess()
      const xml = await this.saveXML()
      const svg = await this.saveImg()
      const result = {process, xml, svg}
      this.$emit('save', result)
      window.parent.postMessage(result, '*')
      this.goBack();
    },

    // 打开流程文件
    openBpmn(file) {
      const reader = new FileReader()
      reader.readAsText(file, 'utf-8')
      reader.onload = () => {
        this.createNewDiagram(reader.result)
      }
      return false
    },

    // 下载流程文件
    downloadFile(filename, data, type) {
      const a = document.createElement('a');
      const url = window.URL.createObjectURL(new Blob([data], {type: type}));
      a.href = url
      a.download = filename
      a.click()
      window.URL.revokeObjectURL(url)
    },

    /** 关闭当前标签页并返回上个页面 */
    goBack() {
      const obj = {path: "/flowable/definition", query: {t: Date.now()}};
      this.$tab.closeOpenPage(obj);
      this.toggleSideBar();
    },
  }
}
</script>

<style lang="scss">
/*左边工具栏以及编辑节点的样式*/
@import "~bpmn-js/dist/assets/diagram-js.css";
@import "~bpmn-js/dist/assets/bpmn-font/css/bpmn.css";
@import "~bpmn-js/dist/assets/bpmn-font/css/bpmn-codes.css";
@import "~bpmn-js/dist/assets/bpmn-font/css/bpmn-embedded.css";
//@import "~bpmn-js-bpmnlint/dist/assets/css/bpmn-js-bpmnlint.css";
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

.flow-containers {
  width: 100%;
  height: 100%;
  .canvas {
    min-height: 850px;
    width: 100%;
    height: 100%;
    background: url("data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGRlZnM+PHBhdHRlcm4gaWQ9ImEiIHdpZHRoPSI0MCIgaGVpZ2h0PSI0MCIgcGF0dGVyblVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHBhdGggZD0iTTAgMTBoNDBNMTAgMHY0ME0wIDIwaDQwTTIwIDB2NDBNMCAzMGg0ME0zMCAwdjQwIiBmaWxsPSJub25lIiBzdHJva2U9IiNlMGUwZTAiIG9wYWNpdHk9Ii4yIi8+PHBhdGggZD0iTTQwIDBIMHY0MCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZTBlMGUwIi8+PC9wYXR0ZXJuPjwvZGVmcz48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJ1cmwoI2EpIi8+PC9zdmc+")
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
  .normalPanel {
    width: 460px;
    height: 100%;
    padding: 20px 20px;
  }

  .el-main {
    position: relative;
    padding: 0;
  }

  .el-main .button-group {
    display: flex;
    flex-direction: column;
    position: absolute;
    width: auto;
    height: auto;
    top: 10px;
    right: 10px;
  }

  .button-group .el-button {
    width: 100%;
    margin: 0 0 5px;
  }
}
</style>
