package com.ruoyi.flowable.service.impl;


import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.alibaba.fastjson2.TypeReference;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.flowable.common.constant.ProcessConstants;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.flowable.common.enums.FlowComment;
import com.ruoyi.common.exception.CustomException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.flowable.domain.dto.FlowCommentDto;
import com.ruoyi.flowable.domain.dto.FlowNextDto;
import com.ruoyi.flowable.domain.dto.FlowTaskDto;
import com.ruoyi.flowable.domain.dto.FlowViewerDto;
import com.ruoyi.flowable.domain.vo.FlowQueryVo;
import com.ruoyi.flowable.domain.vo.FlowTaskVo;
import com.ruoyi.flowable.factory.FlowServiceFactory;
import com.ruoyi.flowable.flow.CustomProcessDiagramGenerator;
import com.ruoyi.flowable.flow.FindNextNodeUtil;
import com.ruoyi.flowable.flow.FlowableUtils;
import com.ruoyi.flowable.service.IFlowTaskService;
import com.ruoyi.flowable.service.ISysDeployFormService;
import com.ruoyi.flowable.service.ISysFormService;
import com.ruoyi.system.domain.SysForm;
import com.ruoyi.system.service.ISysRoleService;
import com.ruoyi.system.service.ISysUserService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.flowable.bpmn.model.Process;
import org.flowable.bpmn.model.*;
import org.flowable.common.engine.api.FlowableException;
import org.flowable.common.engine.api.FlowableObjectNotFoundException;
import org.flowable.common.engine.impl.identity.Authentication;
import org.flowable.engine.ProcessEngineConfiguration;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.history.HistoricProcessInstanceQuery;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ActivityInstance;
import org.flowable.engine.runtime.Execution;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.engine.task.Comment;
import org.flowable.identitylink.api.history.HistoricIdentityLink;
import org.flowable.image.ProcessDiagramGenerator;
import org.flowable.task.api.DelegationState;
import org.flowable.task.api.Task;
import org.flowable.task.api.TaskQuery;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.api.history.HistoricTaskInstanceQuery;
import org.flowable.engine.impl.cmd.AddMultiInstanceExecutionCmd;
import org.flowable.engine.impl.cmd.DeleteMultiInstanceExecutionCmd;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

/**
 * @author Tony
 * @date 2021-04-03
 **/
@Service
@Slf4j
public class FlowTaskServiceImpl extends FlowServiceFactory implements IFlowTaskService {

    @Resource
    private ISysUserService sysUserService;
    @Resource
    private ISysRoleService sysRoleService;
    @Resource
    private ISysDeployFormService sysInstanceFormService;
    @Resource
    private ISysFormService sysFormService;

    /**
     * 完成任务
     *
     * @param taskVo 请求实体参数
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public AjaxResult complete(FlowTaskVo taskVo) {
        Task task = taskService.createTaskQuery().taskId(taskVo.getTaskId()).singleResult();
        if (Objects.isNull(task)) {
            return AjaxResult.error("任务不存在");
        }
        if (DelegationState.PENDING.equals(task.getDelegationState())) {
            taskService.addComment(taskVo.getTaskId(), taskVo.getInstanceId(), FlowComment.DELEGATE.getType(), taskVo.getComment());
            taskService.resolveTask(taskVo.getTaskId(), taskVo.getVariables());
        } else {
            taskService.addComment(taskVo.getTaskId(), taskVo.getInstanceId(), FlowComment.NORMAL.getType(), taskVo.getComment());
            Long userId = SecurityUtils.getLoginUser().getUser().getUserId();
            taskService.setAssignee(taskVo.getTaskId(), userId.toString());
            taskService.complete(taskVo.getTaskId(), taskVo.getVariables());
        }
        return AjaxResult.success();
    }

    /**
     * 驳回任务
     *
     * @param flowTaskVo
     */
    @Override
    public void taskReject(FlowTaskVo flowTaskVo) {
        if (taskService.createTaskQuery().taskId(flowTaskVo.getTaskId()).singleResult().isSuspended()) {
            throw new CustomException("任务处于挂起状态!");
        }
        // 当前任务 task
        Task task = taskService.createTaskQuery().taskId(flowTaskVo.getTaskId()).singleResult();
        // 获取流程定义信息
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(task.getProcessDefinitionId()).singleResult();
        // 获取所有节点信息
        Process process = repositoryService.getBpmnModel(processDefinition.getId()).getProcesses().get(0);
        // 获取全部节点列表，包含子节点
        Collection<FlowElement> allElements = FlowableUtils.getAllElements(process.getFlowElements(), null);
        // 获取当前任务节点元素
        FlowElement source = null;
        if (allElements != null) {
            for (FlowElement flowElement : allElements) {
                // 类型为用户节点
                if (flowElement.getId().equals(task.getTaskDefinitionKey())) {
                    // 获取节点信息
                    source = flowElement;
                }
            }
        }

        // 目的获取所有跳转到的节点 targetIds
        // 获取当前节点的所有父级用户任务节点
        // 深度优先算法思想：延边迭代深入
        List<UserTask> parentUserTaskList = FlowableUtils.iteratorFindParentUserTasks(source, null, null);
        if (parentUserTaskList == null || parentUserTaskList.size() == 0) {
            throw new CustomException("当前节点为初始任务节点，不能驳回");
        }
        // 获取活动 ID 即节点 Key
        List<String> parentUserTaskKeyList = new ArrayList<>();
        parentUserTaskList.forEach(item -> parentUserTaskKeyList.add(item.getId()));
        // 获取全部历史节点活动实例，即已经走过的节点历史，数据采用开始时间升序
        List<HistoricTaskInstance> historicTaskInstanceList = historyService.createHistoricTaskInstanceQuery().processInstanceId(task.getProcessInstanceId()).orderByHistoricTaskInstanceStartTime().asc().list();
        // 数据清洗，将回滚导致的脏数据清洗掉
        List<String> lastHistoricTaskInstanceList = FlowableUtils.historicTaskInstanceClean(allElements, historicTaskInstanceList);
        // 此时历史任务实例为倒序，获取最后走的节点
        List<String> targetIds = new ArrayList<>();
        // 循环结束标识，遇到当前目标节点的次数
        int number = 0;
        StringBuilder parentHistoricTaskKey = new StringBuilder();
        for (String historicTaskInstanceKey : lastHistoricTaskInstanceList) {
            // 当会签时候会出现特殊的，连续都是同一个节点历史数据的情况，这种时候跳过
            if (parentHistoricTaskKey.toString().equals(historicTaskInstanceKey)) {
                continue;
            }
            parentHistoricTaskKey = new StringBuilder(historicTaskInstanceKey);
            if (historicTaskInstanceKey.equals(task.getTaskDefinitionKey())) {
                number++;
            }
            // 在数据清洗后，历史节点就是唯一一条从起始到当前节点的历史记录，理论上每个点只会出现一次
            // 在流程中如果出现循环，那么每次循环中间的点也只会出现一次，再出现就是下次循环
            // number == 1，第一次遇到当前节点
            // number == 2，第二次遇到，代表最后一次的循环范围
            if (number == 2) {
                break;
            }
            // 如果当前历史节点，属于父级的节点，说明最后一次经过了这个点，需要退回这个点
            if (parentUserTaskKeyList.contains(historicTaskInstanceKey)) {
                targetIds.add(historicTaskInstanceKey);
            }
        }


        // 目的获取所有需要被跳转的节点 currentIds
        // 取其中一个父级任务，因为后续要么存在公共网关，要么就是串行公共线路
        UserTask oneUserTask = parentUserTaskList.get(0);
        // 获取所有正常进行的任务节点 Key，这些任务不能直接使用，需要找出其中需要撤回的任务
        List<Task> runTaskList = taskService.createTaskQuery().processInstanceId(task.getProcessInstanceId()).list();
        List<String> runTaskKeyList = new ArrayList<>();
        runTaskList.forEach(item -> runTaskKeyList.add(item.getTaskDefinitionKey()));
        // 需驳回任务列表
        List<String> currentIds = new ArrayList<>();
        // 通过父级网关的出口连线，结合 runTaskList 比对，获取需要撤回的任务
        List<UserTask> currentUserTaskList = FlowableUtils.iteratorFindChildUserTasks(oneUserTask, runTaskKeyList, null, null);
        currentUserTaskList.forEach(item -> currentIds.add(item.getId()));


        // 规定：并行网关之前节点必须需存在唯一用户任务节点，如果出现多个任务节点，则并行网关节点默认为结束节点，原因为不考虑多对多情况
        if (targetIds.size() > 1 && currentIds.size() > 1) {
            throw new CustomException("任务出现多对多情况，无法撤回");
        }

        // 循环获取那些需要被撤回的节点的ID，用来设置驳回原因
        List<String> currentTaskIds = new ArrayList<>();
        currentIds.forEach(currentId -> runTaskList.forEach(runTask -> {
            if (currentId.equals(runTask.getTaskDefinitionKey())) {
                currentTaskIds.add(runTask.getId());
            }
        }));
        // 设置驳回意见
        currentTaskIds.forEach(item -> taskService.addComment(item, task.getProcessInstanceId(), FlowComment.REJECT.getType(), flowTaskVo.getComment()));

        try {
            // 如果父级任务多于 1 个，说明当前节点不是并行节点，原因为不考虑多对多情况
            if (targetIds.size() > 1) {
                // 1 对 多任务跳转，currentIds 当前节点(1)，targetIds 跳转到的节点(多)
                runtimeService.createChangeActivityStateBuilder()
                        .processInstanceId(task.getProcessInstanceId()).
                        moveSingleActivityIdToActivityIds(currentIds.get(0), targetIds).changeState();
            }
            // 如果父级任务只有一个，因此当前任务可能为网关中的任务
            if (targetIds.size() == 1) {
                // 1 对 1 或 多 对 1 情况，currentIds 当前要跳转的节点列表(1或多)，targetIds.get(0) 跳转到的节点(1)
                runtimeService.createChangeActivityStateBuilder()
                        .processInstanceId(task.getProcessInstanceId())
                        .moveActivityIdsToSingleActivityId(currentIds, targetIds.get(0)).changeState();
            }
        } catch (FlowableObjectNotFoundException e) {
            throw new CustomException("未找到流程实例，流程可能已发生变化");
        } catch (FlowableException e) {
            throw new CustomException("无法取消或开始活动");
        }

    }

