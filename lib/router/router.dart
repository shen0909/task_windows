import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:task_windows/pages/HomePage.dart';
import 'package:task_windows/pages/login/login/login_view.dart';

class Routerss{
  static const String login="/";
  static const String main="/main";

  // static final
  static RouteFactory onGenerateRoute=(setting){
    if(setting.name=='/'){
      return MaterialPageRoute(builder: (context){return LoginPage();});
    }
    if(setting.name=='/main'){
      return MaterialPageRoute(builder: (context){return HYHomePage();});
    }
  };
  static final List<GetPage> pages=[
    GetPage(name: login, page:()=> const LoginPage()),
    GetPage(name: main, page:()=> HYHomePage()),
  ];
}