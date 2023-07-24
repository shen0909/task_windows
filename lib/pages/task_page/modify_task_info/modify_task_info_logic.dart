import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_windows/common/TaskModel.dart';
import 'package:task_windows/common/db_helper.dart';
import 'package:task_windows/widget/pop_list_select.dart';
import 'package:task_windows/widget/pop_toast.dart';

import 'modify_task_info_state.dart';

class ModifyTaskInfoLogic extends GetxController {
  final ModifyTaskInfoState state = ModifyTaskInfoState();
  GlobalKey typeKey = GlobalKey();
  GlobalKey repeatKey = GlobalKey();

  @override
  void onInit() {
    state.taskInfo=Get.arguments;
    print("即将修改的任务详情：${state.taskInfo.toJson()}");
    // state.typeController.text=state.taskInfo.ownType!;

    configInfo(state.taskInfo);
  }

  configInfo(Task taskInfo){
    state.typeController.text=taskInfo.ownType!;
    state.contentController.text=taskInfo.content!;
    state.StartdateController.text=taskInfo.startDate!;
    state.EnddateController.text=taskInfo.endDate!;
    state.repeatController.text=taskInfo.repeat!;
  }

  //弹出任务类型选择框
  selectTypePop(BuildContext context){
    state.typeExpand=!state.typeExpand;
    update();
    RenderBox typeBox = typeKey.currentContext!.findRenderObject() as RenderBox;

    PopToastManager().buildUI(
      context:context,
      isClickDiss: true,
      X: typeBox.localToGlobal(Offset.zero).dx+69,
      Y: typeBox.localToGlobal(Offset.zero).dy+38,
      offx: 0,
      offy: 0,
      width: 262,
      height: 90,
      dismissCallBack: (){
        state.typeExpand=!state.typeExpand;
        update();
      },
      childWidget:PopListSelect(
        hasColor: true,
        infoList: state.taskType,
        /*点击列表项之后的回调函数
         *更新输入框的内容
         *关闭浮窗 */
        indexBlock: (index){
          state.typeController.text=state.taskType[index];
          PopToastManager().dissmiss();
          state.typeExpand=!state.typeExpand;
          update();
        },
      ) ,
    );
  }

  //弹出任务重复选择框
  selectRepeatPop(BuildContext context){
    state.repeatExpand=!state.repeatExpand;
    update();
    RenderBox repeatBox=repeatKey.currentContext!.findRenderObject() as RenderBox;
    PopToastManager().buildUI(
        context: context,
        isClickDiss: true,
        X: repeatBox.localToGlobal(Offset.zero).dx+69,
        Y: repeatBox.localToGlobal(Offset.zero).dx+300,
        offx: 0,
        offy: 0,
        width: 262,
        height: 90,
        dismissCallBack: (){
          state.repeatExpand=!state.repeatExpand;
          update();
        },
        childWidget: PopListSelect(
            infoList: state.repeatType,
            indexBlock: (index){
              state.repeatController.text=state.repeatType[index];
              PopToastManager().dissmiss();
              state.repeatExpand=!state.repeatExpand;
              update();
            }));
  }

  //清空输入内容
  clearAll(){
    // state.StartdateController.text="";
    state.contentController.text="";
    // state.repeatController.text="";
    state.typeController.text="";
    update();
  }

  //提交输入内容
  /*验证表单信息
   *将任务保存到数据库中
   *返回到首页*/
  modifyInfo(){
    //先验证表单信息
    if(state.typeController.text.isNotEmpty&&state.contentController.text.isNotEmpty){
      print("可以修改任务");
      /*db里面修改完成后会发起一个EventSuccessAddTask事件*/
      _ModifyTaskToDB();
      //EventBus:Tep5、发起成功创建任务事件
      // eventBus.fire(EventSuccessAddTask(true));
      Get.back();
    }
    else if(state.typeController.text.isEmpty){
      Get.snackbar(
          "Warnning", "You should complete type!",
          icon: Icon(Icons.warning_amber_rounded,color:Colors.redAccent ,),
          colorText: Colors.redAccent,
          backgroundColor: Colors.white
      );
    }
    else if(state.contentController.text.isEmpty){
      Get.snackbar(
          "Warnning", "You should complete content!",
          icon: Icon(Icons.warning_amber_rounded,color:Colors.redAccent ,),
          colorText: Colors.redAccent,
          backgroundColor: Colors.white
      );
    }
  }

