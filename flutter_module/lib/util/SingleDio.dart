import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_module/common/Constant.dart';
import 'package:flutter_module/bean/BaseDataBean.dart';

class SingleDio {
  Dio _dio;
  static final SingleDio _instance = SingleDio._internal();

  factory SingleDio() {
    return _instance;
  }

  SingleDio._internal();

  get getDio {
    if (_dio != null) {
      return _dio;
    }
    Options options = new Options(
      baseUrl: Constant.baseUrl,
      connectTimeout: 15000,
      receiveTimeout: 5000,
    );
    _dio = new Dio(options);
    return _dio;
  }

//    Future<dynamic> _analyzing(Response response, {dynamic targetBean}) async {
//        print('response: ${response.data}');
//        JsonDecoder decoder = new JsonDecoder();
//        Map map = decoder.convert(response.data);
//        print('map: $map');
//        dynamic baseBean = targetBean ?? new BaseDataBean();
//        baseBean.convert(map);
//
//        print('baseBean: $baseBean');
//
//        if (baseBean.code == 0) {
////      print('successful');
//            return baseBean.data;
//        } else {
//            throw baseBean.detail ?? '数据获取失败';
//        }
//    }
//
//    Future<dynamic> get _get(String path, {dynamic data, dynamic targetBean}) async {
////    print('fetch: get=$path, data=$data');
//        return await _analyzing(await _dio.get(path, data: data),targetBean: targetBean);
//    }
//
//    Future<dynamic> get _post(String path, {dynamic data, dynamic targetBean}) async {
////    print('fetch: post=$path, data=$data');
//        return await _analyzing(await _dio.post(path, data: data),targetBean: targetBean);
//    }

}
