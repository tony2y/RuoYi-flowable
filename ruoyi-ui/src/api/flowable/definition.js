import request from '@/utils/request'

// 查询流程定义列表
export function listDefinition(query) {
  return request({
    url: '/flowable/definition/list',
    method: 'get',
    params: query
  })
}

// 部署流程实例
export function definitionStart(procDefId, data) {
  return request({
    url: '/flowable/definition/start/' + procDefId,
    method: 'post',
    data: data
  })
}

// 获取流程变量
export function getProcessVariables(taskId) {
  return request({
    url: '/flowable/task/processVariables/' + taskId,
    method: 'get'
  })
}

// 激活/挂起流程
export function updateState(params) {
  return request({
    url: '/flowable/definition/updateState',
    method: 'put',
    params: params
  })
}

// 指定流程办理人员列表
export function userList(query) {
  return request({
    url: '/flowable/definition/userList',
    method: 'get',
    params: query
  })
}

// 指定流程办理组列表
export function roleList(query) {
  return request({
    url: '/flowable/definition/roleList',
    method: 'get',
    params: query
  })
}

// 指定流程表达式
export function expList(query) {
  return request({
    url: '/flowable/definition/expList',
    method: 'get',
    params: query
  })
}

// 读取xml文件
export function readXml(deployId) {
  return request({
    url: '/flowable/definition/readXml/' + deployId,
    method: 'get'
  })
}

// 读取image文件
export function readImage(deployId) {
  return request({
    url: '/flowable/definition/readImage/' + deployId,
    method: 'get'
  })
}

// 获取流程执行节点
export function getFlowViewer(procInsId, executionId) {
  return request({
    url: '/flowable/task/flowViewer/' + procInsId + '/' + executionId,
    method: 'get'
  })
}

// 流程节点数据
export function flowXmlAndNode(query) {
  return request({
    url: '/flowable/task/flowXmlAndNode',
    method: 'get',
    params: query
  })
}

// 读取xml文件
export function saveXml(data) {
  return request({
    url: '/flowable/definition/save',
    method: 'post',
    data: data
  })
}

// 新增流程定义
export function addDeployment(data) {
  return request({
    url: '/system/deployment',
    method: 'post',
    data: data
  })
}

// 修改流程定义
export function updateDeployment(data) {
  return request({
    url: '/system/deployment',
    method: 'put',
    data: data
  })
}

// 删除流程定义
export function delDeployment(deployId) {
  return request({
    url: '/flowable/definition/' + deployId,
    method: 'delete',
  })
}

// 导出流程定义
export function exportDeployment(query) {
  return request({
    url: '/system/deployment/export',
    method: 'get',
    params: query
  })
}
