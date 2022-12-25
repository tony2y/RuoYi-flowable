package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.SysListener;

/**
 * 流程监听Service接口
 * 
 * @author Tony
 * @date 2022-12-25
 */
public interface ISysListenerService 
{
    /**
     * 查询流程监听
     * 
     * @param id 流程监听主键
     * @return 流程监听
     */
    public SysListener selectSysListenerById(Long id);

    /**
     * 查询流程监听列表
     * 
     * @param sysListener 流程监听
     * @return 流程监听集合
     */
    public List<SysListener> selectSysListenerList(SysListener sysListener);

    /**
     * 新增流程监听
     * 
     * @param sysListener 流程监听
     * @return 结果
     */
    public int insertSysListener(SysListener sysListener);

    /**
     * 修改流程监听
     * 
     * @param sysListener 流程监听
     * @return 结果
     */
    public int updateSysListener(SysListener sysListener);

    /**
     * 批量删除流程监听
     * 
     * @param ids 需要删除的流程监听主键集合
     * @return 结果
     */
    public int deleteSysListenerByIds(Long[] ids);

    /**
     * 删除流程监听信息
     * 
     * @param id 流程监听主键
     * @return 结果
     */
    public int deleteSysListenerById(Long id);
}
