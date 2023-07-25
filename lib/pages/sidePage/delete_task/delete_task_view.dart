import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_windows/widget/page_top_bar.dart';

import 'delete_task_logic.dart';

class DeleteTaskPage extends StatelessWidget {
  const DeleteTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(DeleteTaskLogic());
    final state = Get.find<DeleteTaskLogic>().state;

    return Scaffold(
      appBar: PageTopBar(
        title: '已删除任务',
      ),
      body: GetBuilder<DeleteTaskLogic>(
        builder: (logic){
          return Container(
            child: ListView.builder(
              itemCount: state.deleteTask.length,
                itemBuilder: (context,index){
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black87,width: 0.4))
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 10),
                    height: 40,
                    child: Text(
                      state.deleteTask[index].content.toString(),
                      style: TextStyle(color:Colors.grey,fontStyle: FontStyle.italic),),
                  );
                }),
          );
        },
      ),
    );
  }
}
