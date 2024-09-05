import request from '@/utils/request'

// 查询流程监听列表
export function listListener(query) {
  return request({
    url: '/system/listener/list',
    method: 'get',
    params: query
  })
}

// 查询流程监听详细
export function getListener(id) {
  return request({
    url: '/system/listener/' + id,
    method: 'get'
  })
}

// 新增流程监听
export function addListener(data) {
  return request({
    url: '/system/listener',
    method: 'post',
    data: data
  })
}

// 修改流程监听
export function updateListener(data) {
  return request({
    url: '/system/listener',
    method: 'put',
    data: data
  })
}

// 删除流程监听
export function delListener(id) {
  return request({
    url: '/system/listener/' + id,
    method: 'delete'
  })
}
