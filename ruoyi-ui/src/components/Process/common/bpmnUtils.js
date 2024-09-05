import { NodeName } from '../lang/zh'

// 创建监听器实例
export function createListenerObject(moddle, options, isTask, prefix) {
  const listenerObj = Object.create(null);
  listenerObj.event = options.event;
  isTask && (listenerObj.id = options.id); // 任务监听器特有的 id 字段
  switch (options.listenerType) {
    case "scriptListener":
      listenerObj.script = createScriptObject(moddle, options, prefix);
      break;
    case "expressionListener":
      listenerObj.expression = options.expression;
      break;
    case "delegateExpressionListener":
      listenerObj.delegateExpression = options.delegateExpression;
      break;
    default:
      listenerObj.class = options.class;
  }
  // 注入字段
  if (options.fields) {
    listenerObj.fields = options.fields.map(field => {
      return createFieldObject(moddle, field, prefix);
    });
  }
  // 任务监听器的 定时器 设置
  if (isTask && options.event === "timeout" && !!options.eventDefinitionType) {
    const timeDefinition = moddle.create("bpmn:FormalExpression", {
      body: options.eventTimeDefinitions
    });
    const TimerEventDefinition = moddle.create("bpmn:TimerEventDefinition", {
      id: `TimerEventDefinition_${uuid(8)}`,
      [`time${options.eventDefinitionType.replace(/^\S/, s => s.toUpperCase())}`]: timeDefinition
    });
    listenerObj.eventDefinitions = [TimerEventDefinition];
  }
  return moddle.create(`${prefix}:${isTask ? "TaskListener" : "ExecutionListener"}`, listenerObj);
}

// 处理内置流程监听器
export function createSystemListenerObject(moddle, options, isTask, prefix) {
  const listenerObj = Object.create(null);
  listenerObj.event = options.eventType;
  listenerObj.listenerType = options.valueType;
  switch (options.valueType) {
    case "scriptListener":
      listenerObj.script = createScriptObject(moddle, options, prefix);
      break;
    case "expressionListener":
      listenerObj.expression = options.expression;
      break;
    case "delegateExpressionListener":
      listenerObj.delegateExpression = options.delegateExpression;
      break;
    default:
      listenerObj.class = options.value;
  }
  return moddle.create(`${prefix}:${isTask ? "TaskListener" : "ExecutionListener"}`, listenerObj);
}

// 转换成字段
export function changeListenerObject(options) {
  const listenerObj = Object.create(null);
  listenerObj.event = options.eventType;
  listenerObj.listenerType = options.valueType;
  switch (options.valueType) {
    case "scriptListener":
      // listenerObj.script = createScriptObject(moddle, options, prefix);
      break;
    case "expressionListener":
      listenerObj.expression = options.expression;
      break;
    case "delegateExpressionListener":
      listenerObj.delegateExpression = options.delegateExpression;
      break;
    default:
      listenerObj.class = options.value;
  }
  return listenerObj;
}

// 创建 监听器的注入字段 实例
export function createFieldObject(moddle, option, prefix) {
  const { name, fieldType, string, expression } = option;
  const fieldConfig = fieldType === "string" ? { name, string } : { name, expression };
  return moddle.create(`${prefix}:Field`, fieldConfig);
}

// 创建脚本实例
export function createScriptObject(moddle, options, prefix) {
  const { scriptType, scriptFormat, value, resource } = options;
  const scriptConfig = scriptType === "inlineScript" ? { scriptFormat, value } : { scriptFormat, resource };
  return moddle.create(`${prefix}:Script`, scriptConfig);
}

// 更新元素扩展属性
export function updateElementExtensions(moddle, modeling, element, extensionList) {
  const extensions = moddle.create("bpmn:ExtensionElements", {
    values: extensionList
  });
  modeling.updateProperties(element, {
    extensionElements: extensions
  });
}

// 创建一个id
export function uuid(length = 8, chars) {
  let result = "";
  let charsString = chars || "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  for (let i = length; i > 0; --i) {
    result += charsString[Math.floor(Math.random() * charsString.length)];
  }
  return result;
}

// 转换流程节点名称
export function translateNodeName(node){
  return NodeName[node];
}
