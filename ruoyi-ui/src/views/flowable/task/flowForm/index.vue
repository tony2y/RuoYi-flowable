<template>
  <div>
  <v-form-designer ref="vfDesigner" :designer-config="designerConfig">
    <!-- 保存按钮 -->
    <template #customSaveButton>
      <el-button type="text" @click="saveFormJson"><i class="el-icon-s-promotion" />保存</el-button>
    </template>
  </v-form-designer>

  <!--系统表单信息-->
  <el-dialog :title="formTitle" :visible.sync="formOpen" width="500px" append-to-body>
    <el-form ref="form" :model="form" :rules="rules" label-width="80px">
      <el-form-item label="表单名称" prop="formName">
        <el-input v-model="form.formName" placeholder="请输入表单名称" />
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="form.remark" placeholder="请输入备注" />
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button type="primary" @click="submitForm">确 定</el-button>
      <el-button @click="cancel">取 消</el-button>
    </div>
  </el-dialog>
  </div>
</template>

<script>
import {addForm, getForm, updateForm} from "@/api/flowable/form";
import { StrUtil } from '@/utils/StrUtil'

export default {
  name: "flowForm",
  data() {
    return {
      formTitle: "",
      formOpen: false,
      // 表单校验
      rules: {
        formName: [
          { required: true, message: "表单名称不能为空", trigger: "blur" }
        ]
      },
      // 表单参数
      form: {
        formId: null,
        formName: null,
        formContent: null,
        remark: null
      },
      designerConfig: {
        generateSFCButton: false,
        exportCodeButton: false,  //是否显示导出代码按钮
        toolbarMaxWidth: 320,
        toolbarMinWidth: 300,  //设计器工具按钮栏最小宽度（单位像素）
        formHeader: false,
      },
    }
  },
  mounted() {
    const formId = this.$route.query && this.$route.query.formId;
    if (StrUtil.isNotBlank(formId)) {
      getForm(formId).then(res => {
        this.$nextTick(() => {
          // 加载表单json数据
          this.$refs.vfDesigner.setFormJson(JSON.parse(res.data.formContent))
        })
        this.form = res.data;
      })
    }else {
      this.$nextTick(() => {
        // 加载表单json数据
        this.$refs.vfDesigner.setFormJson({"widgetList":[],"formConfig":{"modelName":"formData","refName":"vForm","rulesName":"rules","labelWidth":80,"labelPosition":"left","size":"","labelAlign":"label-left-align","cssCode":"","customClass":"","functions":"","layoutType":"PC","onFormCreated":"","onFormMounted":"","onFormDataChange":"","onFormValidate":""}})
      })
    }
  },
  methods:{
    // 保存表单数据
    saveFormJson() {
      let formJson = this.$refs.vfDesigner.getFormJson()
      this.form.formContent = JSON.stringify(formJson);
      this.formOpen = true;
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.formId != null) {
            updateForm(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.formOpen = false;
            });
          } else {
            addForm(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.formOpen = false;
            });
          }
          // 关闭当前标签页并返回上个页面
          const obj = { path: "/flowable/form", query: { t: Date.now()} };
          this.$tab.closeOpenPage(obj);
        }
      });
    },
    // 取消按钮
    cancel() {
      this.formOpen = false;
      this.reset();
    },
  }
}
</script>

<style lang="scss" scoped>
body {
  margin: 0;  /* 如果页面出现垂直滚动条，则加入此行CSS以消除之 */
}
.el-container.main-container{
  background: #fff;
  margin-left: 0 !important;
}

</style>
