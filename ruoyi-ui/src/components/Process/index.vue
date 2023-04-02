<template>
  <div v-loading="isView" class="flow-containers" :class="{ 'view-mode': isView }">
    <el-container style="height: 100%">
      <el-header style="border-bottom: 1px solid rgb(218 218 218);height: auto;padding-left:0px">
        <div style="display: flex; padding: 10px 0px; justify-content: space-between;">
          <div>
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
          </div>
          <div>
<!--            <el-button size="mini" icon="el-icon-s-check" @click="verifyXML">校验xml</el-button>-->
            <el-button size="mini" icon="el-icon-view" @click="showXML">查看xml</el-button>
            <el-button size="mini" icon="el-icon-download" @click="saveXML(true)">下载xml</el-button>
            <el-button size="mini" icon="el-icon-picture" @click="saveImg('svg', true)">下载svg</el-button>
            <el-button size="mini" type="primary" @click="save">保存模型</el-button>
          </div>
        </div>
      </el-header>
      <el-container style="align-items: stretch">
        <el-main style="padding: 0;">
          <div ref="canvas" class="canvas" />
        </el-main>
        <el-aside style="width: 400px; min-height: 650px; background-color: #f0f2f5">
          <panel v-if="modeler" :modeler="modeler" :users="users" :groups="groups" :exps="exps" :categorys="categorys" />
        </el-aside>
      </el-container>
    </el-container>
  </div>
</template>

<script>
// 汉化
import customTranslate from './common/customTranslate'
import lintModule from 'bpmn-js-bpmnlint';
import Modeler from 'bpmn-js/lib/Modeler'
// import bpmnlintConfig from './.bpmnlintrc';
import panel from './PropertyPanel'
import getInitStr from './flowable/init'
// 引入flowable的节点文件
import FlowableModule from './flowable/flowable.json'
import customControlsModule from './customPanel'

