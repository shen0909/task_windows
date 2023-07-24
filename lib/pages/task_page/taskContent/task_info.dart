import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:task_windows/common/TColors.dart';
import 'package:task_windows/common/TaskModel.dart';
import 'package:task_windows/pages/task_page/modify_task_info/modify_task_info_view.dart';
import 'package:task_windows/pages/task_page/task_page_logic.dart';

//封装任务列表

//传入的数据
class TaskInfo extends StatelessWidget {

  List<Task> taskInfo;
  List<Map<int, bool>> checkValue;
  ScrollController scrollController;
  double height;

  TaskInfo(this.taskInfo, this.checkValue, this.scrollController,{this.height=135});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<TaskPageLogic>(builder: (logic) {

      return taskInfo.length == 0 ?
      Container(
        height: height,
        alignment: Alignment.center,
        child: Text("暂无任务", style: TextStyle(color: Colors.grey),),
      ) :
      Container(
        height:height,
        // color: Colors.red,
        //只允许实现一个滑动，自动关闭多余的
        child: SlidableAutoCloseBehavior(
          child: ListView.builder(
              controller: scrollController,
              itemCount: taskInfo.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key:Key(taskInfo[index].id.toString()),
                  startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      taskInfo[index].priority==0?
                      SlidableAction(
                        onPressed: (context){
                          print("置顶任务");
                          // Get.to(()=>ModifyTaskInfoPage(),arguments: taskInfo[index]);
                          Get.find<TaskPageLogic>().top(taskInfo[index]);
                        },
                        spacing: 10,
                        // padding: EdgeInsets.only(left: 10),
                        backgroundColor: Tcolor.editBackgroudColor,
                        foregroundColor: Tcolor.textColor,
                        icon: Icons.vertical_align_top_sharp,
                        label: "置顶",
                        borderRadius: BorderRadius.circular(10),
                      ):
                      SlidableAction(
                        onPressed: (context){
                          print("取消置顶");
                          // Get.to(()=>ModifyTaskInfoPage(),arguments: taskInfo[index]);
                          Get.find<TaskPageLogic>().top(taskInfo[index]);
                        },
                        spacing: 10,
                        // padding: EdgeInsets.only(left: 10),
                        backgroundColor: Tcolor.editBackgroudColor,
                        foregroundColor: Tcolor.textColor,
                        icon: Icons.vertical_align_top_sharp,
                        label: "取消置顶",
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    dismissible: DismissiblePane(onDismissed: (){
                      logic.onLonpressDelete(taskInfo[index]);
                    }),
                    children: [
                      SlidableAction(
                        onPressed: (context){
                          print("编辑任务");
                          Get.to(()=>ModifyTaskInfoPage(),arguments: taskInfo[index]);
                        },
                        spacing: 10,
                        // padding: EdgeInsets.only(left: 10),
                        backgroundColor: Tcolor.editBackgroudColor,
                        foregroundColor: Tcolor.textColor,
                        icon: Icons.edit_calendar_rounded,
                        label: "编辑",
                        borderRadius: BorderRadius.circular(10),
                      ),
                      SlidableAction(
                        onPressed: (context){
                          print("删除任务");
                          logic.onLonpressDelete(taskInfo[index]);
                        },
                        spacing: 10,
                        backgroundColor: Tcolor.cancelBackgroudColor,
                        foregroundColor: Tcolor.textColor,
                        icon: Icons.delete,
                        label: "删除",
                        borderRadius: BorderRadius.circular(10),),
                    ],
                  ),
                  child: InkWell(
                    onLongPress: () {
                      print("长按要删除的任务是:${taskInfo[index].toJson()}");
                      logic.onLonpressDelete(taskInfo[index]);
                    },
                    child: Container(
                      height: 45,
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          //完成任务的图标颜色，根据任务的类型来确定，显示为任务类别的对应颜色
                          RoundCheckBox(
                            size: 15,
                            checkedWidget: Icon(Icons.check_rounded, color:Colors.white,size: 10,),
                            checkedColor: taskInfo[index].ownType=="工作"?
                            Tcolor.workcolor: taskInfo[index].ownType=="学习"?
                            Tcolor.studycolor: Tcolor.livecolor,
                            isChecked: checkValue[index].values.first,
                            onTap: (bool? value) {
                              print("click 完成任务,单选框:${value}");
                              /*点击后的value值，第index条任务，第index条任务的value情况*/
                              logic.checkBoxValue(value!, index, checkValue[index]);
                            },
                          ),
                          Expanded(
                            child: ListTile(
                              leading: checkValue[index].values.first ?
                              Text(
                                taskInfo[index].content!,
                                style: TextStyle(fontFamily: "notoSancsSC",fontWeight: FontWeight.w100),
                                /*style:GoogleFonts.lato(
                                  textStyle:  TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  )
                                ),*/
                              ) :
                              //priority=0,未置顶,priority=1,置顶
                              taskInfo[index].priority==0?
                              Text(taskInfo[index].content!,
                                  style: TextStyle(fontFamily: "notoSancsSC",),
                                  /*style:GoogleFonts.notoSans(
                                      textStyle:  TextStyle(
                                          color: Colors.black,
                                          fontSize: 14
                                      )
                                  )*/
                                  /*GoogleFonts.lato(
                                      textStyle:  TextStyle(
                                        color: Colors.black,
                                        fontSize: 14
                                      )
                                  )*/):
                              Text(taskInfo[index].content!,
                                style: TextStyle(fontFamily: "notoSancsSC",fontWeight: FontWeight.bold),
                                ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
      );
    });
  }
}