    /**
     * 退回任务
     *
     * @param flowTaskVo 请求实体参数
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void taskReturn(FlowTaskVo flowTaskVo) {
        if (taskService.createTaskQuery().taskId(flowTaskVo.getTaskId()).singleResult().isSuspended()) {
            throw new CustomException("任务处于挂起状态");
        }
        // 当前任务 task
        Task task = taskService.createTaskQuery().taskId(flowTaskVo.getTaskId()).singleResult();
        // 获取流程定义信息
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(task.getProcessDefinitionId()).singleResult();
        // 获取所有节点信息
        Process process = repositoryService.getBpmnModel(processDefinition.getId()).getProcesses().get(0);
        // 获取全部节点列表，包含子节点
        Collection<FlowElement> allElements = FlowableUtils.getAllElements(process.getFlowElements(), null);
        // 获取当前任务节点元素
        FlowElement source = null;
        // 获取跳转的节点元素
        FlowElement target = null;
        if (allElements != null) {
            for (FlowElement flowElement : allElements) {
                // 当前任务节点元素
                if (flowElement.getId().equals(task.getTaskDefinitionKey())) {
                    source = flowElement;
                }
                // 跳转的节点元素
                if (flowElement.getId().equals(flowTaskVo.getTargetKey())) {
                    target = flowElement;
                }
            }
        }

        // 从当前节点向前扫描
        // 如果存在路线上不存在目标节点，说明目标节点是在网关上或非同一路线上，不可跳转
        // 否则目标节点相对于当前节点，属于串行
        Boolean isSequential = FlowableUtils.iteratorCheckSequentialReferTarget(source, flowTaskVo.getTargetKey(), null, null);
        if (!isSequential) {
            throw new CustomException("当前节点相对于目标节点，不属于串行关系，无法回退");
        }


        // 获取所有正常进行的任务节点 Key，这些任务不能直接使用，需要找出其中需要撤回的任务
        List<Task> runTaskList = taskService.createTaskQuery().processInstanceId(task.getProcessInstanceId()).list();
        List<String> runTaskKeyList = new ArrayList<>();
        runTaskList.forEach(item -> runTaskKeyList.add(item.getTaskDefinitionKey()));
        // 需退回任务列表
        List<String> currentIds = new ArrayList<>();
        // 通过父级网关的出口连线，结合 runTaskList 比对，获取需要撤回的任务
        List<UserTask> currentUserTaskList = FlowableUtils.iteratorFindChildUserTasks(target, runTaskKeyList, null, null);
        currentUserTaskList.forEach(item -> currentIds.add(item.getId()));

        // 循环获取那些需要被撤回的节点的ID，用来设置驳回原因
        List<String> currentTaskIds = new ArrayList<>();
        currentIds.forEach(currentId -> runTaskList.forEach(runTask -> {
            if (currentId.equals(runTask.getTaskDefinitionKey())) {
                currentTaskIds.add(runTask.getId());
            }
        }));
        // 设置回退意见
        currentTaskIds.forEach(currentTaskId -> taskService.addComment(currentTaskId, task.getProcessInstanceId(), FlowComment.REBACK.getType(), flowTaskVo.getComment()));

        try {
            // 1 对 1 或 多 对 1 情况，currentIds 当前要跳转的节点列表(1或多)，targetKey 跳转到的节点(1)
            runtimeService.createChangeActivityStateBuilder()
                    .processInstanceId(task.getProcessInstanceId())
                    .moveActivityIdsToSingleActivityId(currentIds, flowTaskVo.getTargetKey()).changeState();
        } catch (FlowableObjectNotFoundException e) {
            throw new CustomException("未找到流程实例，流程可能已发生变化");
        } catch (FlowableException e) {
            throw new CustomException("无法取消或开始活动");
        }
    }


    /**
     * 获取所有可回退的节点
     *
     * @param flowTaskVo
     * @return
     */
    @Override
    public AjaxResult findReturnTaskList(FlowTaskVo flowTaskVo) {
//        // 当前任务 task
//        Task task = taskService.createTaskQuery().taskId(flowTaskVo.getTaskId()).singleResult();
//        // 从流程历史任务中获取可退回节点
////        List<HistoricActivityInstance> hisActIns = historyService.createHistoricActivityInstanceQuery()
////                .executionId(task.getExecutionId())
////                .activityType("userTask")
////                .orderByHistoricActivityInstanceStartTime()
////                .finished()
////                .desc()
////                .list();
////
////        // 可回退的节点列表
////        List<ReturnTaskNodeVo> returnTaskNodeList = new ArrayList<>();
////        ReturnTaskNodeVo returnTaskNodeVo;
////        for (HistoricActivityInstance activityInstance : hisActIns) {
////            returnTaskNodeVo = new ReturnTaskNodeVo();
////            returnTaskNodeVo.setId(activityInstance.getActivityId());
////            // 根据流程节点处理时间校验改节点是否已完成
////            returnTaskNodeVo.setName(activityInstance.getActivityName());
////            returnTaskNodeList.add(returnTaskNodeVo);
////        }
//        List<UserTask> userTaskList = new ArrayList<>();
//        // 获取流程定义信息
//        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(task.getProcessDefinitionId()).singleResult();
//        // 获取所有节点信息，暂不考虑子流程情况
//        Process process = repositoryService.getBpmnModel(processDefinition.getId()).getProcesses().get(0);
//        Collection<FlowElement> flowElements = process.getFlowElements();
//        // 获取当前任务节点元素
//        UserTask source = null;
//        if (flowElements != null) {
//            for (FlowElement flowElement : flowElements) {
//                // 类型为用户节点
//                if (flowElement.getId().equals(task.getTaskDefinitionKey())) {
//                    source = (UserTask) flowElement;
//                }
//            }
//        }
//        // 获取节点的所有路线
//        List<List<UserTask>> roads = FlowableUtils.findRoad(source, null, null, null);
//
//        for (List<UserTask> road : roads) {
//            if (userTaskList.size() == 0) {
//                // 还没有可回退节点直接添加
//                userTaskList = road;
//            } else {
//                // 如果已有回退节点，则比对取交集部分
//                userTaskList.retainAll(road);
//            }
//        }
//        return AjaxResult.success(userTaskList);
        // 当前任务 task
        Task task = taskService.createTaskQuery().taskId(flowTaskVo.getTaskId()).singleResult();
        // 获取流程定义信息
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(task.getProcessDefinitionId()).singleResult();
        // 获取所有节点信息，暂不考虑子流程情况
        Process process = repositoryService.getBpmnModel(processDefinition.getId()).getProcesses().get(0);
        Collection<FlowElement> flowElements = process.getFlowElements();
        // 获取当前任务节点元素
        UserTask source = null;
        if (flowElements != null) {
            for (FlowElement flowElement : flowElements) {
                // 类型为用户节点
                if (flowElement.getId().equals(task.getTaskDefinitionKey())) {
                    source = (UserTask) flowElement;
                }
            }
        }
        // 获取节点的所有路线
        List<List<UserTask>> roads = FlowableUtils.findRoad(source, null, null, null);
        // 可回退的节点列表
        List<UserTask> userTaskList = new ArrayList<>();
        for (List<UserTask> road : roads) {
            if (userTaskList.size() == 0) {
                // 还没有可回退节点直接添加
                userTaskList = road;
            } else {
                // 如果已有回退节点，则比对取交集部分
                userTaskList.retainAll(road);
            }
        }
        return AjaxResult.success(userTaskList);
    }

