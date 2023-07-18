import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_windows/common/TColors.dart';

class PageTopBar extends StatelessWidget implements PreferredSizeWidget {

  double toolbarHeight;
  double elevation;
  Color backgroundColor;
  String title;


  PageTopBar({
    this.toolbarHeight=40,
    this.elevation=0,
    this.backgroundColor=Tcolor.barBackgroudColor,
    required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: InkWell(
        onTap: ()=>Navigator.pop(context),
        child: Icon(Icons.keyboard_backspace_rounded,size: 20,),
        ),
      actions: [
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
      leadingWidth: 30,
      title: Text(title),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
