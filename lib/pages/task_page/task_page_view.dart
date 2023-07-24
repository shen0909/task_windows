import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_windows/common/TColors.dart';
import 'package:task_windows/pages/task_page/task_display/task_info.dart';
import 'package:task_windows/pages/task_page/type_Page/detail_page.dart';
import 'task_page_logic.dart';

class TaskPagePage extends StatelessWidget {
  const TaskPagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(TaskPageLogic());
    final state = Get.find<TaskPageLogic>().state;
    return  GetBuilder<TaskPageLogic>(builder: (logic) {
      return Container(
        height: 650,
        child: Column(
          children: [
            SizedBox(height: 5,),
            //DatePicker不支持水平滑动
            Container(
              width: 390,
              decoration: BoxDecoration(
                  color: Colors.cyan,
                  // color: Tcolor.BackgroudColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: DatePicker(
                height: 75,
                /*开始日期*/
                DateTime.now(),
                /*初始选择日期时间*/
                initialSelectedDate: DateTime.now(),
                selectedTextColor: Colors.white,
                selectionColor: Tcolor.SelectedColor,
                monthTextStyle: TextStyle(fontSize: 12),
                dayTextStyle: TextStyle(fontSize: 12,),
                dateTextStyle: TextStyle(fontSize: 12,),
                onDateChange: (selectedDate) {
                  var selected=DateFormat('yyyy-MM-dd').format(selectedDate);
                  print("你选择了:${selected}");
                  logic.getSelectedDate(selected);
                },
              ),
            ),
            Obx(() {
              //工作页
              if (state.showPage == 1) {
                return DetailType("工作",Tcolor.workcolor,state.workTask,state.workValue,state.WorkscrollController);
                // Future.delayed(Duration.zero, () => Get.to(() => WorkeType(context)));
              }
              else if (state.showPage == 2) {
                return DetailType("学习",Tcolor.studycolor,state.studyTask,state.studyValue,state.StudyscrollController);
              }
              else if (state.showPage == 3) {
                return DetailType("生活",Tcolor.livecolor,state.liveTask,state.liveValue,state.LivescrollController);
              }
              //展示三个类型的缩略
              return allPage(state);
            })
          ],
        ),
      );
    });
  }

  allPage(state) {
    return Column(
      children: [
        _buildTietle("工作", Tcolor.workcolor),
        TaskInfo(state.workTask,state.workValue,state.WorkscrollController),
        // _taskContent(state.workTask, state.workValue, state.WorkscrollController),
        _buildTietle("学习", Tcolor.studycolor),
        //列表栏展示任务
        TaskInfo(state.studyTask, state.studyValue, state.StudyscrollController),
        // _taskContent(state.studyTask, state.studyValue, state.StudyscrollController),
        _buildTietle("生活", Tcolor.livecolor),
        // _taskContent(state.liveTask, state.liveValue, state.LivescrollController),
        TaskInfo(state.liveTask, state.liveValue, state.LivescrollController),
      ],
    );
  }

  //标题
  _buildTietle(String title, Color color) {
    return GetBuilder<TaskPageLogic>(builder: (logic) {
      return GestureDetector(
        onTap: () {
          print("click ${title}");
          logic.changePage(title);
        },
        child:Container(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Divider(thickness: 0.4, color: Colors.grey,),
              // SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 10,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                          color: color
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(title),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  //参数:类别 - 类别任务信息 - 单选框 - 滑动控制器
  /*_taskContent(List<Task> taskInfo, List<Map<int, bool>> checkValue, ScrollController scrollController) {
    return GetBuilder<TaskPageLogic>(builder: (logic) {
      return taskInfo.length == 0 ?
      Container(
        height: 100,
        alignment: Alignment.center,
        child: Text("暂无任务", style: TextStyle(color: Colors.grey),),
      ) :
      Container(
        height: 100,
        child: ListView.builder(
            controller: scrollController,
            itemCount: taskInfo.length,
            itemBuilder: (context, index) {
              return Slidable(
                key:Key(taskInfo[index].id.toString()),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(
                      onDismissed: (){
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
                    print("长按删除任务");
                    print("要删除的任务是:${taskInfo[index].toJson()}");
                    logic.onLonpressDelete(taskInfo[index]);
                  },
                  child: Container(
                    height: 45,
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        // Text(taskInfo[index].content!),
                        RoundCheckBox(
                          size: 15,
                          checkedWidget: Icon(Icons.check, size: 10,),
                          checkedColor: Colors.lightBlueAccent,
                          isChecked: checkValue[index].values.first,
                          onTap: (bool? value) {
                            print("click 完成任务");
                            print("click 单选框:${value}");
                            logic.checkBoxValue(value!, index, checkValue[index]);
                          },
                        ),
                        Expanded(
                          child: ListTile(
                            leading: checkValue[index].values.first ?
                            Text(taskInfo[index].content!, style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),) :
                            Text(taskInfo[index].content!),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      );
    });
  }*/
}