    /**
     * 删除任务
     *
     * @param flowTaskVo 请求实体参数
     */
    @Override
    public void deleteTask(FlowTaskVo flowTaskVo) {
        // todo 待确认删除任务是物理删除任务 还是逻辑删除，让这个任务直接通过？
        taskService.deleteTask(flowTaskVo.getTaskId(), flowTaskVo.getComment());
    }

    /**
     * 认领/签收任务
     * 认领以后,这个用户就会成为任务的执行人,任务会从其他成员的任务列表中消失
     *
     * @param flowTaskVo 请求实体参数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void claim(FlowTaskVo flowTaskVo) {
        taskService.claim(flowTaskVo.getTaskId(), flowTaskVo.getUserId());
    }

    /**
     * 取消认领/签收任务
     *
     * @param flowTaskVo 请求实体参数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void unClaim(FlowTaskVo flowTaskVo) {
        taskService.unclaim(flowTaskVo.getTaskId());
    }

    /**
     * 委派任务
     * 任务委派只是委派人将当前的任务交给被委派人进行审批，处理任务后又重新回到委派人身上。
     *
     * @param flowTaskVo 请求实体参数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delegateTask(FlowTaskVo flowTaskVo) {
        taskService.delegateTask(flowTaskVo.getTaskId(), flowTaskVo.getAssignee());
    }

    /**
     * 任务归还
     * 被委派人完成任务之后，将任务归还委派人
     *
     * @param flowTaskVo 请求实体参数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void resolveTask(FlowTaskVo flowTaskVo) {
        taskService.resolveTask(flowTaskVo.getTaskId());
    }


    /**
     * 转办任务
     * 直接将办理人换成别人，这时任务的拥有者不再是转办人
     *
     * @param flowTaskVo 请求实体参数
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void assignTask(FlowTaskVo flowTaskVo) {
        // 直接转派就可以覆盖掉之前的
        taskService.setAssignee(flowTaskVo.getTaskId(), flowTaskVo.getAssignee());
//        // 删除指派人重新指派
//        taskService.deleteCandidateUser(flowTaskVo.getTaskId(),flowTaskVo.getAssignee());
//        taskService.addCandidateUser(flowTaskVo.getTaskId(),flowTaskVo.getAssignee());
//        // 如果要查询转给他人处理的任务，可以同时将OWNER进行设置：
//        taskService.setOwner(flowTaskVo.getTaskId(), flowTaskVo.getAssignee());

    }

    /**
     * 多实例加签
     * act_ru_task、act_ru_identitylink各生成一条记录
     *
     * @param flowTaskVo
     */
    @Override
    public void addMultiInstanceExecution(FlowTaskVo flowTaskVo) {
        managementService.executeCommand(new AddMultiInstanceExecutionCmd(flowTaskVo.getDefId(), flowTaskVo.getInstanceId(), flowTaskVo.getVariables()));
    }

