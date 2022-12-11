package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.SysTaskForm;

import java.util.List;

/**
 * 流程任务关联单Mapper接口
 * 
 * @author XuanXuan Xuan
 * @date 2021-04-03
 */
public interface SysTaskFormMapper 
{
    /**
     * 查询流程任务关联单
     * 
     * @param id 流程任务关联单ID
     * @return 流程任务关联单
     */
    public SysTaskForm selectSysTaskFormById(Long id);

    /**
     * 查询流程任务关联单列表
     * 
     * @param sysTaskForm 流程任务关联单
     * @return 流程任务关联单集合
     */
    public List<SysTaskForm> selectSysTaskFormList(SysTaskForm sysTaskForm);

    /**
     * 新增流程任务关联单
     * 
     * @param sysTaskForm 流程任务关联单
     * @return 结果
     */
    public int insertSysTaskForm(SysTaskForm sysTaskForm);

    /**
     * 修改流程任务关联单
     * 
     * @param sysTaskForm 流程任务关联单
     * @return 结果
     */
    public int updateSysTaskForm(SysTaskForm sysTaskForm);

    /**
     * 删除流程任务关联单
     * 
     * @param id 流程任务关联单ID
     * @return 结果
     */
    public int deleteSysTaskFormById(Long id);

    /**
     * 批量删除流程任务关联单
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public int deleteSysTaskFormByIds(Long[] ids);
}
