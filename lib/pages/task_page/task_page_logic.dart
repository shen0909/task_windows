import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_windows/common/TaskModel.dart';
import 'package:task_windows/common/db_helper.dart';
import 'package:task_windows/common/eventbus.dart';
import 'task_page_state.dart';

class TaskPageLogic extends GetxController {
  final TaskPageState state = TaskPageState();
  // late StreamSubscription streamSuccessAddTask;

  @override
  void onInit() {
    // DBHelper.getInstance().setdefaultValue();
    // print("时间格式：${DateFormat('yyyy-MM-dd').format(DateTime.now())+"--"+DateFormat.Hms().format(DateTime.now()).toString()}");
    //获取所有任务
    getTask();
    // modifyStartEndDate();

    //EventBus:Tep4、注册监听器，监听EventSuccessAddTask事件
    eventBus.on<EventSuccessAddTask>().listen((event) {
      print("TaskLogic监听");
      // print("是否成功创建任务？:${event.success}");
      getTask();/*获取所有任务*/
    });

    eventBus.on<EventUpdateTaskStatus>().listen((event) {
      print("任务状态更新监听-重新获取任务");
      getTask();/*获取所有任务*/
    });
    update();
  }

  //从数据库中获取数据
  getTask() async {
    print("getTask()");

    DateTime current=DateTime.parse(state.selectedDate);
    print("current:${current}");

    // List<Map<String,dynamic>> task=await DBHelper.getInstance().query();
    //返回一个Task类型的列表

    /*getTask()是任务数据发生变化时都会调用的，如果在这里指定一种查询方式，那么后面点击排序按钮数据也只会保持一次，随即又变成getTask()中选择的样子*/
    List<Task> task=[];
    if(state.sortValue.value==false){
      task = await DBHelper.getInstance().queryASC();
    }
    else{
      task = await DBHelper.getInstance().queryDESC();
    }

    //清除所有任务以便保存新任务
    state.allTask.clear();
    state.workTask.clear();
    state.studyTask.clear();
    state.liveTask.clear();

    state.allTask.addAll(task);

    /*遍历读取到的每一个任务，判断当前日期是否在它的开始和结束时间之间(包括)
     *符合条件就说明这是当天的任务，按类别保存到Task列表中 */
    task.forEach((taskItem) {
      // print("taskItem--->${taskItem.toJson()}");
      DateTime startDate=DateFormat('yyyy-MM-dd').parse(taskItem.startDate!);
      DateTime endDate=DateFormat('yyyy-MM-dd').parse(taskItem.endDate!);
      if(startDate.isBefore(current)&&endDate.isAfter(current)||
          startDate.isAtSameMomentAs(current)||
          endDate.isAtSameMomentAs(current)){

        // print("true————${taskItem.content}");

        if(taskItem.ownType=="工作"){
          state.workTask.add(taskItem);
        }
        else if(taskItem.ownType=="学习"){
          state.studyTask.add(taskItem);
        }
        else if(taskItem.ownType=="生活"){
          state.liveTask.add(taskItem);
        }
      }

    });

    /*state.allTask.forEach((element) {
      // print("task:${element.toJson()}");
      print("startDate:${element.startDate}+endDate:${element.endDate}");
      // print("task->是否完成${element.isCompleted}+完成时间${element.completeTime}+任务内容${element.content}");
    });*/
    //重新获取任务的完成情况
    regetCheckValue();
    // modifyStartEndDate();
    update();
  }

  //点击完成框，完成任务
  /*传入当前点击的任务value——>Map<int,bool> checkValue、当前点击的该类中的第几个index、value值作为参数
   *判断checkValue的键————>1 工作类 2 学习类 3 生活类
   *将对应类的第index个的值改成value
   *更改完value后只是改好了单选框的状态，
   *调用数据库的更新方法，修改该类的inex项任务的完成情况  */
  checkBoxValue(bool value,int index,Map<int,bool> checkValue){
    print("checkValue:${checkValue}");
    /*如果当前点击的value键是1，则是工作类，则将工作类中的第index个value改为!value*/
    if(checkValue.keys.first==0){
      state.allValue[index][0]=value;
      modifyComplete(state.allTask[index],value);
      print("修改所有任务完成情况: state.allValue:${state.allValue}");
    }
    if(checkValue.keys.first==1){
      state.workValue[index][1]=value;
      //在数据库中更新任务的完成情况
      modifyComplete(state.workTask[index],value);
      print("修改工作类任务完成情况: state.workValue:${state.workValue}");
    }
    if(checkValue.keys.first==2){
      state.studyValue[index][2]=value;
      modifyComplete(state.studyTask[index],value);
      print("修改学习类任务完成情况: state.studyValue:${state.studyValue}");
    }
    if(checkValue.keys.first==3){
      state.liveValue[index][3]=value;
      modifyComplete(state.liveTask[index],value);
      print("修改生活类任务完成情况: state.liveValue:${state.liveValue}");
    }
    update();
  }