    /**
     * 多实例减签
     * act_ru_task减1、act_ru_identitylink不变
     *
     * @param flowTaskVo
     */
    @Override
    public void deleteMultiInstanceExecution(FlowTaskVo flowTaskVo) {
        managementService.executeCommand(new DeleteMultiInstanceExecutionCmd(flowTaskVo.getCurrentChildExecutionId(), flowTaskVo.getFlag()));
    }

    /**
     * 我发起的流程
     *
     * @param queryVo 请求参数
     * @return
     */
    @Override
    public AjaxResult myProcess(FlowQueryVo queryVo) {
        Page<FlowTaskDto> page = new Page<>();
        Long userId = SecurityUtils.getLoginUser().getUser().getUserId();
        HistoricProcessInstanceQuery historicProcessInstanceQuery = historyService.createHistoricProcessInstanceQuery()
                .startedBy(userId.toString())
                .orderByProcessInstanceStartTime()
                .desc();
        List<HistoricProcessInstance> historicProcessInstances = historicProcessInstanceQuery.listPage(queryVo.getPageSize() * (queryVo.getPageNum() - 1), queryVo.getPageSize());
        page.setTotal(historicProcessInstanceQuery.count());
        List<FlowTaskDto> flowList = new ArrayList<>();
        for (HistoricProcessInstance hisIns : historicProcessInstances) {
            FlowTaskDto flowTask = new FlowTaskDto();
            flowTask.setCreateTime(hisIns.getStartTime());
            flowTask.setFinishTime(hisIns.getEndTime());
            flowTask.setProcInsId(hisIns.getId());

            // 计算耗时
            if (Objects.nonNull(hisIns.getEndTime())) {
                long time = hisIns.getEndTime().getTime() - hisIns.getStartTime().getTime();
                flowTask.setDuration(getDate(time));
            } else {
                long time = System.currentTimeMillis() - hisIns.getStartTime().getTime();
                flowTask.setDuration(getDate(time));
            }
            // 流程定义信息
            ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(hisIns.getProcessDefinitionId())
                    .singleResult();
            flowTask.setDeployId(pd.getDeploymentId());
            flowTask.setProcDefName(pd.getName());
            flowTask.setProcDefVersion(pd.getVersion());
            flowTask.setCategory(pd.getCategory());
            flowTask.setProcDefVersion(pd.getVersion());
            // 当前所处流程
            List<Task> taskList = taskService.createTaskQuery().processInstanceId(hisIns.getId()).list();
            if (CollectionUtils.isNotEmpty(taskList)) {
                flowTask.setTaskId(taskList.get(0).getId());
                flowTask.setTaskName(taskList.get(0).getName());
                if (StringUtils.isNotBlank(taskList.get(0).getAssignee())) {
                    // 当前任务节点办理人信息
                    SysUser sysUser = sysUserService.selectUserById(Long.parseLong(taskList.get(0).getAssignee()));
                    if (Objects.nonNull(sysUser)) {
                        flowTask.setAssigneeId(sysUser.getUserId());
                        flowTask.setAssigneeName(sysUser.getNickName());
                        flowTask.setAssigneeDeptName(Objects.nonNull(sysUser.getDept()) ? sysUser.getDept().getDeptName() : "");
                    }
                }
            } else {
                List<HistoricTaskInstance> historicTaskInstance = historyService.createHistoricTaskInstanceQuery().processInstanceId(hisIns.getId()).orderByHistoricTaskInstanceEndTime().desc().list();
                flowTask.setTaskId(historicTaskInstance.get(0).getId());
                flowTask.setTaskName(historicTaskInstance.get(0).getName());
                if (StringUtils.isNotBlank(historicTaskInstance.get(0).getAssignee())) {
                    // 当前任务节点办理人信息
                    SysUser sysUser = sysUserService.selectUserById(Long.parseLong(historicTaskInstance.get(0).getAssignee()));
                    if (Objects.nonNull(sysUser)) {
                        flowTask.setAssigneeId(sysUser.getUserId());
                        flowTask.setAssigneeName(sysUser.getNickName());
                        flowTask.setAssigneeDeptName(Objects.nonNull(sysUser.getDept()) ? sysUser.getDept().getDeptName() : "");
                    }
                }
            }
            flowList.add(flowTask);
        }
        page.setRecords(flowList);
        return AjaxResult.success(page);
    }

    /**
     * 取消申请
     * 目前实现方式: 直接将当前流程变更为已完成
     *
     * @param flowTaskVo
     * @return
     */
    @Override
    public AjaxResult stopProcess(FlowTaskVo flowTaskVo) {
        List<Task> task = taskService.createTaskQuery().processInstanceId(flowTaskVo.getInstanceId()).list();
        if (CollectionUtils.isEmpty(task)) {
            throw new CustomException("流程未启动或已执行完成，取消申请失败");
        }
        // 获取当前流程实例
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                .processInstanceId(flowTaskVo.getInstanceId())
                .singleResult();
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processInstance.getProcessDefinitionId());
        if (Objects.nonNull(bpmnModel)) {
            Process process = bpmnModel.getMainProcess();
            List<EndEvent> endNodes = process.findFlowElementsOfType(EndEvent.class, false);
            if (CollectionUtils.isNotEmpty(endNodes)) {
                // TODO 取消流程为什么要设置流程发起人?
//                SysUser loginUser = SecurityUtils.getLoginUser().getUser();
//                Authentication.setAuthenticatedUserId(loginUser.getUserId().toString());

//                taskService.addComment(task.getId(), processInstance.getProcessInstanceId(), FlowComment.STOP.getType(),
//                        StringUtils.isBlank(flowTaskVo.getComment()) ? "取消申请" : flowTaskVo.getComment());
                // 获取当前流程最后一个节点
                String endId = endNodes.get(0).getId();
                List<Execution> executions = runtimeService.createExecutionQuery()
                        .parentId(processInstance.getProcessInstanceId()).list();
                List<String> executionIds = new ArrayList<>();
                executions.forEach(execution -> executionIds.add(execution.getId()));
                // 变更流程为已结束状态
                runtimeService.createChangeActivityStateBuilder()
                        .moveExecutionsToSingleActivityId(executionIds, endId).changeState();
            }
        }

