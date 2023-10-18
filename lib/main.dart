import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_windows/common/TColors.dart';
import 'package:task_windows/router/router.dart';
import 'package:window_manager/window_manager.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 必须加上这一行。
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
      size: Size(400, 655),
      center: false,
      backgroundColor: Colors.transparent,
      alwaysOnTop: true,
      title: "Task-ToDo",
      fullScreen: false,
      // maximumSize: Size(500, 685),
      // minimumSize: Size(300, 315),
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden);
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  /*初始化数据库*/
  // await DBHelper.getInstance().initDB();
  // await DBHelper.getInstance().addColumn();
  runApp(MyApp());

  doWhenWindowReady(() {
    const initialSize = Size(400, 655);
    appWindow.minSize = initialSize;
    // appWindow.maxSize=Size(500, 685);
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.topRight;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      initialRoute:Routerss.login ,
      // getPages: Routerss.pages,
      onGenerateRoute: Routerss.onGenerateRoute,
      // home: HYHomePage(),
      theme: ThemeData(
          //默认字体
          fontFamily: "notoSancsSC",
          appBarTheme: const AppBarTheme(color: Tcolor.SelectedColor, toolbarHeight: 55)),
    );
  }
}
