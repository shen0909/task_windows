import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//封装一个构造弹窗类
/*OverlayEntry 可以实现悬浮窗效果*/
class PopToastManager{

  /*OverlayEntry类型的私有实例变量*/
  OverlayEntry? _overlayEntry;
  /*PopToastManager类型的私有实例变量*/
  static PopToastManager? _manager;
  /*PopToastManager的私有构造函数，用于创建新实例*/
  PopToastManager._();
  /*PopToastManager的工厂构造函数，用于创建类的实例，并保证只创建一个实例*/
  factory PopToastManager(){
    if(_manager==null){
      _manager=PopToastManager._();
    }
    return _manager!;
  }

  /*在buildUI()函数内部创建overlayEntry对象并且插入到overlayEntry中*/
  void buildUI(
      {
        required BuildContext context,
        required bool isClickDiss,
        required double X,
        required double Y,
        required double offx,
        required double offy,
        required double width,
        required double height,
        required Widget childWidget,
        Function? dismissCallBack/*取消的回调函数*/
      }){
    if(context==null){
      print("context为空");
    }
    else{
      print("context不为空");
    }
    //创建 overlayEntry
    OverlayEntry overlayEntry=OverlayEntry(

        builder: (context){
          print("开始构建overlayEntry");
          return GestureDetector(
            behavior:HitTestBehavior.opaque ,
            /*点击事件*/
            onTap: (){
              /*如果可以点击*/
              if(isClickDiss){
                /*取消回调函数不为空则调用取消回调函数*/
                if (dismissCallBack != null) {
                  dismissCallBack();
                }
                /*蒙层取消函数*/
                dissmiss();
              }
            },
            /*子组件*/
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(height: Y,),
                  SizedBox(height: Y,),
                  Container(
                    margin: EdgeInsets.fromLTRB(offx + X,offy, 0, 0),
                    width: width,
                    height: height,
                    child: childWidget,
                  ),
                ],
              ),
            ),
          );
        });
    this._overlayEntry = overlayEntry;

    //插入到 Overlay中显示 OverlayEntry
    // Overlay.of(context)!.insert(overlayEntry);

    final overlay = Overlay.of(context);
    if (overlay != null) {
      overlay.insert(overlayEntry);
    } else {
      print('Overlay is null');
    }
  }


  void dissmiss(){
    if(this._overlayEntry != null){
      print("蒙层消失");
      this._overlayEntry!.remove();
      this._overlayEntry = null;
    }
  }
}