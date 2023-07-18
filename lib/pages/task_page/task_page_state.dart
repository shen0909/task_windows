import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_windows/common/TaskModel.dart';

class TaskPageState {
  List<String> WorktaskInfo=[];
  List<String> StudytaskInfo=[];
  List<String> LivetaskInfo=[];

  //key键: 0-全部 1-工作 2-学习 3-生活
  List<Map<int,bool>> workValue=[];
  List<Map<int,bool>> studyValue=[];
  List<Map<int,bool>> liveValue=[];
  List<Map<int,bool>> allValue=[];

  late ScrollController scrollController;
  late ScrollController WorkscrollController;
  late ScrollController StudyscrollController;
  late ScrollController LivescrollController;

  List<Task> allTask=[];
  List<Task> workTask=[];
  List<Task> studyTask=[];
  List<Task> liveTask=[];

  RxInt showPage=0.obs;

  RxBool sortValue=false.obs;//false-升序 true1-降序

  RxBool isTopValue=false.obs;//false-未置顶 true1-置顶

  late var selectedDate=DateFormat('yyyy-MM-dd').format(DateTime.now());

  TaskPageState() {
    scrollController=ScrollController();
    WorkscrollController=ScrollController();
    StudyscrollController=ScrollController();
    LivescrollController=ScrollController();

    //每类任务初始有10个未完成任务
    /*workValue=List<bool>.filled(20, false);
    studyValue=List<bool>.filled(20, false);
    liveValue=List<bool>.filled(20, false);*/
    for(int i=0;i<10;i++){
      workValue.add({1:false});
      studyValue.add({2:false});
      liveValue.add({3:false});
    }

  }
}
