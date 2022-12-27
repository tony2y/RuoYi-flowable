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
public class FlowQueryVo {

    @ApiModelProperty("流程名称")
    private String name;

    @ApiModelProperty("开始时间")
    private String startTime;

    @ApiModelProperty("结束时间")
    private String endTime;

    @ApiModelProperty("当前页码")
    private Integer pageNum;

    @ApiModelProperty("每页条数")
    private Integer pageSize;


}
