<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入名称"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="开始时间" prop="deployTime">
        <el-date-picker clearable size="small"
                        v-model="queryParams.deployTime"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="选择时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-upload"
          size="mini"
          @click="handleImport"
        >导入</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleLoadXml"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:deployment:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:deployment:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" fit :data="definitionList" border   @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="流程编号" align="center" prop="deploymentId" :show-overflow-tooltip="true"/>
      <el-table-column label="流程标识" align="center" prop="flowKey" :show-overflow-tooltip="true" />
      <el-table-column label="流程分类" align="center" prop="category" />
      <el-table-column label="流程名称" align="center" :show-overflow-tooltip="true">
        <template slot-scope="scope">
          <el-button type="text" @click="handleReadImage(scope.row.deploymentId)">
            <span>{{ scope.row.name }}</span>
          </el-button>
        </template>
      </el-table-column>
      <el-table-column label="业务表单" align="center" :show-overflow-tooltip="true">
        <template slot-scope="scope">
          <el-button v-if="scope.row.formId" type="text" @click="handleForm(scope.row.formId)">
            <span>{{ scope.row.formName }}</span>
          </el-button>
          <label v-else>暂无表单</label>
        </template>
      </el-table-column>
      <el-table-column label="流程版本" align="center">
        <template slot-scope="scope">
          <el-tag size="medium" >v{{ scope.row.version }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center">
        <template slot-scope="scope">
          <el-tag type="success" v-if="scope.row.suspensionState === 1">激活</el-tag>
          <el-tag type="warning" v-if="scope.row.suspensionState === 2">挂起</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="部署时间" align="center" prop="deploymentTime" width="180"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-dropdown>
            <span class="el-dropdown-link">
              更多操作<i class="el-icon-arrow-down el-icon--right"></i>
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item icon="el-icon-edit-outline" @click.native="handleLoadXml(scope.row)">
                编辑
              </el-dropdown-item>
              <el-dropdown-item icon="el-icon-connection" @click.native="handleAddForm(scope.row)" v-if="scope.row.formId == null">
                配置表单
              </el-dropdown-item>
              <el-dropdown-item icon="el-icon-video-pause" @click.native="handleUpdateSuspensionState(scope.row)" v-if="scope.row.suspensionState === 1">
                挂起
              </el-dropdown-item>
              <el-dropdown-item icon="el-icon-video-play" @click.native="handleUpdateSuspensionState(scope.row)" v-if="scope.row.suspensionState === 2">
                激活
              </el-dropdown-item>
              <el-dropdown-item icon="el-icon-delete" @click.native="handleDelete(scope.row)" v-hasPermi="['system:deployment:remove']">
                删除
              </el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改流程定义对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="看看" prop="name">
          <el-input v-model="form.name" placeholder="请输入看看" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>


    <!-- bpmn20.xml导入对话框 -->
    <el-dialog :title="upload.title" :visible.sync="upload.open" width="400px" append-to-body>
      <el-upload
        ref="upload"
        :limit="1"
        accept=".xml"
        :headers="upload.headers"
        :action="upload.url + '?name=' + upload.name+'&category='+ upload.category"
        :disabled="upload.isUploading"
        :on-progress="handleFileUploadProgress"
        :on-success="handleFileSuccess"
        :auto-upload="false"
        drag
      >
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">
          将文件拖到此处，或
          <em>点击上传</em>
        </div>
        <div class="el-upload__tip" slot="tip">
          流程名称：<el-input v-model="upload.name"/>
          流程分类：<el-input v-model="upload.category"/>
        </div>
        <div class="el-upload__tip" style="color:red" slot="tip">提示：仅允许导入“bpmn20.xml”格式文件！</div>
      </el-upload>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitFileForm">确 定</el-button>
        <el-button @click="upload.open = false">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 流程图 -->
    <el-dialog :title="readImage.title" :visible.sync="readImage.open" width="70%" append-to-body>
      <!-- <el-image :src="readImage.src"></el-image> -->
       <flow :xmlData="xmlData"/>
    </el-dialog>

    <!--表单配置详情-->
    <el-dialog :title="formTitle" :visible.sync="formConfOpen" width="50%" append-to-body>
      <div class="test-form">
        <parser :key="new Date().getTime()"  :form-conf="formConf" />
      </div>
    </el-dialog>

    <!--挂载表单-->
    <el-dialog :title="formDeployTitle" :visible.sync="formDeployOpen" width="60%" append-to-body>
      <el-row :gutter="24">
        <el-col :span="10" :xs="24">
          <el-table
            ref="singleTable"
            :data="formList"
            border
            highlight-current-row
            @current-change="handleCurrentChange"
            style="width: 100%">
            <el-table-column label="表单编号" align="center" prop="formId" />
            <el-table-column label="表单名称" align="center" prop="formName" />
            <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
              <template slot-scope="scope">
                <el-button size="mini" type="text" @click="submitFormDeploy(scope.row)">确定</el-button>
              </template>
            </el-table-column>
          </el-table>

          <pagination
            small
            layout="prev, pager, next"
            v-show="formTotal>0"
            :total="formTotal"
            :page.sync="formQueryParams.pageNum"
            :limit.sync="formQueryParams.pageSize"
            @pagination="ListFormDeploy"
          />
        </el-col>
        <el-col :span="14" :xs="24">
          <div v-if="currentRow">
            <parser :key="new Date().getTime()" :form-conf="currentRow" />
          </div>
        </el-col>
      </el-row>
    </el-dialog>
  </div>
</template>

<script>
import { listDefinition, updateState, delDeployment, addDeployment, updateDeployment, exportDeployment, definitionStart, readXml} from "@/api/flowable/definition";
import { getToken } from "@/utils/auth";
import { getForm, addDeployForm ,listForm } from "@/api/flowable/form";
import Parser from '@/components/parser/Parser'
import flow from '@/views/flowable/task/record/flow'

export default {
  name: "Definition",
  components: {
    Parser,
    flow
  },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 流程定义表格数据
      definitionList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      formConfOpen: false,
      formTitle: "",
      formDeployOpen: false,
      formDeployTitle: "",
      formList: [],
      formTotal:0,
      formConf: {}, // 默认表单数据
      readImage:{
        open: false,
        src: "",
      },
      // bpmn.xml 导入
      upload: {
        // 是否显示弹出层（xml导入）
        open: false,
        // 弹出层标题（xml导入）
        title: "",
        // 是否禁用上传
        isUploading: false,
        name: null,
        category: null,
        // 设置上传的请求头部
        headers: { Authorization: "Bearer " + getToken() },
        // 上传的地址
        url: process.env.VUE_APP_BASE_API + "/flowable/definition/import"
      },
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        name: null,
        category: null,
        key: null,
        tenantId: null,
        deployTime: null,
        derivedFrom: null,
        derivedFromRoot: null,
        parentDeploymentId: null,
        engineVersion: null
      },
      formQueryParams:{
        pageNum: 1,
        pageSize: 10,
      },
      // 挂载表单到流程实例
      formDeployParam:{
        formId: null,
        deployId: null
      },
      currentRow: null,
      // xml
      xmlData:"",
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询流程定义列表 */
    getList() {
      this.loading = true;
      listDefinition(this.queryParams).then(response => {
        this.definitionList = response.data.records;
        this.total = response.data.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        name: null,
        category: null,
        key: null,
        tenantId: null,
        deployTime: null,
        derivedFrom: null,
        derivedFromRoot: null,
        parentDeploymentId: null,
        engineVersion: null
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.deploymentId)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加流程定义";
    },
    /** 跳转到流程设计页面 */
    handleLoadXml(row){
      this.$router.push({ path: '/flowable/definition/model',query: { deployId: row.deploymentId }})
    },
    /** 流程图查看 */
    handleReadImage(deploymentId){
      this.readImage.title = "流程图";
      this.readImage.open = true;
      // this.readImage.src = process.env.VUE_APP_BASE_API + "/flowable/definition/readImage/" + deploymentId;
       // 发送请求，获取xml
      readXml(deploymentId).then(res =>{
        this.xmlData = res.data
      })
    },
    /** 表单查看 */
    handleForm(formId){
      getForm(formId).then(res =>{
        this.formTitle = "表单详情";
        this.formConfOpen = true;
        this.formConf = JSON.parse(res.data.formContent)
      })
    },
    /** 启动流程 */
    handleDefinitionStart(row){
      definitionStart(row.id).then(res =>{
        this.msgSuccess(res.msg);
      })
    },
    /** 挂载表单弹框 */
    handleAddForm(row){
      this.formDeployParam.deployId = row.deploymentId
      this.ListFormDeploy()
    },
    /** 挂载表单列表 */
    ListFormDeploy(){
      listForm(this.formQueryParams).then(res =>{
        this.formList = res.rows;
        this.formTotal = res.total;
        this.formDeployOpen = true;
        this.formDeployTitle = "挂载表单";
      })
    },
    // /** 更改挂载表单弹框 */
    // handleEditForm(row){
    //   this.formDeployParam.deployId = row.deploymentId
    //   const queryParams = {
    //     pageNum: 1,
    //     pageSize: 10
    //   }
    //   listForm(queryParams).then(res =>{
    //     this.formList = res.rows;
    //     this.formDeployOpen = true;
    //     this.formDeployTitle = "挂载表单";
    //   })
    // },
    /** 挂载表单 */
    submitFormDeploy(row){
      this.formDeployParam.formId = row.formId;
      addDeployForm(this.formDeployParam).then(res =>{
        this.msgSuccess(res.msg);
        this.formDeployOpen = false;
        this.getList();
      })
    },
    handleCurrentChange(data) {
      if (data) {
        this.currentRow = JSON.parse(data.formContent);
      }
    },
    /** 挂起/激活流程 */
    handleUpdateSuspensionState(row){
      let state = 1;
      if (row.suspensionState === 1) {
          state = 2
      }
      const params = {
        deployId: row.deploymentId,
        state: state
      }
      updateState(params).then(res => {
        this.msgSuccess(res.msg);
        this.getList();
      });
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.deploymentId || this.ids
      getDeployment(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改流程定义";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateDeployment(this.form).then(response => {
              this.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addDeployment(this.form).then(response => {
              this.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const deploymentIds = row.deploymentId || this.ids;
      this.$confirm('是否确认删除流程定义编号为"' + deploymentIds + '"的数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function() {
        return delDeployment(deploymentIds);
      }).then(() => {
        this.getList();
        this.msgSuccess("删除成功");
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有流程定义数据项?', "警告", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(function() {
        return exportDeployment(queryParams);
      }).then(response => {
        this.download(response.msg);
      })
    },
    /** 导入bpmn.xml文件 */
    handleImport(){
      this.upload.title = "bpmn20.xml文件导入";
      this.upload.open = true;
    },
    // 文件上传中处理
    handleFileUploadProgress(event, file, fileList) {
      this.upload.isUploading = true;
    },
    // 文件上传成功处理
    handleFileSuccess(response, file, fileList) {
      this.upload.open = false;
      this.upload.isUploading = false;
      this.$refs.upload.clearFiles();
      this.$message(response.msg);
      this.getList();
    },
    // 提交上传文件
    submitFileForm() {
      this.$refs.upload.submit();
    }
  }
};
</script>
