package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 流程监听对象 sys_listener
 * 
 * @author Tony
 * @date 2022-12-25
 */
public class SysListener extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 表单主键 */
    private Long id;

    /** 名称 */
    @Excel(name = "名称")
    private String name;

    /** 监听类型 */
    @Excel(name = "监听类型")
    private String type;

    /** 事件类型 */
    @Excel(name = "事件类型")
    private String eventType;

    /** 值类型 */
    @Excel(name = "值类型")
    private String valueType;

    /** 执行内容 */
    @Excel(name = "执行内容")
    private String value;

    /** 状态 */
    @Excel(name = "状态")
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
    public void setType(String type) 
    {
        this.type = type;
    }

    public String getType() 
    {
        return type;
    }
    public void setEventType(String eventType) 
    {
        this.eventType = eventType;
    }

    public String getEventType() 
    {
        return eventType;
    }
    public void setValueType(String valueType)
    {
        this.valueType = valueType;
    }

    public String getValueType()
    {
        return valueType;
    }
    public void setValue(String value) 
    {
        this.value = value;
    }

    public String getValue() 
    {
        return value;
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
            .append("type", getType())
            .append("eventType", getEventType())
            .append("valueType", getValueType())
            .append("value", getValue())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .append("createBy", getCreateBy())
            .append("updateBy", getUpdateBy())
            .append("status", getStatus())
            .append("remark", getRemark())
            .toString();
    }
}
