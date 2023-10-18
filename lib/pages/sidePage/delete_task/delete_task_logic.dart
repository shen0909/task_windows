import 'package:get/get.dart';
import 'package:task_windows/common/TaskModel.dart';
import 'package:task_windows/common/db_helper.dart';
import 'package:task_windows/common/eventbus.dart';
import 'delete_task_state.dart';

class DeleteTaskLogic extends GetxController {
  final DeleteTaskState state = DeleteTaskState();

  @override
  void onInit()  {
    super.onInit();
    getDeleteTask();
    eventBus.on<EventSuccessAddTask>().listen((event) {
      getDeleteTask();
    });
  }

  getDeleteTask() async {
    state.deleteTask.clear();

    state.deleteTask=await DBHelper.getInstance().queryDelete();
    /*state.deleteTask.forEach((element) {
      print("deleteTask:${element.toJson()}");
    });*/
    update();
  }

  recoverTask(Task task){
    print("恢复任务:${task.toJson()}");
    DBHelper.getInstance().recoverTask(task);
    update();
  }
}
