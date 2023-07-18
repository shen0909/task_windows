import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskState {
  List<String> taskType=["工作","学习","生活"];
  late bool typeExpand=false;

  List<String> repeatType=["从不","每天","每周","每月","每年"];
  late bool repeatExpand=false;

  //文本控制器
  final TextEditingController typeController=TextEditingController();
  final TextEditingController contentController=TextEditingController();
  final TextEditingController StartdateController=TextEditingController();
  final TextEditingController EnddateController=TextEditingController();
  final TextEditingController repeatController=TextEditingController();
  int isTop=0;
  AddTaskState() {
    StartdateController.text=DateFormat('yyyy-MM-dd').format(DateTime.now());
    EnddateController.text=DateFormat('yyyy-MM-dd').format(DateTime.now());
    // EnddateController.text=DateFormat.yMEd().format(DateTime.now());
    repeatController.text="从不";
  }
}