export default {
  name: 'WorkflowBpmnModeler',
  components: {
    panel
  },
  props: {
    xml: {
      type: String,
      default: ''
    },
    users: {
      type: Array,
      default: () => []
    },
    groups: {
      type: Array,
      default: () => []
    },
    categorys: {
      type: Array,
      default: () => []
    },
    exps: {
      type: Array,
      default: () => []
    },
    isView: {
      type: Boolean,
      default: false
    },
  },
  data() {
    return {
      modeler: null,
      zoom: 1
    }
  },
  watch: {
    xml: function(val) {
      if (val) {
        this.createNewDiagram(val)
      }
    }
  },
  mounted() {
    // 生成实例
    this.modeler = new Modeler({
      container: this.$refs.canvas,
      additionalModules: [
        lintModule,
        customControlsModule,
        { //汉化
          translate: ['value', customTranslate]
        },
      ],
      // 去除流程校验器,有需求可自行添加,需要在package.json 加入 "bpmnlint-plugin-local": "file:bpmnlint-plugin-local"
      // linting: {
      //   bpmnlint: bpmnlintConfig
      // },
      moddleExtensions: {
        flowable: FlowableModule
      }
    })
    // 新增流程定义
    if (!this.xml) {
      this.newDiagram()
    } else {
      this.createNewDiagram(this.xml)
    }
  },
  methods: {
    newDiagram() {
      this.createNewDiagram(getInitStr())
    },
    // 让图能自适应屏幕
    fitViewport() {
      this.zoom = this.modeler.get('canvas').zoom('fit-viewport')
      const bbox = document.querySelector('.flow-containers .viewport').getBBox()
      const currentViewbox = this.modeler.get('canvas').viewbox()
      const elementMid = {
        x: bbox.x + bbox.width / 2 - 65,
        y: bbox.y + bbox.height / 2
      }
      this.modeler.get('canvas').viewbox({
        x: elementMid.x - currentViewbox.width / 2,
        y: elementMid.y - currentViewbox.height / 2,
        width: currentViewbox.width,
        height: currentViewbox.height
      })
      this.zoom = bbox.width / currentViewbox.width * 1.8
    },
    // 放大缩小
    zoomViewport(zoomIn = true) {
      this.zoom = this.modeler.get('canvas').zoom()
      this.zoom += (zoomIn ? 0.1 : -0.1)
      this.modeler.get('canvas').zoom(this.zoom)
    },
    async createNewDiagram(data) {
      // 将字符串转换成图显示出来
      // data = data.replace(/<!\[CDATA\[(.+?)]]>/g, '&lt;![CDATA[$1]]&gt;')
      data = data.replace(/<!\[CDATA\[(.+?)]]>/g, function(match, str) {
        return str.replace(/</g, '&lt;')
      })
      try {
        await this.modeler.importXML(data)
        // this.adjustPalette()
        this.fitViewport()
      } catch (err) {
        console.error(err.message, err.warnings)
      }
    },
    // 对外 api
    getProcess() {
      const element = this.getProcessElement()
      return {
        id: element.id,
        name: element.name,
        category: element.$attrs['flowable:processCategory']
      }
    },
    getProcessElement() {
      const rootElements = this.modeler.getDefinitions().rootElements
      for (let i = 0; i < rootElements.length; i++) {
        if (rootElements[i].$type === 'bpmn:Process') return rootElements[i]
      }
    },
    async verifyXML(){
      const linting = this.modeler.get('linting')
      linting.toggle();
    },
    async saveXML(download = false) {
      try {
        const { xml } = await this.modeler.saveXML({ format: true })
        if (download) {
          this.downloadFile(`${this.getProcessElement().name}.bpmn20.xml`, xml, 'application/xml')
        }
        return xml
      } catch (err) {
        console.log(err)
      }
    },
    async showXML() {
      try {
        const xml = await this.saveXML()
        this.$emit('showXML',xml)
      } catch (err) {
        console.log(err)
      }
    },
    async saveImg(type = 'svg', download = false) {
      try {
        const { svg } = await this.modeler.saveSVG({ format: true })
        if (download) {
          this.downloadFile(this.getProcessElement().name, svg, 'image/svg+xml')
        }
        return svg
      } catch (err) {
        console.log(err)
      }
    },
    async save() {
      const process = this.getProcess()
      const xml = await this.saveXML()
      const svg = await this.saveImg()
      const result = { process, xml, svg }
      this.$emit('save', result)
      window.parent.postMessage(result, '*')
    },
    openBpmn(file) {
      const reader = new FileReader()
      reader.readAsText(file, 'utf-8')
      reader.onload = () => {
        this.createNewDiagram(reader.result)
      }
      return false
    },
    downloadFile(filename, data, type) {
      const a = document.createElement('a');
      const url = window.URL.createObjectURL(new Blob([data], {type: type}));
      a.href = url
      a.download = filename
      a.click()
      window.URL.revokeObjectURL(url)
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
  // background-color: #ffffff;
  width: 100%;
  height: 100%;
  .canvas {
    width: 100%;
    height: 100%;
    //flex: 1;
    //position: relative;
    //background: url("data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGRlZnM+PHBhdHRlcm4gaWQ9ImEiIHdpZHRoPSI0MCIgaGVpZ2h0PSI0MCIgcGF0dGVyblVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHBhdGggZD0iTTAgMTBoNDBNMTAgMHY0ME0wIDIwaDQwTTIwIDB2NDBNMCAzMGg0ME0zMCAwdjQwIiBmaWxsPSJub25lIiBzdHJva2U9IiNlMGUwZTAiIG9wYWNpdHk9Ii4yIi8+PHBhdGggZD0iTTQwIDBIMHY0MCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZTBlMGUwIi8+PC9wYXR0ZXJuPjwvZGVmcz48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJ1cmwoI2EpIi8+PC9zdmc+")
    //repeat !important;
    //div.toggle-mode {
    //  display: none;
    //}
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
    //min-height: 650px;
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
   // .djs-connection > .djs-visual > path {
   //   stroke: orange !important;
   //   stroke-dasharray: 4px !important;
   //   fill-opacity: 0.2 !important;
   // }
   // .djs-shape .djs-visual > :nth-child(1) {
   //   fill: orange !important;
   //   stroke: orange !important;
   //   stroke-dasharray: 4px !important;
   //   fill-opacity: 0.2 !important;
   // }
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
