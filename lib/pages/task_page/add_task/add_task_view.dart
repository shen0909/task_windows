import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_windows/common/TColors.dart';
import 'package:task_windows/widget/page_top_bar.dart';
import 'package:task_windows/widget/textInputField.dart';
import 'add_task_state.dart';
import 'add_task_logic.dart';

class AddTaskPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AddTaskLogic());
    final state = Get.find<AddTaskLogic>().state;

    return Scaffold(
      appBar: PageTopBar(
        title: "添加任务",
      ),
      body: _addTaskContent(state,context),
    );
  }

  _addTaskContent(AddTaskState addTaskState,BuildContext context) {
    return GetBuilder<AddTaskLogic>(builder: (logic) {
      return Container(
        padding: EdgeInsets.only(left: 20,right: 20,top: 30),
        // color: Tcolor.BackgroudColor,
        child: Column(
          children: [
            Container(
              // color: Colors.redAccent,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //任务类型 0-工作 1-学习 2-生活
                  Container(
                    key: logic.typeKey,
                    child: InputFied(
                        fieldwidth: 260,
                        readonly: true,
                        hintText: "请选择任务类型",
                        controller: addTaskState.typeController,
                        iconWidget: InkWell(
                          child: Icon(addTaskState.typeExpand?Icons.expand_less_outlined:Icons.expand_more,color: Colors.grey,size: 18,),
                          onTap: (){
                            print("弹出任务类型选择框");
                            logic.selectTypePop(context);
                          },
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  //任务内容
                  InputFied(
                      fieldwidth: 260,
                      title: "任务详情:",
                      hintText: "请输入任务内容",
                      controller: addTaskState.contentController,
                      iconWidget: InkWell(
                        child: Icon(Icons.highlight_remove,color: Colors.grey,size: 18,),
                        onTap: (){
                          print("清除内容");
                          addTaskState.contentController.text="";
                        },
                      )
                  ),
                  SizedBox(height: 20,),
                  //任务日期
                  InputFied(
                      title: "开始日期:",
                      hintText: "请选择任务开始日期",
                      readonly: true,
                      controller: addTaskState.StartdateController,
                      fieldwidth: 260,
                      iconWidget: InkWell(
                        child: Icon(Icons.access_time_rounded,color: Colors.grey,size: 18,),
                        onTap: (){
                          print("选择开始日期");
                          logic.openStartDatePicker(context);
                        },
                      )
                  ),
                  SizedBox(height: 20,),
                  InputFied(
                      title: "结束日期:",
                      hintText: "请选择任务结束日期",
                      readonly: true,
                      controller: addTaskState.EnddateController,
                      fieldwidth: 260,
                      iconWidget: InkWell(
                        child: Icon(Icons.access_time_rounded,color: Colors.grey,size: 18,),
                        onTap: (){
                          print("选择结束日期");
                          logic.openStartDatePicker(context);
                        },
                      )
                  ),
                  SizedBox(height: 20,),
                  //任务是否重复
                  Container(
                    key: logic.repeatKey,
                    child: InputFied(
                        fieldwidth: 260,
                        hintText: "请选择任务是否重复",
                        title: "任务周期:",
                        controller: addTaskState.repeatController,
                        readonly: true,
                        iconWidget: InkWell(
                          child: Icon(addTaskState.repeatExpand?Icons.expand_less_outlined:Icons.expand_more,color: Colors.grey,size: 18,),
                          onTap: (){
                            print("弹出周期选择弹窗");
                            logic.selectRepeatPop(context);
                          },
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  /*Row(
                    children: [
                      Text("是否置顶:"),
                      Text("是"),
                      SizedBox(width: 10,),
                      checkBox(
                        size: 15,
                        checkedWidget: Icon(Icons.check_rounded, size: 10,),
                        onTap: (bool? value ) {

                        },

                      )
                    ],
                  ),*/
                ],
              ),
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      print("清空");
                      logic.clearAll();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Tcolor.barBackgroudColor),
                      minimumSize:MaterialStateProperty.all(Size(90, 40)),
                      elevation: MaterialStateProperty.all(1),
                    ),
                    child: Text("清空")),
                SizedBox(width: 30,),
                ElevatedButton(
                    onPressed: (){
                      print("确定");
                      logic.submitInfo();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Tcolor.barBackgroudColor),
                      elevation: MaterialStateProperty.all(1),
                      minimumSize:MaterialStateProperty.all(Size(90, 40)),
                      // maximumSize:MaterialStateProperty.all(Size(60, 40))
                    ),
                    child: Text("确定")),
              ],
            )
          ],
        ),
      );
    });
  }
}
