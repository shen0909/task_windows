//退出确认
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_windows/common/TColors.dart';
import 'package:window_manager/window_manager.dart';

class ExitConfirm extends StatelessWidget {
  const ExitConfirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _top(context),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(top: 10),
                  child: Text("确认退出？"),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Tcolor.barBackgroudColor)
                      ),
                      child: Text("取消")),
                  SizedBox(width: 20,),
                  ElevatedButton(
                      onPressed: (){
                        windowManager.close();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Tcolor.barBackgroudColor)
                      ),
                      child: Text("确认")),
                ],
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
  Widget _top(context){
    return Container(
      height: 38,
      color: Tcolor.barBackgroudColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("确认退出"),
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
}
