import 'package:get/get.dart';
import 'login_state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  void login(context){
    print("login");
    state.userNode.requestFocus();
    if(state.userNode.hasFocus){
      state.usercontroller.text="下面获取到焦点了";
      state.emailNode.requestFocus();
      // state.userNode.nextFocus();
      print("下面获取到焦点了");
    }
    update();
    // Navigator.pushNamed(context, Routerss.main);
    Get.toNamed("/main");
    // Get.to(() => AddTaskPage());
  }
}
