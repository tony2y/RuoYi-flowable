package com.ruoyi.flowable.listener;

import lombok.extern.slf4j.Slf4j;
import org.flowable.common.engine.api.delegate.Expression;
import org.flowable.engine.delegate.DelegateExecution;
import org.flowable.engine.delegate.ExecutionListener;
import org.springframework.stereotype.Component;

/**
 * 执行监听器
 *
 * 执行监听器允许在执行过程中执行Java代码。
 * 执行监听器可以捕获事件的类型：
 * 流程实例启动，结束
 * 输出流捕获
 * 获取启动，结束
 * 路由开始，结束
 * 中间事件开始，结束
 * 触发开始事件，触发结束事件
 *
 * @author Tony
 * @date 2022/12/16
 */
@Slf4j
@Component
public class FlowExecutionListener implements ExecutionListener {
    /**
     * 流程设计器添加的参数
     */
    private Expression param;

    @Override
    public void notify(DelegateExecution execution) {
        log.info("执行监听器:{}", execution);
    }
}
