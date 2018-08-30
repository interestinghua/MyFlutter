import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_module/common/Constant.dart';
import 'package:flutter_module/bean/BaseDataBean.dart';

class Fetch {
  static Dio _dio;
  static final Fetch _instance = Fetch._internal();

  factory Fetch() {
    return _instance;
  }

  Future<Dio> get dio async {
    if (_dio != null) {
      return _dio;
    }

    _dio = await initDio();
    return _dio;
  }

  Fetch._internal();

  Future<Dio> initDio() async {
    Options options = new Options(
      baseUrl: Constant.baseUrl,
      connectTimeout: 15000,
      receiveTimeout: 5000,
    );
    _dio = new Dio(options);
  }

//  Future<dynamic> _analyzing(Response response, {dynamic targetBean}) async {
//    print('response: ${response.data}');
//    JsonDecoder decoder = new JsonDecoder();
//    Map map = decoder.convert(response.data);
//    print('map: $map');
//    dynamic baseBean = targetBean ?? new BaseDataBean();
//    baseBean.convert(map);
//
//    print('baseBean: $baseBean');
//
//    if (baseBean.code == 0) {
////      print('successful');
//      return baseBean.data;
//    } else {
//      throw baseBean.detail ?? '数据获取失败';
//    }
//  }
//
//  Future<dynamic> _get(String path, {dynamic data, dynamic targetBean}) async {
//    print('fetch: get=$path, data=$data');
//    return await _analyzing(await dio.get(path, data: data),
//        targetBean: targetBean);
//  }
//
//  Future<dynamic> _post(String path, {dynamic data, dynamic targetBean}) async {
//    print('fetch: post=$path, data=$data');
//    return await _analyzing(await dio.post(path, data: data),
//        targetBean: targetBean);
//  }
}
