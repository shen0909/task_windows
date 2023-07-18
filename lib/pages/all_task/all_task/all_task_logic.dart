import 'package:get/get.dart';
import 'package:task_windows/common/db_helper.dart';
import 'package:task_windows/common/eventbus.dart';
import 'package:task_windows/pages/task_page/task_page_logic.dart';

import 'all_task_state.dart';

class AllTaskLogic extends GetxController {
  final AllTaskState state = AllTaskState();

  @override
  void onInit() {
    allGetTask();
    eventBus.on<EventSuccessAddTask>().listen((event) {
      print("AllTaskLogic监听成功");
      allGetTask();
    });
  }

  allGetTask() async {
    print("allGetTask()");
    state.allTask.clear();
    state.allValue.clear();

    state.allTask.addAll(await DBHelper.getInstance().queryASC());
    for(int i=0;i<state.allTask.length;i++){
      if(state.allTask[i].isCompleted==0){
        state.allValue.add({0:false});
      }
      else{
        state.allValue.add({0:true});
      }
    }
    state.allTask.forEach((element) {
      print("优先级:${element.priority}——完成情况:${element.isCompleted}——内容:${element.content}");
    });
    update();
  }
}
