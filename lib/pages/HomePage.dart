import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_windows/common/TColors.dart';
import 'package:task_windows/pages/sidePage/all_task/all_task_view.dart';
import 'package:task_windows/pages/sidePage/delete_task/delete_task_view.dart';
import 'package:task_windows/pages/task_page/add_task/add_task_view.dart';
import 'package:task_windows/pages/task_page/task_page_view.dart';
import 'package:task_windows/widget/confirm.dart';
import 'package:window_manager/window_manager.dart';

class HYHomePage extends StatelessWidget {
  //获取日期
  DateTime dateTime = DateTime.now();

  HYHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MoveWindow(
      child: Scaffold(
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
                      style: const TextStyle(fontSize: 24),
                    ),
                    const Text(
                      "Today",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const Spacer(),
                MinimizeWindowButton(
                  colors: WindowButtonColors(
                      iconNormal: Colors.black,
                      mouseOver: Colors.grey[100],
                      mouseDown: Colors.grey[200],
                      iconMouseOver: Colors.black),
                ),
                MaximizeWindowButton(
                  colors: WindowButtonColors(
                      iconNormal: Colors.black,
                      mouseOver: Colors.grey[200],
                      mouseDown: Colors.grey[200],
                      iconMouseOver: Colors.black),
                ),
                CloseWindowButton(
                  colors: WindowButtonColors(
                    iconNormal: Colors.black,
                    mouseOver: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: WindowBorder(color: Colors.grey[400]!, child: const TaskPagePage()),
        drawer: Drawer(
          width: 100,
          child: ListView(
            children: [
              SizedBox(
                height: 55,
                child: DrawerHeader(
                    decoration: const BoxDecoration(
                        color: Tcolor.barBackgroudColor),
                    margin: const EdgeInsets.all(0.0),
                    // padding: EdgeInsets.only(left: 5),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "菜单栏",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ))),
              ),
              ListTile(
                hoverColor: Colors.transparent,
                // 内容的边距
                contentPadding: const EdgeInsets.all(1),
                title: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.4)),
                  ),
                  child: const Text("本周任务"),
                ),
                onTap: () {
                  // print("返回主页");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                hoverColor: Colors.transparent,
                // 内容的边距
                contentPadding: const EdgeInsets.all(1),
                title: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.4)),
                  ),
                  child: const Text("本月任务"),
                ),
                onTap: () {
                  // print("返回主页");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                hoverColor: Colors.transparent,
                // 内容的边距
                contentPadding: const EdgeInsets.all(1),
                title: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.4)),
                  ),
                  child: const Text("年度任务"),
                ),
                onTap: () {
                  // print("返回主页");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                hoverColor: Colors.transparent,
                // 内容的边距
                contentPadding: const EdgeInsets.all(1),
                title: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.4)),
                  ),
                  child: const Text("全部任务"),
                ),
                onTap: () {
                  // print("查看全部任务");
                  Get.to(() => AllTaskPage());
                },
              ),
              ListTile(
                hoverColor: Colors.transparent,
                // 内容的边距
                contentPadding: const EdgeInsets.all(1),
                title: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.4)),
                  ),
                  child: const Text("已删除任务"),
                ),
                onTap: () {
                  // print("查看已删除任务");
                  Get.to(() => const DeleteTaskPage());
                },
              ),
              ListTile(
                hoverColor: Colors.transparent,
                // 内容的边距
                contentPadding: const EdgeInsets.all(1),
                title: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 0.4)),
                  ),
                  child: const Text(
                    "关闭程序",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                onTap: () {
                  // print("关闭程序");
                  Get.dialog(Confirm("确认退出？", () {
                    windowManager.close();
                  }));
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
              onPressed: () {
                Get.to(() => AddTaskPage());
              },
              elevation: 0,
              child: const Icon(
                Icons.add,
                size: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}