<template>
  <div>
    <el-row>
      <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" label-width="68px">
        <el-form-item label="名称" prop="name">
          <el-input
            v-model="queryParams.name"
            placeholder="请输入名称"
            clearable
            @keyup.enter.native="handleQuery"
          />
        </el-form-item>
        <el-form-item label="监听类型" prop="type">
          <el-select v-model="queryParams.type" placeholder="请选择监听类型" clearable>
            <el-option
              v-for="dict in dict.type.sys_listener_type"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
          <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
        </el-form-item>
      </el-form>
    </el-row>

    <el-table v-loading="loading" :data="listenerList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="名称" align="center" prop="name"/>
      <el-table-column label="监听类型" align="center" prop="type">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_listener_type" :value="scope.row.type"/>
        </template>
      </el-table-column>
      <el-table-column label="事件类型" align="center" prop="eventType"/>
      <el-table-column label="值类型" align="center" prop="valueType">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_listener_value_type" :value="scope.row.valueType"/>
        </template>
      </el-table-column>
      <el-table-column label="执行内容" align="center" prop="value"/>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page-sizes="[5,10]"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script>
  import { listListener } from '@/api/system/listener'

  export default {
    name: 'FlowListener',
    dicts: ['sys_listener_value_type', 'sys_listener_type', 'common_status', 'sys_listener_event_type'],
    props: {
      selectValues: {
        type: Number | String | Array,
        default: null,
        required: false
      }
    },
    data() {
      return {
        /** 遮罩层 */
        loading: true,
        /** 流程监听表格数据 */
        listenerList: [],
        /** 总条数 */
        total: 0,
        /** 查询参数 */
        queryParams: {
          pageNum: 1,
          pageSize: 5,
          name: null,
          type: null,
          eventType: null,
          valueType: null,
          value: null,
          status: null
        }
      }
    },
    mounted() {
      this.getList()
    },
    methods: {
      /** 查询流程监听列表 */
      getList() {
        this.loading = true
        listListener(this.queryParams).then(response => {
          this.listenerList = response.rows
          this.total = response.total
          this.loading = false
        })
      },
      /** 搜索按钮操作 */
      handleQuery() {
        this.queryParams.pageNum = 1
        this.getList()
      },
      /** 重置按钮操作 */
      resetQuery() {
        this.resetForm('queryForm')
        this.handleQuery()
      },
      /** 多选框选中数据 */
      handleSelectionChange(selection) {
        this.$emit('handleSelect', selection)
      }
    }
  }
</script>

<style scoped>

</style>
