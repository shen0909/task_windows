//单个任务显示弹窗
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_windows/common/TColors.dart';
import 'package:task_windows/common/TaskModel.dart';
import 'package:task_windows/pages/task_page/modify_task_info/modify_task_info_view.dart';
import 'package:task_windows/pages/task_page/task_page_logic.dart';
import 'package:task_windows/widget/confirm.dart';

class TaskItemInfo extends StatelessWidget {
  Task taskitem;

  TaskItemInfo(this.taskitem);

  @override
  Widget build(BuildContext context) {
    print("任务详情->${taskitem.toJson()}");
    return Center(
      child: Card(
        child: Container(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //标题
              _top(context),
              //内容
              _content(context),
            ],
          ),
        ),
      ),
    );
  }

  //标题
  Widget _top(context){
    return Container(
      height: 38,
      color: Tcolor.barBackgroudColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: Container()),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.close,size: 18,),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _content(context){
    return Container(
      padding: EdgeInsets.only(top: 10,left: 10,),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(flex:3,child: Text("任务类型:")),
              Expanded(flex:8,child: Text(taskitem.ownType.toString())
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(flex:3,child: Text("任务内容:")),
              Expanded(flex:8,child: Text(taskitem.content.toString())
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(flex:3,child: Text("开始日期:")),
              Expanded(flex:8,child: Text(taskitem.startDate.toString())
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(flex:3,child: Text("结束日期:")),
              Expanded(flex:8,child: Text(taskitem.endDate.toString())
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(flex:3,child: Text("创建时间:")),
              Expanded(flex:8,child: Text(taskitem.createTime.toString())
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(flex:3,child: Text("是否完成？")),
              Expanded(flex:8,child: Text(taskitem.isCompleted==0?"未完成":"已完成".toString())
              ),
            ],
          ),
          taskitem.isCompleted==0?Container():
          Column(
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(flex:3,child: Text("完成时间:")),
                  Expanded(flex:8,child: Text(taskitem.completeTime.toString())
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(flex:3,child: Text("优先级    :")),
              Expanded(flex:8,child: Text(taskitem.priority.toString())
              ),
            ],
          ),
          SizedBox(height: 20,),
          //修改-删除按钮
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: (){
                    print("删除任务");
                    Get.dialog(Confirm(
                        "确认删除",
                        (){
                          Get.find<TaskPageLogic>().onLonpressDelete(taskitem);
                          //返回上一层
                          // Navigator.pop(context);
                          //关闭所有弹窗
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        }));
                    // Get.defaultDialog();
                  },
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Tcolor.barBackgroudColor)),
                  child: Text("删除")),
              SizedBox(width: 20,),
              ElevatedButton(
                  onPressed: (){
                    print("修改");
                    Get.to(()=>ModifyTaskInfoPage(),arguments: taskitem);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Tcolor.barBackgroudColor)
                  ),
                  child: Text("修改"))
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
  //调整创建时间格式
}
