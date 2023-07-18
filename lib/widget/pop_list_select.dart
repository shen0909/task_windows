import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopListSelect extends StatelessWidget {

  final List<String> infoList;
  List<Color> infoColor=[Colors.redAccent,Colors.lightBlueAccent,Colors.greenAccent];
  final Function indexBlock; //回调函数
  late bool hasColor;

  PopListSelect({
    required this.infoList,
    this.hasColor=false,
    required this.indexBlock});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListView.builder(
        itemCount: infoList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              indexBlock(index);
            },
            child: Container(
              height: 30,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black45,width: 0.4))),
              child: Row(
                children: [
                  hasColor?
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Container(
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                            color: infoColor[index],
                          ),
                        ),
                      )
                    ],
                  ) :
                  Container(),
                  SizedBox(width: 20,),
                  Text(infoList[index],style: TextStyle(fontSize: 13,fontWeight:FontWeight.normal,color: Colors.black,decoration: TextDecoration.none),),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
