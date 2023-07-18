import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_windows/common/TColors.dart';
import 'package:task_windows/widget/page_top_bar.dart';
import 'package:task_windows/widget/textInputField.dart';

import 'modify_task_info_logic.dart';

class ModifyTaskInfoPage extends StatelessWidget {

  // Task taskInfo=Get.arguments;
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ModifyTaskInfoLogic());
    final state = Get.find<ModifyTaskInfoLogic>().state;

    // print("即将修改的任务是：${taskInfo}");
    return Scaffold(
      appBar: PageTopBar(title: "编辑任务"),
      body: _modifyInfo(context,state),
    );
  }

  _modifyInfo(context,modifyState) {
    return GetBuilder<ModifyTaskInfoLogic>(builder: (logic) {
      return Center(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          color: Tcolor.BackgroudColor,
          child: Column(
            children: [
              //任务类型 0-工作 1-学习 2-生活
              Container(
                key: logic.typeKey,
                child: InputFied(
                    fieldwidth: 260,
                    readonly: true,
                    hintText: "请选择任务类型",
                    controller: modifyState.typeController,
                    iconWidget: InkWell(
                      child: Icon(modifyState.typeExpand
                          ? Icons.expand_less_outlined
                          : Icons.expand_more, color: Colors.grey, size: 18,),
                      onTap: () {
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
                  controller: modifyState.contentController,
                  iconWidget: InkWell(
                    child: Icon(Icons.highlight_remove, color: Colors.grey,
                      size: 18,),
                    onTap: () {
                      print("清除内容");
                      modifyState.contentController.text = "";
                    },
                  )
              ),
              SizedBox(height: 20,),
              //任务日期
              InputFied(
                  title: "开始日期:",
                  hintText: "请选择任务开始日期",
                  controller: modifyState.StartdateController,
                  fieldwidth: 260,
                  iconWidget: InkWell(
                    child: Icon(Icons.access_time_rounded, color: Colors.grey,
                      size: 18,),
                    onTap: () {
                      print("选择开始日期");
                      logic.openStartDatePicker(context);
                    },
                  )
              ),
              SizedBox(height: 20,),
              InputFied(
                  title: "结束日期:",
                  hintText: "请选择任务结束日期",
                  controller: modifyState.EnddateController,
                  fieldwidth: 260,
                  iconWidget: InkWell(
                    child: Icon(Icons.access_time_rounded, color: Colors.grey,
                      size: 18,),
                    onTap: () {
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
                    controller: modifyState.repeatController,
                    readonly: true,
                    iconWidget: InkWell(
                      child: Icon(modifyState.repeatExpand
                          ? Icons.expand_less_outlined
                          : Icons.expand_more, color: Colors.grey, size: 18,),
                      onTap: () {
                        print("弹出周期选择弹窗");
                        logic.selectRepeatPop(context);
                      },
                    )
                ),
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        print("清空");
                        logic.clearAll();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Tcolor.barBackgroudColor),
                        minimumSize: MaterialStateProperty.all(Size(90, 40)),
                        elevation: MaterialStateProperty.all(1),
                      ),
                      child: Text("清空")),
                  SizedBox(width: 30,),
                  ElevatedButton(
                      onPressed: () {
                        print("确定");
                        logic.modifyInfo();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Tcolor.barBackgroudColor),
                        elevation: MaterialStateProperty.all(1),
                        minimumSize: MaterialStateProperty.all(Size(90, 40)),
                        // maximumSize:MaterialStateProperty.all(Size(60, 40))
                      ),
                      child: Text("确定")),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
