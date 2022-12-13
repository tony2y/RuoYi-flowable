package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 流程达式对象 sys_expression
 * 
 * @author ruoyi
 * @date 2022-12-12
 */
public class SysExpression extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 表单主键 */
    private Long id;

    /** 表达式名称 */
    @Excel(name = "表达式名称")
    private String name;

    /** 表达式内容 */
    @Excel(name = "表达式内容")
    private String expression;

    /** 状态 */
    private Integer status;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }
    public void setExpression(String expression) 
    {
        this.expression = expression;
    }

    public String getExpression() 
    {
        return expression;
    }
    public void setStatus(Integer status) 
    {
        this.status = status;
    }

    public Integer getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("name", getName())
            .append("expression", getExpression())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("createBy", getCreateBy())
            .append("updateBy", getUpdateBy())
            .append("status", getStatus())
            .append("remark", getRemark())
            .toString();
    }
}
