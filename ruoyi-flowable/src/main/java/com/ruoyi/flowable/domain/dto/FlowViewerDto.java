package com.ruoyi.flowable.domain.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * @author Xuan xuan
 * @date 2021/4/21 20:55
 */
@Data
public class FlowViewerDto implements Serializable {

    /**
     * 流程key
     */
    private String key;

    /**
     * 是否完成(已经审批)
     */
    private boolean completed;
}
