<template>
  <div>
    <x-form ref="xForm" v-model="formData" :config="formConfig">
      <template #executionListener>
        <el-badge :value="executionListenerLength">
          <el-button size="small" @click="dialogName = 'executionListenerDialog'">编辑</el-button>
        </el-badge>
      </template>
      <template #taskListener>
        <el-badge :value="taskListenerLength">
          <el-button size="small" @click="dialogName = 'taskListenerDialog'">编辑</el-button>
        </el-badge>
      </template>
      <template #multiInstance>
        <el-badge :is-dot="hasMultiInstance">
          <el-button size="small" @click="dialogName = 'multiInstanceDialog'">编辑</el-button>
        </el-badge>
      </template>
      <template #checkSingleUser>
          <el-input placeholder="请选择人员" class="input-with-select" v-model="checkValues">
              <template slot="append">
                <!--指定用户-->
                <el-button style="padding-left: 7px" icon="el-icon-user" @click="singleUserCheck"/>
                <el-divider direction="vertical"></el-divider>
                <!--选择表达式-->
                <el-button style="padding-right: 7px" icon="el-icon-postcard" @click="singleExpCheck('assignee')"/>
              </template>
          </el-input>
      </template>
      <template #checkMultipleUser>
          <el-input placeholder="请选择候选用户" class="input-with-select" v-model="checkValues">
            <template slot="append">
              <!--候选用户-->
              <el-button style="padding-left: 7px" icon="el-icon-user" @click="multipleUserCheck"/>
              <el-divider direction="vertical"></el-divider>
              <!--选择表达式-->
              <el-button style="padding-right: 7px" icon="el-icon-postcard" @click="singleExpCheck('candidateUsers')"/>
            </template>
          </el-input>
      </template>
      <template #checkRole>
        <el-input placeholder="请选择候选角色" class="input-with-select" v-model="checkValues">
          <template slot="append">
          <!--候选角色-->
            <el-button style="padding-left: 7px" icon="el-icon-user" @click="multipleRoleCheck"/>
            <el-divider direction="vertical"></el-divider>
              <!--选择表达式-->
            <el-button style="padding-right: 7px" icon="el-icon-postcard" @click="singleExpCheck('candidateGroups')"/>
          </template>
        </el-input>
      </template>
    </x-form>
    <executionListenerDialog
      v-if="dialogName === 'executionListenerDialog'"
      :element="element"
      :modeler="modeler"
      @close="finishExecutionListener"
    />
    <taskListenerDialog
      v-if="dialogName === 'taskListenerDialog'"
      :element="element"
      :modeler="modeler"
      @close="finishTaskListener"
    />
    <multiInstanceDialog
      v-if="dialogName === 'multiInstanceDialog'"
      :element="element"
      :modeler="modeler"
      @close="finishMultiInstance"
    />
    <!--选择人员-->
    <el-dialog
      title="选择人员"
      :visible.sync="userVisible"
      width="60%"
      :close-on-press-escape="false"
      :show-close="false"
    >
    <flow-user :checkType="checkType" :selectValues="selectValues" @handleUserSelect="handleUserSelect"></flow-user>
    <span slot="footer" class="dialog-footer">
      <el-button @click="userVisible = false">取 消</el-button>
      <el-button type="primary" @click="checkUserComplete">确 定</el-button>
    </span>
    </el-dialog>
    <!--选择表达式-->
    <el-dialog
      title="选择表达式"
      :visible.sync="expVisible"
      width="60%"
      :close-on-press-escape="false"
      :show-close="false"
    >
      <flow-exp :selectValues="selectValues" @handleSingleExpSelect="handleSingleExpSelect"></flow-exp>
      <span slot="footer" class="dialog-footer">
      <el-button @click="expVisible = false">取 消</el-button>
      <el-button type="primary" @click="checkExpComplete">确 定</el-button>
    </span>
    </el-dialog>
    <!--选择角色-->
    <el-dialog
      title="选择候选角色"
      :visible.sync="roleVisible"
      width="60%"
      :close-on-press-escape="false"
      :show-close="false"
    >
      <flow-role :checkType="checkType" :selectValues="selectValues" @handleRoleSelect="handleRoleSelect"></flow-role>
      <span slot="footer" class="dialog-footer">
      <el-button @click="roleVisible = false">取 消</el-button>
      <el-button type="primary" @click="checkRoleComplete">确 定</el-button>
    </span>
    </el-dialog>
  </div>
</template>