  //修改完成状态
  /*传入当前点击的任务和单选框点击后的状态值作为参数
   *单选框点击后的状态值与任务的完成情况相关
   *value==false 说明点击后未完成
   *value==true  说明点击后完成  */
  modifyComplete(Task task,bool value) async {
    print("要修改的任务：${task.toJson()},修改后的状态为：${value}");
    //false--未完成
    if(value==false){
      await DBHelper.getInstance().updateComplete(0,task);
    }
    //true---完成
    else{
      await DBHelper.getInstance().updateComplete(1,task);
    }
    // getTask();
  }

  //重新获取任务的完成情况
  /*先清除原本的状态
   *根据每类任务的个数，创建value
   *根据每类任务的每项任务的完成情况确定value值*/
  regetCheckValue(){
    //清除任务的完成状况
    state.workValue.clear();
    state.studyValue.clear();
    state.liveValue.clear();

    //获取 工作类 任务的个数
    for(int i=0;i<state.workTask.length;i++) {
      //根据每个任务的完成状态设置value值
      // ==0 未完成
      if (state.workTask[i].isCompleted == 0) {
        var value = false;
        state.workValue.add({1: value});
      }
      //==1 已完成
      else {
        var value = true;
        state.workValue.add({1: value});
      }
    }

    for(int i=0;i<state.studyTask.length;i++) {
      //==0 未完成
      if (state.studyTask[i].isCompleted == 0) {
        var value = false;
        state.studyValue.add({2: value});
      }
      //==1 已完成
      else {
        var value = true;
        state.studyValue.add({2: value});
      }
    }
    for(int i=0;i<state.liveTask.length;i++) {
      //==0 未完成
      if (state.liveTask[i].isCompleted == 0) {
        var value = false;
        state.liveValue.add({3: value});
      }
      //==1 已完成
      else {
        var value = true;
        state.liveValue.add({3: value});
      }
    }
    //所有任务
    for(int i=0;i<state.allTask.length;i++){
      if(state.allTask[i].isCompleted==0){
        state.allValue.add({0:false});
      }
      else{
        state.allValue.add({0:true});
      }
    }
  }

  //长按删除任务
  Future<void> onLonpressDelete(Task task) async {
    await DBHelper.getInstance().delete(task);
    // getTask();
    update();
  }

  //点击任务类别——跳转页面展示该类别的 当日 所有任务
  changePage(String title){
    if(title=="工作"){
      state.showPage=1.obs;
    }
    else if(title=="学习"){
      state.showPage=2.obs;
    }
    else if(title=="生活"){
      state.showPage=3.obs;
    }
    update();
  }

  //修改任务的开始、结束时间(已弃用)
  modifyStartEndDate(){
    print("modifyStartEndDate");
    for(int i=0;i<state.allTask.length;i++){
      // print("Task[$i]:${state.allTask[i].toJson()}");
      String time=state.allTask[i].createTime.toString();
      // DateTime dateTime=DateTime.parse(time.replaceAll("--", "T"));
      DateTime dateTime = DateFormat('M/d/yyyyTH:m:s').parse(time);
      String iso8601Str = dateTime.toIso8601String();
      print("任务创建时间:${iso8601Str}");

      DBHelper.getInstance().updateDate(state.allTask[i],iso8601Str);
    }
    // print("${(DateFormat('yyyy-MM-dd').format(DateTime.now())+"--"+DateFormat.Hms().format(DateTime.now())).toString()}");
  }

  //排序
  /*修改sortValue的值*/
  sort(){
    state.sortValue.value=!state.sortValue.value;
    print("state.sortValue.value:${state.sortValue.value}");
    //重新获取任务
    getTask();
    update();
  }

  //置顶任务
  /*修改任务的优先级
   *传入需要修改的某条任务，调用DBHelper的修改优先级方法。修改之后重新调用getTask()方法，重新获取数据
   *关键是，如何取消置顶？
   *取消置顶需要将优先级修改成0,
   *最好是给所有任务添加一个置顶状态*/
  top(taskInfo){
    print("置顶置顶！！");
    DBHelper.getInstance().updatePriority(taskInfo);
    getTask();
    update();

  }

  getSelectedDate(select){
    state.selectedDate=select;
    eventBus.fire(EventSuccessAddTask(true));
    update();
  }
}
