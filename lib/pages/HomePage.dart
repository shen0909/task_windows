import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:task_windows/common/TColors.dart';
import 'package:task_windows/pages/all_task/all_task/all_task_view.dart';
import 'package:task_windows/pages/sidePage/all_task.dart';
import 'package:task_windows/pages/task_page/add_task/add_task_view.dart';
import 'package:task_windows/pages/task_page/task_page_view.dart';
import 'package:window_manager/window_manager.dart';

class HYHomePage extends StatelessWidget {

  //获取日期
  DateTime dateTime=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Tcolor.barBackgroudColor,
        title: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat.yMMMd().format(DateTime.now()),
                    style: TextStyle(fontSize: 24),),
                  Text("Today",style: TextStyle(fontSize: 14),),
                ],
              ),
              Spacer(),
              MinimizeWindowButton(
                colors:WindowButtonColors(
                    iconNormal: Colors.black,
                    mouseOver: Colors.grey[100],
                    mouseDown: Colors.grey[200],
                    iconMouseOver: Colors.black
                ) ,
              ),
              MaximizeWindowButton(
                colors:WindowButtonColors(
                    iconNormal: Colors.black,
                    mouseOver: Colors.grey[200],
                    mouseDown: Colors.grey[200],
                    iconMouseOver: Colors.black
                ) ,
              ),
              CloseWindowButton(
                colors:WindowButtonColors(
                  iconNormal: Colors.black,
                  mouseOver: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
      body: WindowBorder(
          color: Colors.grey[400]!,
          child: TaskPagePage()),
      drawer: Drawer(
        width: 100,
        child: ListView(
          children: [
            SizedBox(
              height: 30,
              child: DrawerHeader(
                decoration: BoxDecoration(color:Tcolor.barBackgroudColor),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.only(left: 5),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text("菜单栏",style: TextStyle(fontSize: 16,),))),
            ),
            ListTile(
              hoverColor: Colors.transparent,
              // 内容的边距
              contentPadding: EdgeInsets.all(1),
              title: Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black,width: 0.4)),
                ),
                child: Text("本周任务"),
              ),
              onTap: (){
                print("返回主页");
                Navigator.pop(context);
              },
            ),
            ListTile(
              hoverColor: Colors.transparent,
              // 内容的边距
              contentPadding: EdgeInsets.all(1),
              title: Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black,width: 0.4)),
                ),
                child: Text("本月任务"),
              ),
              onTap: (){
                print("返回主页");
                Navigator.pop(context);
              },
            ),
            ListTile(
              hoverColor: Colors.transparent,
              // 内容的边距
              contentPadding: EdgeInsets.all(1),
              title: Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black,width: 0.4)),
                ),
                child: Text("年度任务"),
              ),
              onTap: (){
                print("返回主页");
                Navigator.pop(context);
              },
            ),
            ListTile(
              hoverColor: Colors.transparent,
              // 内容的边距
              contentPadding: EdgeInsets.all(1),
              title: Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black,width: 0.4)),
                ),
                child: Text("全部任务"),
              ),
              onTap: (){
                print("查看全部任务");
                Get.to(()=>AllTaskPage());
              },
            ),
            ListTile(
              hoverColor: Colors.transparent,
              // 内容的边距
              contentPadding: EdgeInsets.all(1),
              title: Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black,width: 0.4)),
                ),
                child: Text("关闭程序",style: TextStyle(color: Colors.redAccent),),
              ),
              onTap: (){
                print("关闭程序");
                windowManager.close();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 40,
        height: 30,
        child: Tooltip(
          message: "点击添加任务",
          child: FloatingActionButton(
            hoverColor: Colors.white12,
            backgroundColor: Tcolor.barBackgroudColor,
            foregroundColor: Colors.white,
            onPressed: (){
              Get.to(()=>AddTaskPage());
            },
            child: Icon(Icons.add,size: 14,),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}