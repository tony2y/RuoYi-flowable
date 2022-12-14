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
            <!--指定用户-->
            <el-button slot="append" size="mini" icon="el-icon-user" @click="singleUserCheck"></el-button>
            <el-divider direction="vertical"></el-divider>
            <!--选择表达式-->
            <el-button slot="append" size="mini" icon="el-icon-tickets" @click="singleExpCheck('assignee')"></el-button>
          </el-input>
      </template>
      <template #checkMultipleUser>
          <el-input placeholder="请选择候选用户" class="input-with-select" v-model="checkValues">
            <!--候选用户-->
            <el-button slot="append" size="mini" icon="el-icon-user" @click="multipleUserCheck"></el-button>
            <el-divider direction="vertical"></el-divider>
            <!--选择表达式-->
            <el-button slot="append" size="mini" icon="el-icon-tickets" @click="singleExpCheck('candidateUsers')"></el-button>
          </el-input>
      </template>
      <template #checkRole>
        <el-input placeholder="请选择候选角色" class="input-with-select" v-model="checkValues">
          <!--候选角色-->
<!--          <el-button slot="append" size="mini" icon="el-icon-user" @click="singleRoleCheck"></el-button>-->
<!--          <el-divider direction="vertical"></el-divider>-->
          <el-button slot="append" size="mini" icon="el-icon-user" @click="multipleRoleCheck"></el-button>
          <!--选择表达式-->
          <el-button slot="append" size="mini" icon="el-icon-tickets" @click="singleExpCheck('candidateGroups')"></el-button>
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
    <flow-user :checkType="checkType" @handleUserSelect="handleUserSelect"></flow-user>
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
      <flow-exp @handleSingleExpSelect="handleSingleExpSelect"></flow-exp>
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
      <flow-role :checkType="checkType" @handleRoleSelect="handleRoleSelect"></flow-role>
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
import FlowUser from '@/components/flow/User'
import FlowRole from '@/components/flow/Role'
import FlowExp from '@/components/flow/Expression'
import log from "@/views/monitor/job/log";

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
      dataTypeOption: [
        { label: '固定', value: 'fixed' },
        { label: '动态', value: 'dynamic' }
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
      candidateUsers: "",
      candidateGroups: null,
      // 选类型
      checkType: 'single',
      // 选中的值
      checkValues: null,
      // 用户列表
      userList: this.users,
      groupList: this.groups,
      expList: this.exps,
      // 表达式类型
      expType: null,
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
            dic: _this.userTypeOption,
            show: !!_this.showConfig.userType
          },
          // {
          //   xType: 'radio',
          //   name: 'dataType',
          //   label: '指定方式',
          //   dic: _this.dataTypeOption,
          //   show: !!_this.showConfig.dataType,
          //   rules: [{ required: true, message: '请指定方式' }]
          // },
          // {
          //   xType: 'select',
          //   name: 'assignee',
          //   label: '指定人员',
          //   allowCreate: true,
          //   filterable: true,
          //   dic: { data: _this.users, label: 'nickName', value: 'userId' },
          //   show: !!_this.showConfig.assignee && _this.formData.userType === 'assignee'
          // },
          // {
          //   xType: 'select',
          //   name: 'candidateUsers',
          //   label: '候选人员',
          //   multiple: true,
          //   allowCreate: true,
          //   filterable: true,
          //   dic: { data: _this.users, label: 'nickName', value: 'userId' },
          //   show: !!_this.showConfig.candidateUsers && _this.formData.userType === 'candidateUsers'
          // },
          // {
          //   xType: 'select',
          //   name: 'candidateGroups',
          //   label: '候选组',
          //   multiple: true,
          //   allowCreate: true,
          //   filterable: true,
          //   dic: { data: _this.groups, label: 'roleName', value: 'roleId' },
          //   show: !!_this.showConfig.candidateGroups && _this.formData.userType === 'candidateGroups'
          // },
          {
            xType: 'slot',
            name: 'checkSingleUser',
            label: '指定人员',
            // rules: [{ required: true, message: '指定人员不能为空' }],
            // dic: { data: _this.users, label: 'nickName', value: 'userId' },
            show: !!_this.showConfig.assignee && _this.formData.userType === 'assignee'
          },
          {
            xType: 'slot',
            name: 'checkMultipleUser',
            label: '候选人员',
            show: !!_this.showConfig.candidateUsers && _this.formData.userType === 'candidateUsers'
          },
          {
            xType: 'slot',
            name: 'checkRole',
            label: '候选角色',
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
          {
            xType: 'input',
            name: 'formKey',
            label: '表单标识key',
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
      if (oldVal) {
        const types = ['assignee', 'candidateUsers', 'candidateGroups']
        types.forEach(type => {
          delete this.element.businessObject.$attrs[`flowable:${type}`]
          delete this.formData[type]
          this.updateProperties({'flowable:userType': type})
        })
      }
    },
    // // 动态选择流程执行人
    // 'formData.dataType': function(val) {
    //   const that = this
    //   this.updateProperties({'flowable:dataType': val})
    //   if (val === 'dynamic') {
    //     this.updateProperties({'flowable:userType': that.formData.userType})
    //   }
    //   // 切换时 删除之前选中的值
    //   const types = ['assignee', 'candidateUsers', 'candidateGroups']
    //   types.forEach(type => {
    //     delete this.element.businessObject.$attrs[`flowable:${type}`]
    //     delete this.formData[type]
    //   })
    //   // 传值到父组件
    //   const params = {
    //     dataType: val,
    //     userType: this.formData.userType
    //   }
    //   this.$emit('dataType', params)
    // },
    // 'formData.assignee': function(val) {
    //     if (this.formData.userType !== 'assignee') {
    //       delete this.element.businessObject.$attrs[`flowable:assignee`]
    //       return
    //     }
    //     this.updateProperties({'flowable:assignee': val})
    // },
    // 'formData.candidateUsers': function(val) {
    //     if (this.formData.userType !== 'candidateUsers') {
    //       delete this.element.businessObject.$attrs[`flowable:candidateUsers`]
    //       return
    //     }
    //     this.updateProperties({'flowable:candidateUsers': val?.join(',')})
    // },
    // 'formData.candidateGroups': function(val) {
    //     if (this.formData.userType !== 'candidateGroups') {
    //       delete this.element.businessObject.$attrs[`flowable:candidateGroups`]
    //       return
    //     }
    //     this.updateProperties({'flowable:candidateGroups': val?.join(',')})
    // },
    'formData.async': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'flowable:async': val })
    },
    'formData.dueDate': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'flowable:dueDate': val })
    },
    'formData.formKey': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'flowable:formKey': val })
    },
    'formData.priority': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'flowable:priority': val })
    },
    'formData.skipExpression': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'flowable:skipExpression': val })
    },
    'formData.isForCompensation': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'isForCompensation': val })
    },
    'formData.triggerable': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'flowable:triggerable': val })
    },
    'formData.class': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'flowable:class': val })
    },
    'formData.autoStoreVariables': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'flowable:autoStoreVariables': val })
    },
    'formData.exclude': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'flowable:exclude': val })
    },
    'formData.ruleVariablesInput': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'flowable:ruleVariablesInput': val })
    },
    'formData.rules': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'flowable:rules': val })
    },
    'formData.resultVariable': function(val) {
      if (val === '') val = null
      this.updateProperties({ 'flowable:resultVariable': val })
    }
  },
  created() {
    let cache = commonParse(this.element)
    cache = userTaskParse(cache)
    this.formData = cache
    this.computedExecutionListenerLength()
    this.computedTaskListenerLength()
    this.computedHasMultiInstance()
    this.getCheckValues()
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
    // 数据回显
    getCheckValues(){
      const that = this;
      console.log(that.element.businessObject,"this.element.businessObject")
      const attrs = that.element.businessObject.$attrs;
      const businessObject = that.element.businessObject;
      // 指定用户
      if (attrs.hasOwnProperty("flowable:assignee")){
        const val = attrs["flowable:assignee"];
        // 查找是否动态指定人员(选中流程表达式)
        if (attrs["flowable:dataType"] === "dynamic"){
          this.checkValues =  that.expList.find(item => item.id == val).name;
        }else {
          this.checkValues = that.userList.find(item => item.userId == val).nickName;
        }
        // 候选用户
      } else if (attrs.hasOwnProperty("flowable:candidateUsers")) {
        const val = attrs["flowable:candidateUsers"];
        if (attrs["flowable:dataType"] === "dynamic") {
          this.checkValues = that.expList.find(item => item.id == val).name;
        } else {
          const array = [];
          const vals = val.split(',');
          vals.forEach(key => {
            const user = that.userList.find(item => item.userId == key)
            if (user) {
              array.push(user.nickName);
            }
          })
          this.checkValues = array.join(',');
      }
        // if (val.indexOf(",") !== -1) {
        //   const vals = val.split(',');
        //   vals.forEach(key => {
        //     const user = that.userList.find(item => item.userId == key)
        //     if (user) {
        //       array.push(user.nickName);
        //     }
        //   })
        //   this.checkValues = array.join(',');
        // }else {
        //   const user = that.userList.find(item => item.userId == val);
        //   this.checkValues = user.nickName;
        // }
      } else if (businessObject.hasOwnProperty("candidateGroups")){
        // 候选角色信息
        const val = businessObject["candidateGroups"];
        if (attrs["flowable:dataType"] === "dynamic") {
          this.checkValues = that.expList.find(item => item.id == val).name;
        } else {
          const array = [];
          const vals = val.split(',');
          vals.forEach(key => {
            const role = that.groupList.find(item => item.roleId == key)
            if (role) {
              array.push(role.roleName);
            }
          })
          this.checkValues = array.join(',');
        }
        // if (val.indexOf(",") !== -1) {
        //   const vals = val.split(',');
        //   vals.forEach(key => {
        //     const role = that.groupList.find(item => item.roleId == key)
        //     if (role) {
        //       array.push(role.roleName);
        //     }
        //   })
        //   this.checkValues = array.join(',');
        // }else {
        //   const role = that.groupList.find(item => item.roleId == val);
        //   this.checkValues = role.roleName;
        // }
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
    handleSingleExpSelect(selection){
      this.deleteFlowAttar();
      console.log(this.element.businessObject,"element.businessObject")
      this.updateProperties({'flowable:dataType': 'dynamic'})
      if ("assignee" === this.expType){
        this.updateProperties({'flowable:assignee': selection.id.toString()});
      }else if ("candidateUsers" === this.expType) {
        this.updateProperties({'flowable:candidateUsers': selection.id.toString()});
      }else if ("candidateGroups" === this.expType) {
        this.updateProperties({'flowable:candidateGroups': selection.id.toString()});
      }
      this.checkValues = selection.name;
      this.expType = null;
    },
    // 用户选中数据
    handleUserSelect(selection) {
      console.log(selection,"handleUserSelect")
      const that = this;
      if (selection) {
        that.deleteFlowAttar();
        this.updateProperties({'flowable:dataType': 'fixed'})
        if (selection instanceof Array){
          const userIds = selection.map(item => item.userId);
          const nickName = selection.map(item => item.nickName);
          that.updateProperties({'flowable:candidateUsers': userIds.join(',')})
          that.checkValues = nickName.join(',');
        }else {
          that.updateProperties({'flowable:assignee': selection.userId})
          that.checkValues = selection.nickName;
        }
      }
    },
    // 角色选中数据
    handleRoleSelect(selection,name) {
      const that = this;
      if (selection && name) {
        that.deleteFlowAttar();
        this.updateProperties({'flowable:dataType': 'fixed'})
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