<script>
import mixinPanel from '../../common/mixinPanel'
import executionListenerDialog from './property/executionListener'
import taskListenerDialog from './property/taskListener'
import multiInstanceDialog from './property/multiInstance'
import { commonParse, userTaskParse } from '../../common/parseElement'
import {StrUtil} from '@/utils/StrUtil'
import FlowUser from '@/components/flow/User'
import FlowRole from '@/components/flow/Role'
import FlowExp from '@/components/flow/Expression'
import { listAllForm } from '@/api/flowable/form'

export default {
  components: {
    executionListenerDialog,
    taskListenerDialog,
    multiInstanceDialog,
    FlowUser,
    FlowRole,
    FlowExp,
  },
  mixins: [mixinPanel],
  props: {
    users: {
      type: Array,
      required: true
    },
    groups: {
      type: Array,
      required: true
    },
    exps: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      userTypeOption: [
        { label: '指定人员', value: 'assignee' },
        { label: '候选人员', value: 'candidateUsers' },
        { label: '候选角色', value: 'candidateGroups' }
      ],
      dialogName: '',
      executionListenerLength: 0,
      taskListenerLength: 0,
      hasMultiInstance: false,
      userVisible: false,
      roleVisible: false,
      expVisible: false,
      formData: {},
      assignee: null,
      candidateUsers: null,
      candidateGroups: null,
      // 选类型
      checkType: 'single',
      // 选中的值
      checkValues: null,
      // 数据回显
      selectValues: null,
      // 用户列表
      userList: this.users,
      // 角色列表
      groupList: this.groups,
      // 表达式列表
      expList: this.exps,
      // 表达式类型
      expType: null,
      // 表单列表
      formList: [],
    }
  },
  computed: {
    formConfig() {
      const _this = this
      return {
        inline: false,
        item: [
          {
            xType: 'input',
            name: 'id',
            label: '节点 id',
            rules: [{ required: true, message: 'Id 不能为空' }]
          },
          {
            xType: 'input',
            name: 'name',
            label: '节点名称',
            rules: [{ required: true, message: '节点名称不能为空' }]
          },
          {
            xType: 'input',
            name: 'documentation',
            label: '节点描述'
          },
          {
            xType: 'slot',
            name: 'executionListener',
            label: '执行监听器'
          },
          {
            xType: 'slot',
            name: 'taskListener',
            label: '任务监听器',
            show: !!_this.showConfig.taskListener
          },
          {
            xType: 'select',
            name: 'userType',
            label: '用户类型',
            // clearable: true,
            dic: _this.userTypeOption,
            // rules: [{ required: true, message: '用户类型不能为空' }],
            show: !!_this.showConfig.userType
          },
          {
            xType: 'slot',
            name: 'checkSingleUser',
            label: '指定人员',
            // rules: [{ required: true, message: '指定人员不能为空' }],
            show: !!_this.showConfig.assignee && _this.formData.userType === 'assignee'
          },
          {
            xType: 'slot',
            name: 'checkMultipleUser',
            label: '候选人员',
            // rules: [{ required: true, message: '候选人员不能为空' }],
            show: !!_this.showConfig.candidateUsers && _this.formData.userType === 'candidateUsers'
          },
          {
            xType: 'slot',
            name: 'checkRole',
            label: '候选角色',
            // rules: [{ required: true, message: '候选角色不能为空' }],
            show: !!_this.showConfig.candidateGroups && _this.formData.userType === 'candidateGroups'
          },
          {
            xType: 'slot',
            name: 'multiInstance',
            label: '多实例'
          },
          {
            xType: 'switch',
            name: 'async',
            label: '异步',
            activeText: '是',
            inactiveText: '否',
            show: !!_this.showConfig.async
          },
          {
            xType: 'input',
            name: 'priority',
            label: '优先级',
            show: !!_this.showConfig.priority
          },
          // {
          //   xType: 'input',
          //   name: 'formKey',
          //   label: '表单标识key',
          //   show: !!_this.showConfig.formKey
          // },
          {
            xType: 'select',
            name: 'formKey',
            label: '表单标识key',
            clearable: true,
            dic: { data: _this.formList, label: 'formName', value: 'formId' },
            show: !!_this.showConfig.formKey
          },
          {
            xType: 'input',
            name: 'skipExpression',
            label: '跳过表达式',
            show: !!_this.showConfig.skipExpression
          },
          {
            xType: 'switch',
            name: 'isForCompensation',
            label: '是否为补偿',
            activeText: '是',
            inactiveText: '否',
            show: !!_this.showConfig.isForCompensation
          },
          {
            xType: 'switch',
            name: 'triggerable',
            label: '服务任务可触发',
            activeText: '是',
            inactiveText: '否',
            show: !!_this.showConfig.triggerable
          },
          {
            xType: 'switch',
            name: 'autoStoreVariables',
            label: '自动存储变量',
            activeText: '是',
            inactiveText: '否',
            show: !!_this.showConfig.autoStoreVariables
          },
          {
            xType: 'input',
            name: 'ruleVariablesInput',
            label: '输入变量',
            show: !!_this.showConfig.ruleVariablesInput
          },
          {
            xType: 'input',
            name: 'rules',
            label: '规则',
            show: !!_this.showConfig.rules
          },
          {
            xType: 'input',
            name: 'resultVariable',
            label: '结果变量',
            show: !!_this.showConfig.resultVariable
          },
          {
            xType: 'switch',
            name: 'exclude',
            label: '排除',
            activeText: '是',
            inactiveText: '否',
            show: !!_this.showConfig.exclude
          },
          {
            xType: 'input',
            name: 'class',
            label: '类',
            show: !!_this.showConfig.class
          },
          {
            xType: 'datePicker',
            type: 'datetime',
            valueFormat: 'yyyy-MM-ddTHH:mm:ss',
            name: 'dueDate',
            label: '到期时间',
            show: !!_this.showConfig.dueDate
          }
        ]
      }
    }
  },
  watch: {
    'formData.userType': function(val, oldVal) {
      if (StrUtil.isNotBlank(oldVal)) {
          delete this.element.businessObject.$attrs[`flowable:${oldVal}`]
          delete this.formData[oldVal]
          // 清除已选人员数据
          this.checkValues = '';
          this.selectValues = null;
          // 删除xml中已选择数据类型节点
          delete this.element.businessObject.$attrs[`flowable:dataType`]
      }
      // 写入userType节点信息到xml
      this.updateProperties({'flowable:userType': val})
    },
    'formData.async': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'flowable:async': val})
      }
    },
    'formData.dueDate': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'flowable:dueDate': val})
      }
    },
    'formData.formKey': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'flowable:formKey': val})
      } else {
        // 删除xml中已选择表单信息
        delete this.element.businessObject[`formKey`]
      }
    },
    'formData.priority': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'flowable:priority': val})
      }
    },
    'formData.skipExpression': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'flowable:skipExpression': val})
      } else {
        delete this.element.businessObject.$attrs[`flowable:skipExpression`]
      }
    },
    'formData.isForCompensation': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'isForCompensation': val})
      }
    },
    'formData.triggerable': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'flowable:triggerable': val})
      }
    },
    'formData.class': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'flowable:class': val})
      }
    },
    'formData.autoStoreVariables': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'flowable:autoStoreVariables': val})
      }
    },
    'formData.exclude': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'flowable:exclude': val})
      }
    },
    'formData.ruleVariablesInput': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'flowable:ruleVariablesInput': val})
      }
    },
    'formData.rules': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'flowable:rules': val})
      }
    },
    'formData.resultVariable': function(val) {
      if (StrUtil.isNotBlank(val)) {
        this.updateProperties({'flowable:resultVariable': val})
      }
    }
  },
  created() {
    let cache = commonParse(this.element)
    cache = userTaskParse(cache)
    this.formData = cache
    this.computedExecutionListenerLength()
    this.computedTaskListenerLength()
    this.computedHasMultiInstance()
    // 人员信息回显
    this.checkValuesEcho();
    // 加载表单列表
    this.getListForm();
  },
  methods: {
    computedExecutionListenerLength() {
      this.executionListenerLength = this.element.businessObject.extensionElements?.values
        ?.filter(item => item.$type === 'flowable:ExecutionListener').length ?? 0
    },
    computedTaskListenerLength() {
      this.taskListenerLength = this.element.businessObject.extensionElements?.values
        ?.filter(item => item.$type === 'flowable:TaskListener').length ?? 0
    },
    computedHasMultiInstance() {
      if (this.element.businessObject.loopCharacteristics) {
        this.hasMultiInstance = true
      } else {
        this.hasMultiInstance = false
      }
    },
    // 获取表单信息
    getListForm(){
      listAllForm().then(res =>{
        res.data.forEach(item =>{
          item.formId = item.formId.toString();
        })
        this.formList = res.data;
      })
    },
    // 设计器右侧表单数据回显
    checkValuesEcho(){
      const that = this;
      const attrs = that.element.businessObject.$attrs;
      const businessObject = that.element.businessObject;
      console.log(that.element.businessObject,"this.element.businessObject")
      // 指定用户
      if (attrs.hasOwnProperty("flowable:assignee")) {
        const val = attrs["flowable:assignee"];
        // 查找是否动态指定人员(选中流程表达式)
        if (attrs["flowable:dataType"] === "dynamic") {
          this.checkValues = that.expList.find(item => item.expression == val).name;
          this.selectValues = that.expList.find(item => item.expression == val).id;
        } else {
          this.checkValues = that.userList.find(item => item.userId == val).nickName;
          this.selectValues = that.userList.find(item => item.userId == val).userId;
        }
        // 候选用户
      } else if (attrs.hasOwnProperty("flowable:candidateUsers")) {
        const val = attrs["flowable:candidateUsers"];
        if (attrs["flowable:dataType"] === "dynamic") {
          this.checkValues = that.expList.find(item => item.expression == val).name;
          this.selectValues = that.expList.find(item => item.expression == val).id;
        } else {
          const newArr = that.userList.filter(i => val.split(',').includes(i.userId))
          this.checkValues =  newArr.map(item => item.nickName).join(',');
          this.selectValues = newArr.map(item => item.userId).join(',');
        }
      } else if (businessObject.hasOwnProperty("candidateGroups") || attrs.hasOwnProperty("flowable:candidateGroups") ) {
        // 候选角色信息
        const val = businessObject["candidateGroups"] || attrs["flowable:candidateGroups"];
        if (attrs["flowable:dataType"] === "dynamic") {
          this.checkValues = that.expList.find(item => item.expression == val).name;
          this.selectValues = that.expList.find(item => item.expression == val).id;
        } else {
          const newArr = that.groupList.filter(i => val.split(',').includes(i.roleId))
          this.checkValues =  newArr.map(item => item.roleName).join(',');
          this.selectValues = newArr.map(item => item.roleId).join(',');
        }
      }
    },
    finishExecutionListener() {
      if (this.dialogName === 'executionListenerDialog') {
        this.computedExecutionListenerLength()
      }
      this.dialogName = ''
    },
    finishTaskListener() {
      if (this.dialogName === 'taskListenerDialog') {
        this.computedTaskListenerLength()
      }
      this.dialogName = ''
    },
    finishMultiInstance() {
      if (this.dialogName === 'multiInstanceDialog') {
        this.computedHasMultiInstance()
      }
      this.dialogName = ''
    },
    /*单选人员*/
    singleUserCheck(){
      this.userVisible = true;
      this.checkType = "single";
    },
    /*多选人员*/
    multipleUserCheck(){
      this.userVisible = true;
      this.checkType = "multiple";
    },
    /*单选角色*/
    singleRoleCheck(){
      this.roleVisible = true;
      this.checkType = "single";
    },
    /*多选角色*/
    multipleRoleCheck(){
      this.roleVisible = true;
      this.checkType = "multiple";
    },
    /*单选表达式*/
    singleExpCheck(expType){
      this.expVisible = true;
      this.expType = expType;
    },
    // 选中表达式
    handleSingleExpSelect(selection) {
      this.deleteFlowAttar();
      this.updateProperties({'flowable:dataType': 'dynamic'})
      if ("assignee" === this.expType) {
        this.updateProperties({'flowable:assignee': selection.expression});
      } else if ("candidateUsers" === this.expType) {
        this.updateProperties({'flowable:candidateUsers': selection.expression});
      } else if ("candidateGroups" === this.expType) {
        this.updateProperties({'flowable:candidateGroups': selection.expression});
      }
      this.checkValues = selection.name;
      this.expType = null;
    },
    // 用户选中数据
    handleUserSelect(selection) {
      const that = this;
      if (selection) {
        that.deleteFlowAttar();
        that.updateProperties({'flowable:dataType': 'fixed'})
        if (selection instanceof Array) {
          const userIds = selection.map(item => item.userId);
          const nickName = selection.map(item => item.nickName);
          that.updateProperties({'flowable:candidateUsers': userIds.join(',')})
          that.checkValues = nickName.join(',');
        } else {
          that.updateProperties({'flowable:assignee': selection.userId})
          that.checkValues = selection.nickName;
        }
      }
    },
    // 角色选中数据
    handleRoleSelect(selection, name) {
      const that = this;
      if (selection && name) {
        that.deleteFlowAttar();
        that.updateProperties({'flowable:dataType': 'fixed'})
        that.updateProperties({'flowable:candidateGroups': selection});
        that.checkValues = name;
      }
    },
    /*用户选中赋值*/
    checkUserComplete(){
      this.userVisible = false;
      this.checkType = "";
    },
    /*候选角色选中赋值*/
    checkRoleComplete(){
      this.roleVisible = false;
      this.checkType = "";
      },
    /*表达式选中赋值*/
    checkExpComplete(){
      this.expVisible = false;
    },
    // 删除节点
    deleteFlowAttar(){
      delete this.element.businessObject.$attrs[`flowable:dataType`]
      delete this.element.businessObject.$attrs[`flowable:assignee`]
      delete this.element.businessObject.$attrs[`flowable:candidateUsers`]
      delete this.element.businessObject.$attrs[`flowable:candidateGroups`]
    }
  }
}
</script>

<style></style>
