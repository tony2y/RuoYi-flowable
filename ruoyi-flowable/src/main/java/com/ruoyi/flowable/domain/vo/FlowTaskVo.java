package com.ruoyi.flowable.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * <p>流程任务<p>
 *
 * @author Tony
 * @date 2021-04-03
 */
@Data
@ApiModel("工作流任务相关--请求参数")
public class FlowTaskVo {

    @ApiModelProperty("任务Id")
    private String taskId;

    @ApiModelProperty("用户Id")
    private String userId;

    @ApiModelProperty("任务意见")
    private String comment;

    @ApiModelProperty("流程实例Id")
    private String instanceId;

    @ApiModelProperty("节点")
    private String targetKey;

    private String deploymentId;
    @ApiModelProperty("流程环节定义ID")
    private String defId;

    @ApiModelProperty("子执行流ID")
    private String currentChildExecutionId;

    @ApiModelProperty("子执行流是否已执行")
    private Boolean flag;

    @ApiModelProperty("流程变量信息")
    private Map<String, Object> variables;

    @ApiModelProperty("审批人")
    private String assignee;

    @ApiModelProperty("候选人")
    private List<String> candidateUsers;

    @ApiModelProperty("审批组")
    private List<String> candidateGroups;
}
