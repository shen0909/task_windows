import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputFied extends StatelessWidget {

  /*final是Dart中的一个关键字，用于声明一个只能被赋值一次的变量。使用final关键字声明的变量必须在声明时或构造函数中初始化，并且不能再次被赋值。这样可以确保变量的值不会在后续的代码中被意外地更改。*/
  final double fieldwidth;
  final double fieldHeight;
  final double textwidth;
  final double textHeight;
  final String title;
  final String hintText;
  final bool readonly;
  final TextEditingController? controller;
  final Widget? iconWidget;
  //回调函数
  InputFied(
      {
        this.fieldwidth=80,
        this.fieldHeight=25,
        this.textHeight=30,
        this.textwidth=70,
        this.title="任务类型:",
        this.readonly=false,
        required this.hintText,
        this.controller,
        this.iconWidget,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            width: textwidth,
            height: textHeight,
            // color: Colors.greenAccent,
            alignment: Alignment.centerLeft,
            child: Text(title),
          ),
          Container(
            width: fieldwidth,
            height: fieldHeight,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // border: Border.all(width: 0.4,color: Colors.black)
            ),
            child: TextFormField(
              readOnly: readonly,
              cursorColor: Colors.black,
              controller: controller,
              style: TextStyle(fontSize: 13),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 10,left: 10),
                suffixIcon:iconWidget,
                hintText: hintText,
                hintStyle: TextStyle(fontSize:13,color: readonly?Colors.black:Colors.grey,),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        width: 0,
                        color: Colors.grey
                    )
                ),
                focusedBorder: readonly?
                OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        width: 0,
                        color: Colors.blue
                    )
                ):
                OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        width: 0,
                        color: Colors.yellow
                    )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
