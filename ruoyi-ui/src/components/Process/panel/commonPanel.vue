<template>
  <div>
  <el-form :model="bpmnFormData" label-width="80px" :rules="rules"  size="small">
      <el-form-item :label="bpmnFormData.$type === 'bpmn:Process'? '流程标识': '节点ID'" prop="id">
        <el-input v-model="bpmnFormData.id" @change="updateElementTask('id')"/>
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
      <el-form-item label="节点描述">
        <el-input
          :rows="2"
          type="textarea"
          v-model="bpmnFormData.documentationValue"
          @change="updateDocumentation"
        />
      </el-form-item>
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
      // this.bpmnFormData = JSON.parse(JSON.stringify(this.modelerStore.element.businessObject));
      this.bpmnFormData = Object.assign({}, this.modelerStore.element.businessObject);

      // 使用 $set 确保 documentationValue 是响应式的
      this.$set(this.bpmnFormData, 'documentationValue', this.modelerStore.element.businessObject.documentation?.[0]?.text || '');
    },
    updateElementTask(key) {
      const taskAttr = Object.create(null);
      taskAttr[key] = this.bpmnFormData[key] || null;
      this.modelerStore.modeling.updateProperties(this.modelerStore.element, taskAttr);
    },
    updateDocumentation() {
      // 确保 modelerStore 是 BPMN.js 的 Modeler 实例
      const modeler = this.modelerStore.modeler; // 获取实际的 modeler 实例
      const moddle = modeler.get('moddle');      // 通过 modeler 获取 moddle
      const modeling = modeler.get('modeling');  // 通过 modeler 获取 modeling

      // 创建新的文档对象
      const documentation = moddle.create('bpmn:Documentation', {
        text: this.bpmnFormData.documentationValue
      });

      // 获取当前元素的扩展元素
      let extensionElements = this.modelerStore.element.businessObject.extensionElements;

      if (!extensionElements) {
        // 如果没有扩展元素，创建一个新的
        extensionElements = moddle.create('bpmn:ExtensionElements', {
          values: []
        });
      }

      // 更新文档
      modeling.updateProperties(this.modelerStore.element, {
        documentation: [documentation],
        extensionElements: extensionElements
      });

      // 强制更新模型
      this.modelerStore.modeler.get('commandStack').execute('element.updateProperties', {
        element: this.modelerStore.element,
        properties: {
          documentation: [documentation]
        }
      });

      this.$emit('save');
    }
  }
}


</script>
