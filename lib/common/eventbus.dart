import 'package:event_bus/event_bus.dart';

//EventBus:Tep2、创建事件总线
EventBus eventBus=EventBus();

//EventBus:Tep3、定义事件

/*成功添加任务事件——success属性用于判断是否成功添加属性*/
class EventSuccessAddTask{
  bool success;
  EventSuccessAddTask(this.success);
}

//任务状态更新
/*任务状态更新后哪些地方需要反应？
 *全部任务接收到的任务信息需要更新
 *单个任务类型的展开页
 *任务缩略页 */
class EventUpdateTaskStatus{
  EventUpdateTaskStatus();
}