  //修改任务信息时：
  /*id 创建时间 完成状态 完成时间 不变
   *类别、内容、开始、结束日期可以修改 */
  _ModifyTaskToDB()async{
    Task task=Task();//创建一个Task对象
    task.id=state.taskInfo.id;
    task.content=state.contentController.text;
    task.ownType=state.typeController.text;
    task.startDate=state.StartdateController.text;
    task.endDate=state.EnddateController.text;
    task.repeat=state.repeatController.text;
    task.completeTime=state.taskInfo.completeTime;
    task.createTime=state.taskInfo.createTime;
    task.isCompleted=state.taskInfo.isCompleted;
    task.priority=state.taskInfo.priority;
    return await DBHelper.getInstance().updateInfo(task);
  }

  openStartDatePicker(context) async {
    //工作日文本样式
    const dayTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    //周末文本样式
    final weekendTextStyle = TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    //与当前日期相同的日期
    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );

    final config = CalendarDatePicker2WithActionButtonsConfig(
      //日文本样式
      dayTextStyle: dayTextStyle,
      //日期选择器类型——范围
      calendarType: CalendarDatePicker2Type.range,
      //所选日期的突出显示颜色
      selectedDayHighlightColor: Colors.purple[800],
      //用户点击取消按钮后关闭对话框
      closeDialogOnCancelTapped: true,
      //一周的第一天，0表示周日，6表示周六
      firstDayOfWeek: 1,
      //工作日标签的自定义文本样式
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      //日历模式切换控件的自定义文本样式
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),

      //用于在控件中集中年份和月份文本标签的标志
      centerAlignModePicker: true,

      //模式选择器按钮图标的自定义图标
      customModePickerIcon: const SizedBox(),

      //选定日历日文本的自定义文本样式
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),

      //提供对日历日文本样式的完全控制的功能
      dayTextStylePredicate: ({required date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        /*if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
          textStyle = anniversaryTextStyle;
        }*/
        if (DateUtils.isSameDay(date, DateTime.now())) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },

      //构造日部件UI
      dayBuilder: ({required date, textStyle, decoration, isSelected, isDisabled, isToday,}) {

        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = Container(
            decoration: decoration,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.5),
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected == true
                            ? Colors.white
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },

      //构造年份选择部件
      yearBuilder: ({required year, decoration, isCurrentYear, isDisabled, isSelected, textStyle,}) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == true)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    final selectDate=await showCalendarDatePicker2Dialog(
        context: context,
        config: config,
        dialogSize: const Size(325, 400)
    );
    if (selectDate != null) {

      var values=selectDate.map((e) => e!=null?e:null).toList();
      values.forEach((element) {
        print("values:${element}");
      });
      state.StartdateController.text=values[0].toString().replaceAll('00:00:00.000','').trim();
      if(values.length>1){
        state.EnddateController.text=values[1].toString().replaceAll('00:00:00.000','').trim();
      }
      else{
        state.EnddateController.text=values[0].toString().replaceAll('00:00:00.000','').trim();
      }
      /*定义了一个名为dateRegex的正则表达式，它匹配形式为四位数字-两位数字-两位数字的日期格式*//*
      final dateRegex = RegExp(r"(\d{4}-\d{2}-\d{2})");
      *//*selectDate.toString()将日期对象转换为字符串
       *dateRegex的firstMatch方法来在选中的日期对象的字符串表示中找到第一个匹配的日期字符串。*//*
      final match = dateRegex.firstMatch(selectDate.toString());
      *//*将匹配结果中的第一个捕获组（即括号内的表达式）提取出来，赋值给finalSelectDate*//*
      finalSelectDate = match?.group(1);*/
    }
    update();
  }
}