        return AjaxResult.success();
    }

    /**
     * 撤回流程  目前存在错误
     *
     * @param flowTaskVo
     * @return
     */
    @Override
    public AjaxResult revokeProcess(FlowTaskVo flowTaskVo) {
        Task task = taskService.createTaskQuery().processInstanceId(flowTaskVo.getInstanceId()).singleResult();
        if (task == null) {
            throw new CustomException("流程未启动或已执行完成，无法撤回");
        }

        SysUser loginUser = SecurityUtils.getLoginUser().getUser();
        List<HistoricTaskInstance> htiList = historyService.createHistoricTaskInstanceQuery()
                .processInstanceId(task.getProcessInstanceId())
                .orderByTaskCreateTime()
                .asc()
                .list();
        String myTaskId = null;
        HistoricTaskInstance myTask = null;
        for (HistoricTaskInstance hti : htiList) {
            if (loginUser.getUserId().toString().equals(hti.getAssignee())) {
                myTaskId = hti.getId();
                myTask = hti;
                break;
            }
        }
        if (null == myTaskId) {
            throw new CustomException("该任务非当前用户提交，无法撤回");
        }

        String processDefinitionId = myTask.getProcessDefinitionId();
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinitionId);

        //变量
//      Map<String, VariableInstance> variables = runtimeService.getVariableInstances(currentTask.getExecutionId());
        String myActivityId = null;
        List<HistoricActivityInstance> haiList = historyService.createHistoricActivityInstanceQuery()
                .executionId(myTask.getExecutionId()).finished().list();
        for (HistoricActivityInstance hai : haiList) {
            if (myTaskId.equals(hai.getTaskId())) {
                myActivityId = hai.getActivityId();
                break;
            }
        }
        FlowNode myFlowNode = (FlowNode) bpmnModel.getMainProcess().getFlowElement(myActivityId);

        Execution execution = runtimeService.createExecutionQuery().executionId(task.getExecutionId()).singleResult();
        String activityId = execution.getActivityId();
        FlowNode flowNode = (FlowNode) bpmnModel.getMainProcess().getFlowElement(activityId);

        //记录原活动方向
        List<SequenceFlow> oriSequenceFlows = new ArrayList<>(flowNode.getOutgoingFlows());


        return AjaxResult.success();
    }

    /**
     * 代办任务列表
     *
     * @param queryVo 请求参数
     * @return
     */
    @Override
    public AjaxResult todoList(FlowQueryVo queryVo) {
        Page<FlowTaskDto> page = new Page<>();
        // 只查看自己的数据
        SysUser sysUser = SecurityUtils.getLoginUser().getUser();
        TaskQuery taskQuery = taskService.createTaskQuery()
                .active()
                .includeProcessVariables()
                .taskCandidateGroupIn(sysUser.getRoles().stream().map(role -> role.getRoleId().toString()).collect(Collectors.toList()))
                .taskCandidateOrAssigned(sysUser.getUserId().toString())
                .orderByTaskCreateTime().desc();

//        TODO 传入名称查询不到数据?
//        if (StringUtils.isNotBlank(queryVo.getName())){
//            taskQuery.processDefinitionNameLike(queryVo.getName());
//        }
        page.setTotal(taskQuery.count());
        List<Task> taskList = taskQuery.listPage(queryVo.getPageSize() * (queryVo.getPageNum() - 1), queryVo.getPageSize());
        List<FlowTaskDto> flowList = new ArrayList<>();
        for (Task task : taskList) {
            FlowTaskDto flowTask = new FlowTaskDto();
            // 当前流程信息
            flowTask.setTaskId(task.getId());
            flowTask.setTaskDefKey(task.getTaskDefinitionKey());
            flowTask.setCreateTime(task.getCreateTime());
            flowTask.setProcDefId(task.getProcessDefinitionId());
            flowTask.setExecutionId(task.getExecutionId());
            flowTask.setTaskName(task.getName());
            // 流程定义信息
            ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(task.getProcessDefinitionId())
                    .singleResult();
            flowTask.setDeployId(pd.getDeploymentId());
            flowTask.setProcDefName(pd.getName());
            flowTask.setProcDefVersion(pd.getVersion());
            flowTask.setProcInsId(task.getProcessInstanceId());

            // 流程发起人信息
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                    .processInstanceId(task.getProcessInstanceId())
                    .singleResult();
            SysUser startUser = sysUserService.selectUserById(Long.parseLong(historicProcessInstance.getStartUserId()));
            flowTask.setStartUserId(startUser.getUserId().toString());
            flowTask.setStartUserName(startUser.getNickName());
            flowTask.setStartDeptName(Objects.nonNull(startUser.getDept()) ? startUser.getDept().getDeptName() : "");
            flowList.add(flowTask);
        }

        page.setRecords(flowList);
        return AjaxResult.success(page);
    }


    /**
     * 已办任务列表
     *
     * @param queryVo 请求参数
     * @return
     */
    @Override
    public AjaxResult finishedList(FlowQueryVo queryVo) {
        Page<FlowTaskDto> page = new Page<>();
        Long userId = SecurityUtils.getLoginUser().getUser().getUserId();
        HistoricTaskInstanceQuery taskInstanceQuery = historyService.createHistoricTaskInstanceQuery()
                .includeProcessVariables()
                .finished()
                .taskAssignee(userId.toString())
                .orderByHistoricTaskInstanceEndTime()
                .desc();
        List<HistoricTaskInstance> historicTaskInstanceList = taskInstanceQuery.listPage(queryVo.getPageSize() * (queryVo.getPageNum() - 1), queryVo.getPageSize());
        List<FlowTaskDto> hisTaskList = new ArrayList<>();
        for (HistoricTaskInstance histTask : historicTaskInstanceList) {
            FlowTaskDto flowTask = new FlowTaskDto();
            // 当前流程信息
            flowTask.setTaskId(histTask.getId());
            // 审批人员信息
            flowTask.setCreateTime(histTask.getCreateTime());
            flowTask.setFinishTime(histTask.getEndTime());
            flowTask.setDuration(getDate(histTask.getDurationInMillis()));
            flowTask.setProcDefId(histTask.getProcessDefinitionId());
            flowTask.setTaskDefKey(histTask.getTaskDefinitionKey());
            flowTask.setTaskName(histTask.getName());

            // 流程定义信息
            ProcessDefinition pd = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(histTask.getProcessDefinitionId())
                    .singleResult();
            flowTask.setDeployId(pd.getDeploymentId());
            flowTask.setProcDefName(pd.getName());
            flowTask.setProcDefVersion(pd.getVersion());
            flowTask.setProcInsId(histTask.getProcessInstanceId());
            flowTask.setHisProcInsId(histTask.getProcessInstanceId());

            // 流程发起人信息
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
                    .processInstanceId(histTask.getProcessInstanceId())
                    .singleResult();
            SysUser startUser = sysUserService.selectUserById(Long.parseLong(historicProcessInstance.getStartUserId()));
            flowTask.setStartUserId(startUser.getNickName());
            flowTask.setStartUserName(startUser.getNickName());
            flowTask.setStartDeptName(startUser.getDept().getDeptName());
            hisTaskList.add(flowTask);
        }
        page.setTotal(taskInstanceQuery.count());
        page.setRecords(hisTaskList);
        return AjaxResult.success(page);
    }

    private static <T> Predicate<T> distinctByKey(Function<? super T, ?> keyExtractor) {
        Set<Object> seen = ConcurrentHashMap.newKeySet();
        return t -> seen.add(keyExtractor.apply(t));
    }

    /**
     * 流程历史流转记录
     *
     * @param procInsId 流程实例Id
     * @return
     */
    @Override
    public AjaxResult flowRecord(String procInsId, String deployId) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotBlank(procInsId)) {
            List<HistoricActivityInstance> list = historyService
                    .createHistoricActivityInstanceQuery()
                    .processInstanceId(procInsId)
                    .orderByHistoricActivityInstanceStartTime()
                    .desc().list();
            List<FlowTaskDto> hisFlowList = new ArrayList<>();
            for (HistoricActivityInstance histIns : list) {
                // 展示开始节点
//                if ("startEvent".equals(histIns.getActivityType())) {
//                    FlowTaskDto flowTask = new FlowTaskDto();
//                    // 流程发起人信息
//                    HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
//                            .processInstanceId(histIns.getProcessInstanceId())
//                            .singleResult();
//                    SysUser startUser = sysUserService.selectUserById(Long.parseLong(historicProcessInstance.getStartUserId()));
//                    flowTask.setTaskName(startUser.getNickName() + "(" + startUser.getDept().getDeptName() + ")发起申请");
//                    flowTask.setFinishTime(histIns.getEndTime());
//                    hisFlowList.add(flowTask);
//                } else if ("endEvent".equals(histIns.getActivityType())) {
//                    FlowTaskDto flowTask = new FlowTaskDto();
//                    flowTask.setTaskName(StringUtils.isNotBlank(histIns.getActivityName()) ? histIns.getActivityName() : "结束");
//                    flowTask.setFinishTime(histIns.getEndTime());
//                    hisFlowList.add(flowTask);
//                } else
                if (StringUtils.isNotBlank(histIns.getTaskId())) {
                    FlowTaskDto flowTask = new FlowTaskDto();
                    flowTask.setTaskId(histIns.getTaskId());
                    flowTask.setTaskName(histIns.getActivityName());
                    flowTask.setCreateTime(histIns.getStartTime());
                    flowTask.setFinishTime(histIns.getEndTime());
                    if (StringUtils.isNotBlank(histIns.getAssignee())) {
                        SysUser sysUser = sysUserService.selectUserById(Long.parseLong(histIns.getAssignee()));
                        flowTask.setAssigneeId(sysUser.getUserId());
                        flowTask.setAssigneeName(sysUser.getNickName());
                        flowTask.setDeptName(Objects.nonNull(sysUser.getDept()) ? sysUser.getDept().getDeptName() : "");
                    }
                    // 展示审批人员
                    List<HistoricIdentityLink> linksForTask = historyService.getHistoricIdentityLinksForTask(histIns.getTaskId());
                    StringBuilder stringBuilder = new StringBuilder();
                    for (HistoricIdentityLink identityLink : linksForTask) {
                        // 获选人,候选组/角色(多个)
                        if ("candidate".equals(identityLink.getType())) {
                            if (StringUtils.isNotBlank(identityLink.getUserId())) {
                                SysUser sysUser = sysUserService.selectUserById(Long.parseLong(identityLink.getUserId()));
                                stringBuilder.append(sysUser.getNickName()).append(",");
                            }
                            if (StringUtils.isNotBlank(identityLink.getGroupId())) {
                                SysRole sysRole = sysRoleService.selectRoleById(Long.parseLong(identityLink.getGroupId()));
                                stringBuilder.append(sysRole.getRoleName()).append(",");
                            }
                        }
                    }
                    if (StringUtils.isNotBlank(stringBuilder)) {
                        flowTask.setCandidate(stringBuilder.substring(0, stringBuilder.length() - 1));
                    }

                    flowTask.setDuration(histIns.getDurationInMillis() == null || histIns.getDurationInMillis() == 0 ? null : getDate(histIns.getDurationInMillis()));
                    // 获取意见评论内容
                    List<Comment> commentList = taskService.getProcessInstanceComments(histIns.getProcessInstanceId());
                    commentList.forEach(comment -> {
                        if (histIns.getTaskId().equals(comment.getTaskId())) {
                            flowTask.setComment(FlowCommentDto.builder().type(comment.getType()).comment(comment.getFullMessage()).build());
                        }
                    });
                    hisFlowList.add(flowTask);
                }
            }
            map.put("flowList", hisFlowList);
        }
        // 第一次申请获取初始化表单
        if (StringUtils.isNotBlank(deployId)) {
            SysForm sysForm = sysInstanceFormService.selectSysDeployFormByDeployId(deployId);
            if (Objects.isNull(sysForm)) {
                return AjaxResult.error("请先配置流程表单");
            }
            map.put("formData", JSONObject.parseObject(sysForm.getFormContent()));
        }
        return AjaxResult.success(map);
    }

    /**
     * 根据任务ID查询挂载的表单信息
     *
     * @param taskId 任务Id
     * @return
     */
    @Override
    public Task getTaskForm(String taskId) {
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        return task;
    }

    /**
     * 获取流程过程图
     *
     * @param processId
     * @return
     */
    @Override
    public InputStream diagram(String processId) {
        String processDefinitionId;
        // 获取当前的流程实例
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processId).singleResult();
        // 如果流程已经结束，则得到结束节点
        if (Objects.isNull(processInstance)) {
            HistoricProcessInstance pi = historyService.createHistoricProcessInstanceQuery().processInstanceId(processId).singleResult();

            processDefinitionId = pi.getProcessDefinitionId();
        } else {// 如果流程没有结束，则取当前活动节点
            // 根据流程实例ID获得当前处于活动状态的ActivityId合集
            ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId(processId).singleResult();
            processDefinitionId = pi.getProcessDefinitionId();
        }

        // 获得活动的节点
        List<HistoricActivityInstance> highLightedFlowList = historyService.createHistoricActivityInstanceQuery().processInstanceId(processId).orderByHistoricActivityInstanceStartTime().asc().list();

        List<String> highLightedFlows = new ArrayList<>();
        List<String> highLightedNodes = new ArrayList<>();
        //高亮线
        for (HistoricActivityInstance tempActivity : highLightedFlowList) {
            if ("sequenceFlow".equals(tempActivity.getActivityType())) {
                //高亮线
                highLightedFlows.add(tempActivity.getActivityId());
            } else {
                //高亮节点
                highLightedNodes.add(tempActivity.getActivityId());
            }
        }

        //获取流程图
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinitionId);
        ProcessEngineConfiguration configuration = processEngine.getProcessEngineConfiguration();
        //获取自定义图片生成器
        ProcessDiagramGenerator diagramGenerator = new CustomProcessDiagramGenerator();
        InputStream in = diagramGenerator.generateDiagram(bpmnModel, "png", highLightedNodes, highLightedFlows, configuration.getActivityFontName(),
                configuration.getLabelFontName(), configuration.getAnnotationFontName(), configuration.getClassLoader(), 1.0, true);
        return in;

    }

    /**
     * 获取流程执行节点
     *
     * @param procInsId 流程实例id
     * @return
     */
    @Override
    public AjaxResult getFlowViewer(String procInsId, String executionId) {
        List<FlowViewerDto> flowViewerList = new ArrayList<>();
        FlowViewerDto flowViewerDto;
        // 获取任务开始节点(临时处理方式)
        List<HistoricActivityInstance> startNodeList = historyService.createHistoricActivityInstanceQuery()
                .processInstanceId(procInsId)
                .orderByHistoricActivityInstanceStartTime()
                .asc().listPage(0, 3);
        for (HistoricActivityInstance startInstance : startNodeList) {
            if (!"sequenceFlow".equals(startInstance.getActivityType())) {
                flowViewerDto = new FlowViewerDto();
                if (!"sequenceFlow".equals(startInstance.getActivityType())) {
                    flowViewerDto.setKey(startInstance.getActivityId());
                    // 根据流程节点处理时间校验改节点是否已完成
                    flowViewerDto.setCompleted(!Objects.isNull(startInstance.getEndTime()));
                    flowViewerList.add(flowViewerDto);
                }
            }
        }
        // 历史节点
        List<HistoricActivityInstance> hisActIns = historyService.createHistoricActivityInstanceQuery()
                .executionId(executionId)
                .orderByHistoricActivityInstanceStartTime()
                .asc().list();
        for (HistoricActivityInstance activityInstance : hisActIns) {
            if (!"sequenceFlow".equals(activityInstance.getActivityType())) {
                flowViewerDto = new FlowViewerDto();
                flowViewerDto.setKey(activityInstance.getActivityId());
                // 根据流程节点处理时间校验改节点是否已完成
                flowViewerDto.setCompleted(!Objects.isNull(activityInstance.getEndTime()));
                flowViewerList.add(flowViewerDto);
            }
        }
        return AjaxResult.success(flowViewerList);
    }

    /**
     * 获取流程变量
     *
     * @param taskId
     * @return
     */
    @Override
    public AjaxResult processVariables(String taskId) {
//        HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery()
//                .processInstanceId(task.getProcessInstanceId())
//                .singleResult();
//        SysUser startUser = sysUserService.selectUserById(Long.parseLong(historicProcessInstance.getStartUserId()));

        // 流程变量
        HistoricTaskInstance historicTaskInstance = historyService.createHistoricTaskInstanceQuery().includeProcessVariables().finished().taskId(taskId).singleResult();
        if (Objects.nonNull(historicTaskInstance)) {
            return AjaxResult.success(historicTaskInstance.getProcessVariables());
        } else {
            Map<String, Object> variables = taskService.getVariables(taskId);
            return AjaxResult.success(variables);
        }
    }

    /**
     * 获取下一节点
     *
     * @param flowTaskVo 任务
     * @return
     */
    @Override
    public AjaxResult getNextFlowNode(FlowTaskVo flowTaskVo) {
        // Step 1. 获取当前节点并找到下一步节点
        Task task = taskService.createTaskQuery().taskId(flowTaskVo.getTaskId()).singleResult();
        FlowNextDto flowNextDto = new FlowNextDto();
        if (Objects.nonNull(task)) {
            // Step 2. 获取当前流程所有流程变量(网关节点时需要校验表达式)
            Map<String, Object> variables = taskService.getVariables(task.getId());
            List<UserTask> nextUserTask = FindNextNodeUtil.getNextUserTasks(repositoryService, task, variables);
            if (CollectionUtils.isNotEmpty(nextUserTask)) {
                for (UserTask userTask : nextUserTask) {
                    MultiInstanceLoopCharacteristics multiInstance = userTask.getLoopCharacteristics();
                    // 会签节点
                    if (Objects.nonNull(multiInstance)) {
                        flowNextDto.setVars(multiInstance.getInputDataItem());
                        flowNextDto.setType(ProcessConstants.PROCESS_MULTI_INSTANCE);
                        flowNextDto.setDataType(ProcessConstants.DYNAMIC);
                    } else {
                        // 读取自定义节点属性 判断是否是否需要动态指定任务接收人员、组
                        String dataType = userTask.getAttributeValue(ProcessConstants.NAMASPASE, ProcessConstants.PROCESS_CUSTOM_DATA_TYPE);
                        String userType = userTask.getAttributeValue(ProcessConstants.NAMASPASE, ProcessConstants.PROCESS_CUSTOM_USER_TYPE);
                        flowNextDto.setVars(ProcessConstants.PROCESS_APPROVAL);
                        flowNextDto.setType(userType);
                        flowNextDto.setDataType(dataType);
                    }
                }
            } else {
                return AjaxResult.success("流程已完结", null);
            }
        }
        return AjaxResult.success(flowNextDto);
    }

    /**
     * 获取下一节点
     *
     * @param flowTaskVo 任务
     * @return
     */
    @Override
    public AjaxResult getNextFlowNodeByStart(FlowTaskVo flowTaskVo) {
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().deploymentId(flowTaskVo.getDeploymentId()).singleResult();
        // Step 1. 获取当前节点并找到下一步节点
        FlowNextDto flowNextDto = new FlowNextDto();
        // Step 2. 获取当前流程所有流程变量(网关节点时需要校验表达式)
        List<UserTask> nextUserTask = FindNextNodeUtil.getNextUserTasksByStart(repositoryService, processDefinition, flowTaskVo.getVariables());
        if (CollectionUtils.isNotEmpty(nextUserTask)) {
            for (UserTask userTask : nextUserTask) {
                MultiInstanceLoopCharacteristics multiInstance = userTask.getLoopCharacteristics();
                // 会签节点
                if (Objects.nonNull(multiInstance)) {
                    flowNextDto.setVars(multiInstance.getInputDataItem());
                    flowNextDto.setType(ProcessConstants.PROCESS_MULTI_INSTANCE);
                    flowNextDto.setDataType(ProcessConstants.DYNAMIC);
                } else {
                    // 读取自定义节点属性 判断是否是否需要动态指定任务接收人员、组
                    String dataType = userTask.getAttributeValue(ProcessConstants.NAMASPASE, ProcessConstants.PROCESS_CUSTOM_DATA_TYPE);
                    String userType = userTask.getAttributeValue(ProcessConstants.NAMASPASE, ProcessConstants.PROCESS_CUSTOM_USER_TYPE);
                    flowNextDto.setVars(ProcessConstants.PROCESS_APPROVAL);
                    flowNextDto.setType(userType);
                    flowNextDto.setDataType(dataType);
                }
            }
        }
        return AjaxResult.success(flowNextDto);
    }

    /**
     * 流程初始化表单
     *
     * @param deployId
     * @return
     */
    @Override
    public AjaxResult flowFormData(String deployId) {
        // 第一次申请获取初始化表单
        if (StringUtils.isNotBlank(deployId)) {
            SysForm sysForm = sysInstanceFormService.selectSysDeployFormByDeployId(deployId);
            if (Objects.isNull(sysForm)) {
                return AjaxResult.error("请先配置流程表单!");
            }
            return AjaxResult.success(JSONObject.parseObject(sysForm.getFormContent()));
        } else {
            return AjaxResult.error("参数错误!");
        }
    }

    /**
     * 流程节点信息
     *
     * @param procInsId
     * @return
     */
    @Override
    public AjaxResult flowXmlAndNode(String procInsId, String deployId) {
        try {
            List<FlowViewerDto> flowViewerList = new ArrayList<>();
            // 获取已经完成的节点
            List<HistoricActivityInstance> listFinished = historyService.createHistoricActivityInstanceQuery()
                    .processInstanceId(procInsId)
                    .finished()
                    .list();

            // 保存已经完成的流程节点编号
            listFinished.forEach(s -> {
                FlowViewerDto flowViewerDto = new FlowViewerDto();
                flowViewerDto.setKey(s.getActivityId());
                flowViewerDto.setCompleted(true);
                flowViewerList.add(flowViewerDto);
            });

            // 获取代办节点
            List<HistoricActivityInstance> listUnFinished = historyService.createHistoricActivityInstanceQuery()
                    .processInstanceId(procInsId)
                    .unfinished()
                    .list();

            // 保存需要代办的节点编号
            listUnFinished.forEach(s -> {
                FlowViewerDto flowViewerDto = new FlowViewerDto();
                flowViewerDto.setKey(s.getActivityId());
                flowViewerDto.setCompleted(false);
                flowViewerList.add(flowViewerDto);
            });
            Map<String, Object> result = new HashMap();
            // xmlData 数据
            ProcessDefinition definition = repositoryService.createProcessDefinitionQuery().deploymentId(deployId).singleResult();
            InputStream inputStream = repositoryService.getResourceAsStream(definition.getDeploymentId(), definition.getResourceName());
            String xmlData = IOUtils.toString(inputStream, StandardCharsets.UTF_8);
            result.put("nodeData", flowViewerList);
            result.put("xmlData", xmlData);
            return AjaxResult.success(result);
        } catch (Exception e) {
            return AjaxResult.error("高亮历史任务失败");
        }
    }

    /**
     * 流程节点表单
     *
     * @param taskId 流程任务编号
     * @return
     */
    @Override
    public AjaxResult flowTaskForm(String taskId) throws Exception {
        JSONObject result = new JSONObject();
        result.put("formKeyExist", false);
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        BpmnModel bpmnModel = repositoryService.getBpmnModel(task.getProcessDefinitionId());
        FlowElement flowElement = bpmnModel.getFlowElement(task.getTaskDefinitionKey());
        // 流程变量
        Map<String, Object> parameters = new HashMap<>();
        HistoricTaskInstance historicTaskInstance = historyService.createHistoricTaskInstanceQuery().includeProcessVariables().finished().taskId(taskId).singleResult();
        if (Objects.nonNull(historicTaskInstance)) {
            parameters = historicTaskInstance.getProcessVariables();
        } else {
            parameters = taskService.getVariables(taskId);
        }
        // TODO 暂时只处理用户任务上的表单
        if (flowElement instanceof UserTask) {
            String formKey = ((UserTask) flowElement).getFormKey();
            if (StringUtils.isNotBlank(formKey)) {
                SysForm sysForm = sysFormService.selectSysFormById(Long.parseLong(formKey));

                JSONObject oldVariables = JSONObject.parseObject(JSON.toJSONString(parameters.get("variables")));
                List<JSONObject> oldFields = JSON.parseObject(JSON.toJSONString(oldVariables.get("fields")), new TypeReference<List<JSONObject>>() {
                });
                oldFields.forEach(obj -> obj.put("disabled", true));

                JSONObject data = JSONObject.parseObject(sysForm.getFormContent());
                List<JSONObject> newFields = JSON.parseObject(JSON.toJSONString(data.get("fields")), new TypeReference<List<JSONObject>>() {
                });

                oldFields.addAll(newFields);
                oldVariables.put("fields", oldFields);
                oldVariables.put("disabled", false);
                oldVariables.put("formBtns", true);
                result.put("formData", oldVariables);
                result.put("formKeyExist", true);
                return AjaxResult.success("", result);
            } else {
                result.put("formData", parameters.get("variables"));
                return AjaxResult.success("", result);
            }
        } else {
            result.put("formData", parameters.get("variables"));
            return AjaxResult.success("", result);
        }
    }

    /**
     * 将Object类型的数据转化成Map<String,Object>
     *
     * @param obj
     * @return
     * @throws Exception
     */
    public Map<String, Object> obj2Map(Object obj) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        Field[] fields = obj.getClass().getDeclaredFields();
        for (Field field : fields) {
            field.setAccessible(true);
            map.put(field.getName(), field.get(obj));
        }
        return map;
    }

    /**
     * 流程完成时间处理
     *
     * @param ms
     * @return
     */
    private String getDate(long ms) {

        long day = ms / (24 * 60 * 60 * 1000);
        long hour = (ms / (60 * 60 * 1000) - day * 24);
        long minute = ((ms / (60 * 1000)) - day * 24 * 60 - hour * 60);
        long second = (ms / 1000 - day * 24 * 60 * 60 - hour * 60 * 60 - minute * 60);

        if (day > 0) {
            return day + "天" + hour + "小时" + minute + "分钟";
        }
        if (hour > 0) {
            return hour + "小时" + minute + "分钟";
        }
        if (minute > 0) {
            return minute + "分钟";
        }
        if (second > 0) {
            return second + "秒";
        } else {
            return 0 + "秒";
        }
    }
}
