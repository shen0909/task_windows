import 'package:get/get.dart';
import 'package:task_windows/common/db_helper.dart';
import 'package:task_windows/common/eventbus.dart';

import 'delete_task_state.dart';

class DeleteTaskLogic extends GetxController {
  final DeleteTaskState state = DeleteTaskState();

  @override
  void onInit()  {
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
}
