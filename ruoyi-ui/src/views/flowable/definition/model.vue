<template>
  <div>
    <bpmn-modeler
      ref="refNode"
      :xml="xml"
      :users="users"
      :groups="groups"
      :categorys="categorys"
      :exps="exps"
      :is-view="false"
      @save="save"
      @showXML="showXML"
    />
    <!--在线查看xml-->
    <el-drawer :title="xmlTitle" :modal="false" direction="rtl" :visible.sync="xmlOpen" size="60%">
      <!-- 设置对话框内容高度 -->
        <el-scrollbar>
            <pre v-highlight="xmlData"><code class="xml"></code></pre>
        </el-scrollbar>
    </el-drawer>
  </div>
</template>
<script>
import {readXml, roleList, saveXml, userList,expList} from "@/api/flowable/definition";
import bpmnModeler from '@/components/Process/index'
import vkBeautify from 'vkbeautify'
import hljs from 'highlight.js'
import 'highlight.js/styles/atelier-savanna-dark.css'

export default {
  name: "Model",
  components: {
    bpmnModeler,
    vkBeautify
  },
  // 自定义指令
  directives: {
    deep: true,
    highlight:{
      deep: true,
      bind: function bind(el, binding) {
        const targets = el.querySelectorAll('code');
        let target;
        let i;
        for (i = 0; i < targets.length; i += 1) {
          target = targets[i];
          if (typeof binding.value === 'string') {
            target.textContent = binding.value;
          }
          hljs.highlightBlock(target);
        }
      },
      componentUpdated: function componentUpdated(el, binding) {
        const targets = el.querySelectorAll('code');
        let target;
        let i;
        for (i = 0; i < targets.length; i += 1) {
          target = targets[i];
          if (typeof binding.value === 'string') {
            target.textContent = binding.value;
            hljs.highlightBlock(target);
          }
        }
      },
    }
  },
  data() {
    return {
      xml: "", // 后端查询到的xml
      modeler:"",
      xmlOpen: false,
      xmlTitle: '',
      xmlData: '',
      users: [],
      groups: [],
      categorys: [],
      exps: [],

    };
  },
  created () {
    const deployId = this.$route.query && this.$route.query.deployId;
    //  查询流程xml
    if (deployId) {
      this.getXmlData(deployId);
    }
    this.getDicts("sys_process_category").then(res => {
      this.categorys = res.data;
    });
    this.getDataList()
  },
  methods: {
    /** xml 文件 */
    getXmlData(deployId) {
      // 发送请求，获取xml
      readXml(deployId).then(res =>{
        this.xml = res.data;
        this.modeler = res.data
      })
    },
    /** 保存xml */
    save(data) {
      const params = {
        name: data.process.name,
        category: data.process.category,
        xml: data.xml
      }
      saveXml(params).then(res => {
        this.$modal.msgSuccess(res.msg)
        // 关闭当前标签页并返回上个页面
        const obj = { path: "/flowable/definition", query: { t: Date.now()} };
        this.$tab.closeOpenPage(obj);
      })
    },
    /** 指定流程办理人员列表 */
    getDataList() {
      userList().then(res =>{
        res.data.forEach(val =>{
          val.userId = val.userId.toString();
        })
        this.users = res.data;
        // let arr = {nickName: "流程发起人", userId: "${INITIATOR}"}
        // this.users.push(arr)
      });
      roleList().then(res =>{
        res.data.forEach(val =>{
          val.roleId = val.roleId.toString();
        })
        this.groups = res.data;
      });
      expList().then(res =>{
        this.exps = res.data;
      });
    },
    /** 展示xml */
    showXML(xmlData){
      this.xmlTitle = 'xml查看';
      this.xmlOpen = true;
      this.xmlData = vkBeautify.xml(xmlData);
    },
  },
};
</script>
<style lang="scss" scoped>
.content-box{
  line-height: 10px;
}
// 修改对话框高度
.showAll_dialog {
  display: flex;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  ::v-deep .el-dialog {
    margin: 0 auto !important;
    height: 80%;
    overflow: hidden;
    background-color: #ffffff;
    .el-dialog__body {
      position: absolute;
      left: 0;
      top: 54px;
      bottom: 0;
      right: 0;
      z-index: 1;
      overflow: hidden;
      overflow-y: auto;
      // 下边设置字体，我的需求是黑底白字
      color: #ffffff;
      padding: 0 15px;
    }
  }
}
</style>
