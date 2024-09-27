<template>
  <div>
  <el-form :model="bpmnFormData" label-width="80px" :rules="rules"  size="small">
      <el-form-item :label="bpmnFormData.$type === 'bpmn:Process'? '流程标识': '节点ID'" prop="id" @change="updateElementTask('id')">
        <el-input v-model="bpmnFormData.id"/>
      </el-form-item>
      <el-form-item :label="bpmnFormData.$type === 'bpmn:Process'? '流程名称': '节点名称'" prop="name">
        <el-input v-model="bpmnFormData.name"  @change="updateElementTask('name')"/>
      </el-form-item>
      <!--流程的基础属性-->
      <template v-if="bpmnFormData.$type === 'bpmn:Process'">
        <el-form-item label="流程分类" prop="processCategory">
          <el-select v-model="bpmnFormData.processCategory" placeholder="请选择流程分类" @change="updateElementTask('processCategory')">
            <el-option
                v-for="dict in dict.type.sys_process_category"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
            ></el-option>
          </el-select>
        </el-form-item>
      </template>
      <el-form-item v-if="bpmnFormData.$type === 'bpmn:SubProcess'" label="状态">
        <el-switch v-model="bpmnFormData.isExpanded" active-text="展开" inactive-text="折叠" @change="updateElementTask('isExpanded')" />
      </el-form-item>
<!--      <el-form-item label="节点描述">-->
<!--        <el-input :rows="2" type="textarea" v-model="bpmnFormData.documentation" @change="updateElementTask('documentation')"/>-->
<!--      </el-form-item>-->
  </el-form>
  </div>
</template>

<script>
import {StrUtil} from '@/utils/StrUtil'

export default {
  name: "CommonPanel",
  dicts: ['sys_process_category'],
  /** 组件传值  */
  props : {
    id: {
      type: String,
      required: true
    },
  },
  data() {
    return {
      rules:{
        id: [
          { required: true, message: '节点Id 不能为空', trigger: 'blur' },
        ],
        name: [
          { required: true, message: '节点名称不能为空', trigger: 'blur' },
        ],
      },
      bpmnFormData: {}
    }
  },
  /** 传值监听 */
  watch: {
    id: {
      handler(newVal) {
        if (StrUtil.isNotBlank(newVal)) {
          this.resetTaskForm();
        }
      },
      immediate: true, // 立即生效
    },
  },

  created() {

  },
  methods: {
    resetTaskForm() {
      this.bpmnFormData = JSON.parse(JSON.stringify(this.modelerStore.element.businessObject));
    },
    updateElementTask(key) {
      const taskAttr = Object.create(null);
      taskAttr[key] = this.bpmnFormData[key] || null;
      this.modelerStore.modeling.updateProperties(this.modelerStore.element, taskAttr);
    }
  }
}


</script>
