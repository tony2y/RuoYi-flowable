package com.ruoyi.flowable.service.impl;

import java.util.List;
import java.util.Objects;

import com.ruoyi.system.domain.SysForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SysDeployFormMapper;
import com.ruoyi.system.domain.SysDeployForm;
import com.ruoyi.flowable.service.ISysDeployFormService;

/**
 * 流程实例关联表单Service业务层处理
 * 
 * @author XuanXuan Xuan
 * @date 2021-04-03
 */
@Service
public class SysDeployFormServiceImpl implements ISysDeployFormService 
{
    @Autowired
    private SysDeployFormMapper sysDeployFormMapper;

    /**
     * 查询流程实例关联表单
     * 
     * @param id 流程实例关联表单ID
     * @return 流程实例关联表单
     */
    @Override
    public SysDeployForm selectSysDeployFormById(Long id)
    {
        return sysDeployFormMapper.selectSysDeployFormById(id);
    }

    /**
     * 查询流程实例关联表单列表
     * 
     * @param sysDeployForm 流程实例关联表单
     * @return 流程实例关联表单
     */
    @Override
    public List<SysDeployForm> selectSysDeployFormList(SysDeployForm sysDeployForm)
    {
        return sysDeployFormMapper.selectSysDeployFormList(sysDeployForm);
    }

    /**
     * 新增流程实例关联表单
     * 
     * @param sysDeployForm 流程实例关联表单
     * @return 结果
     */
    @Override
    public int insertSysDeployForm(SysDeployForm sysDeployForm)
    {
        SysForm sysForm = sysDeployFormMapper.selectSysDeployFormByDeployId(sysDeployForm.getDeployId());
        if (Objects.isNull(sysForm)) {
            return sysDeployFormMapper.insertSysDeployForm(sysDeployForm);
        }else {
            return 1;
        }
    }

    /**
     * 修改流程实例关联表单
     * 
     * @param sysDeployForm 流程实例关联表单
     * @return 结果
     */
    @Override
    public int updateSysDeployForm(SysDeployForm sysDeployForm)
    {
        return sysDeployFormMapper.updateSysDeployForm(sysDeployForm);
    }

    /**
     * 批量删除流程实例关联表单
     * 
     * @param ids 需要删除的流程实例关联表单ID
     * @return 结果
     */
    @Override
    public int deleteSysDeployFormByIds(Long[] ids)
    {
        return sysDeployFormMapper.deleteSysDeployFormByIds(ids);
    }

    /**
     * 删除流程实例关联表单信息
     * 
     * @param id 流程实例关联表单ID
     * @return 结果
     */
    @Override
    public int deleteSysDeployFormById(Long id)
    {
        return sysDeployFormMapper.deleteSysDeployFormById(id);
    }

    /**
     * 查询流程挂着的表单
     *
     * @param deployId
     * @return
     */
    @Override
    public SysForm selectSysDeployFormByDeployId(String deployId) {
        return sysDeployFormMapper.selectSysDeployFormByDeployId(deployId);
    }
}
