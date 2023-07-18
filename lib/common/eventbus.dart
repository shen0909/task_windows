import 'package:event_bus/event_bus.dart';

//EventBus:Tep2、创建事件总线
EventBus eventBus=EventBus();

//EventBus:Tep3、定义事件

/*成功添加任务事件——success属性用于判断是否成功添加属性*/
class EventSuccessAddTask{
  bool success;
  EventSuccessAddTask(this.success);
}
