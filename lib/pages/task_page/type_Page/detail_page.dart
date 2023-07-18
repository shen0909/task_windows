import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:task_windows/common/TColors.dart';
import 'package:task_windows/common/TaskModel.dart';
import 'package:task_windows/pages/task_page/modify_task_info/modify_task_info_view.dart';
import 'package:task_windows/pages/task_page/taskContent/task_info.dart';
import 'package:task_windows/pages/task_page/task_page_logic.dart';

class DetailType extends StatelessWidget {

  String title;
  Color color;
  List<Task> taskInfo;
  List<Map<int, bool>> checkValue;
  ScrollController scrollController;
  DetailType(this.title,this.color,this.taskInfo,this.checkValue,this.scrollController);

  @override
  Widget build(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: new ScrollController(),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 10,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(color: color),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(title),
                  Spacer(),
                  Tooltip(
                    message:Get.find<TaskPageLogic>().state.sortValue.value?
                    "按照创造时间降序显示任务":
                    "按照创造时间升序显示任务",
                    child: InkWell(
                      onTap: (){
                        print("排序");
                        Get.find<TaskPageLogic>().sort();
                      },
                      child:
                      Get.find<TaskPageLogic>().state.sortValue.value?
                      Image.asset("assets/images/Dsort.png",width: 16,):
                      Image.asset("assets/images/Asort.png",width: 16,),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Tooltip(
                    message:"返回上一页",
                    child: InkWell(
                      onTap: (){
                        // Navigator.pop(context);
                        print("返回首页");
                        /*修改RxInt的值*/
                        Get.find<TaskPageLogic>().state.showPage.value=0;
                        // Get.back();
                      },
                      child: Icon(Icons.keyboard_backspace,size: 15,),
                    ),
                  ),
                  SizedBox(width: 10,)
                ],
              ),
              Divider(thickness: 0.4, color: Colors.grey,),
              TaskInfo(taskInfo,checkValue,scrollController,height:390)
            ],
          ),
        )
    );
  }
}
