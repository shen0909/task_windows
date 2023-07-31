//封装网络工具类
import 'package:dio/dio.dart';

class HttpManager{
  //私有实例
  static HttpManager? _instance;

  //声明一个dio实例
  Dio? _dio;

  //初始化HttpManager对象
  HttpManager._internal(){
    //初始化dio实例
    if(_dio == null){
      _dio=new Dio(
          new BaseOptions()
      );
    }
  }
  //获取实例
  static HttpManager getInstance(){
    if(_instance == null){
      _instance=HttpManager._internal();
    }
    return _instance!;
  }
}