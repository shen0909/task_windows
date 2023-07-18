import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:task_windows/common/TColors.dart';
import 'package:task_windows/common/TaskModel.dart';
import 'package:task_windows/common/eventbus.dart';
import 'package:task_windows/pages/task_page/modify_task_info/modify_task_info_view.dart';
import 'package:task_windows/pages/task_page/taskContent/task_info.dart';
import 'package:task_windows/pages/task_page/task_page_logic.dart';
import 'package:task_windows/widget/page_top_bar.dart';

class AllTask extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    List<Task> allTask=Get.find<TaskPageLogic>().state.allTask;
    List<Map<int,bool>> allValue=Get.find<TaskPageLogic>().state.allValue;


    return Scaffold(
        appBar:PageTopBar(
          title: '全部任务',
        ),
      body:Container(
        color: Tcolor.BackgroudColor,
       // child: TaskInfo(allTask, allValue, new ScrollController(),height: 550,),
       child: GetBuilder<TaskPageLogic>(builder: (logic) {
         eventBus.on<EventSuccessAddTask>().listen((event) {
           logic.getTask();
         });
         return allTask.length == 0 ?
         Container(
           height: 550,
           alignment: Alignment.center,
           child: Text("暂无任务", style: TextStyle(color: Colors.grey),),
         ) :
         Container(
           height:550,
           //只允许实现一个滑动，自动关闭多余的
           child: SlidableAutoCloseBehavior(
             child: ListView.builder(
                 controller: new ScrollController(),
                 itemCount: allTask.length,
                 itemBuilder: (context, index) {
                   return Slidable(
                     key:Key(allTask[index].id.toString()),
                     startActionPane: ActionPane(
                       motion: const StretchMotion(),
                       children: [
                         allTask[index].priority==0?
                         SlidableAction(
                           onPressed: (context){
                             print("置顶任务");
                             // Get.to(()=>ModifyTaskInfoPage(),arguments: taskInfo[index]);
                             Get.find<TaskPageLogic>().top(allTask[index]);
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
                             print("置顶任务");
                             // Get.to(()=>ModifyTaskInfoPage(),arguments: taskInfo[index]);
                             Get.find<TaskPageLogic>().top(allTask[index]);
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
                         logic.onLonpressDelete(allTask[index]);
                       }),
                       children: [
                         SlidableAction(
                           onPressed: (context){
                             print("编辑任务");
                             Get.to(()=>ModifyTaskInfoPage(),arguments: allTask[index]);
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
                             logic.onLonpressDelete(allTask[index]);
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
                         print("长按要删除的任务是:${allTask[index].toJson()}");
                         logic.onLonpressDelete(allTask[index]);
                       },
                       child: Container(
                         height: 45,
                         child: Row(
                           children: [
                             SizedBox(width: 10,),
                             RoundCheckBox(
                               size: 15,
                               checkedWidget: Icon(Icons.check_rounded, size: 10,),
                               checkedColor: Colors.lightBlueAccent,
                               isChecked: allValue[index].values.first,
                               onTap: (bool? value) {
                                 print("click 完成任务,单选框:${value}");
                                 /*点击后的value值，第index条任务，第index条任务的value情况*/
                                 logic.checkBoxValue(value!, index, allValue[index]);
                               },
                             ),
                             Expanded(
                               child: ListTile(
                                 leading: allValue[index].values.first ?
                                 Text(
                                   allTask[index].content!,
                                   style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey,),
                                 ) :
                                 //priority=0,未置顶,priority=1,置顶
                                 allTask[index].priority==0?
                                 Text(allTask[index].content!,):
                                 Text(allTask[index].content!,style: TextStyle(fontWeight: FontWeight.bold),),
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
       }),
      )
    );
  }
}
