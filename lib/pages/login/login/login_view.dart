import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_windows/common/TColors.dart';
import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginLogic());
    final state = Get.find<LoginLogic>().state;

    return WindowBorder(
      color: Colors.grey[400]!,
      child: MoveWindow(
        child: Scaffold(
          appBar: _AppBar(),
          body: GetBuilder<LoginLogic>(builder: (logic) {
            return Center(
              child: FocusScope(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: state.usercontroller,
                      focusNode: state.userNode,
                      autofocus: true,
                    ),
                    TextFormField(
                      focusNode: state.emailNode,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          logic.login(context);
                        },
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(220, 40))),
                        child: Text("LOGIN")),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  _AppBar() {
    return AppBar(
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
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  "Today",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            Spacer(),
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
    );
  }
}
