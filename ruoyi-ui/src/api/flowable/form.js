import request from '@/utils/request'

// 查询流程表单列表
export function listForm(query) {
  return request({
    url: '/flowable/form/list',
    method: 'get',
    params: query
  })
}
export function listAllForm(query) {
  return request({
    url: '/flowable/form/formList',
    method: 'get',
    params: query
  })
}

// 查询流程表单详细
export function getForm(formId) {
  return request({
    url: '/flowable/form/' + formId,
    method: 'get'
  })
}

// 新增流程表单
export function addForm(data) {
  return request({
    url: '/flowable/form',
    method: 'post',
    data: data
  })
}

// 修改流程表单
export function updateForm(data) {
  return request({
    url: '/flowable/form',
    method: 'put',
    data: data
  })
}
// 挂载表单
export function addDeployForm(data) {
  return request({
    url: '/flowable/form/addDeployForm',
    method: 'post',
    data: data
  })
}

// 删除流程表单
export function delForm(formId) {
  return request({
    url: '/flowable/form/' + formId,
    method: 'delete'
  })
}

// 导出流程表单
export function exportForm(query) {
  return request({
    url: '/flowable/form/export',
    method: 'get',
    params: query
  })
}
