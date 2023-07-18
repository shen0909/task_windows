import 'package:flutter/cupertino.dart';
import 'package:task_windows/common/TaskModel.dart';

class ModifyTaskInfoState {

  late Task taskInfo;

  //文本控制器
  final TextEditingController typeController=TextEditingController();
  final TextEditingController contentController=TextEditingController();
  final TextEditingController StartdateController=TextEditingController();
  final TextEditingController EnddateController=TextEditingController();
  final TextEditingController repeatController=TextEditingController();

  List<String> taskType=["工作","学习","生活"];
  late bool typeExpand=false;
  List<String> repeatType=["从不","每天","每周","每月","每年"];
  late bool repeatExpand=false;


  ModifyTaskInfoState() {
  }
}
