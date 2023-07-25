import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:task_windows/common/TColors.dart';
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
            child: SlidableAutoCloseBehavior(
              child: ListView.builder(
                itemCount: state.deleteTask.length,
                  itemBuilder: (context,index){
                    return Slidable(
                      key:Key(state.deleteTask[index].id.toString()) ,
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        dismissible: DismissiblePane(onDismissed: (){
                        }),
                        children: [
                          SlidableAction(
                            onPressed: (context){
                              // print("重新加入");
                              logic.recoverTask(state.deleteTask[index]);
                              },
                            backgroundColor: Tcolor.editBackgroudColor,
                            foregroundColor: Tcolor.textColor,
                            icon: Icons.add_task_rounded,
                            label: "恢复",
                            borderRadius: BorderRadius.circular(10),
                          )
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.black87,width: 0.4))
                        ),
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        child: Text(
                          state.deleteTask[index].content.toString(),
                          style: TextStyle(color:Colors.grey,fontStyle: FontStyle.italic),),
                      ),
                    );
                  }),
            ),
          );
        },
      ),
    );
  }
}
