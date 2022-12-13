package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.SysExpressionMapper;
import com.ruoyi.system.domain.SysExpression;
import com.ruoyi.system.service.ISysExpressionService;

/**
 * 流程达式Service业务层处理
 * 
 * @author ruoyi
 * @date 2022-12-12
 */
@Service
public class SysExpressionServiceImpl implements ISysExpressionService 
{
    @Autowired
    private SysExpressionMapper sysExpressionMapper;

    /**
     * 查询流程达式
     * 
     * @param id 流程达式主键
     * @return 流程达式
     */
    @Override
    public SysExpression selectSysExpressionById(Long id)
    {
        return sysExpressionMapper.selectSysExpressionById(id);
    }

    /**
     * 查询流程达式列表
     * 
     * @param sysExpression 流程达式
     * @return 流程达式
     */
    @Override
    public List<SysExpression> selectSysExpressionList(SysExpression sysExpression)
    {
        return sysExpressionMapper.selectSysExpressionList(sysExpression);
    }

    /**
     * 新增流程达式
     * 
     * @param sysExpression 流程达式
     * @return 结果
     */
    @Override
    public int insertSysExpression(SysExpression sysExpression)
    {
        sysExpression.setCreateTime(DateUtils.getNowDate());
        return sysExpressionMapper.insertSysExpression(sysExpression);
    }

    /**
     * 修改流程达式
     * 
     * @param sysExpression 流程达式
     * @return 结果
     */
    @Override
    public int updateSysExpression(SysExpression sysExpression)
    {
        sysExpression.setUpdateTime(DateUtils.getNowDate());
        return sysExpressionMapper.updateSysExpression(sysExpression);
    }

    /**
     * 批量删除流程达式
     * 
     * @param ids 需要删除的流程达式主键
     * @return 结果
     */
    @Override
    public int deleteSysExpressionByIds(Long[] ids)
    {
        return sysExpressionMapper.deleteSysExpressionByIds(ids);
    }

    /**
     * 删除流程达式信息
     * 
     * @param id 流程达式主键
     * @return 结果
     */
    @Override
    public int deleteSysExpressionById(Long id)
    {
        return sysExpressionMapper.deleteSysExpressionById(id);
    }
}
