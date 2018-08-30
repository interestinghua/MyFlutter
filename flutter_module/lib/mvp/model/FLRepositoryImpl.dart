import 'dart:async';
import 'dart:convert';
//import 'dart:mirrors';
import 'dart:io';
import 'package:flutter_module/bean/FLModel.dart';
import 'package:flutter_module/common/Constant.dart';
import 'package:flutter_module/mvp/model/FLRepository.dart';
import 'package:flutter_module/util/SingleDio.dart';
import 'package:dio/dio.dart';

//分类数据: http://gank.io/api/data/数据类型/请求个数/第几页
//数据类型： 福利 | Android | iOS | 休息视频 | 拓展资源 | 前端 | all
//请求个数： 数字，大于0
//第几页：数字，大于0
//@param rows
//@param pageNum
//@return

class FLRepositoryImpl implements FLRepository {
  @override
  Future<List<FLModel>> fetch(int pageNum, int pageSize) {
    return _getData(pageNum, pageSize);
  }
}

Future<List<FLModel>> _getData(int pageNum, int pageSize) async {
  var url = Constant.baseUrl + 'Android/$pageSize/$pageNum';
//  var url = "https://jsonplaceholder.typicode.com/photos";
  SingleDio singleDio = new SingleDio();
  Dio dioClient = singleDio.getDio;

  var flModels;

  Response future = await dioClient.get(url);

  if (future.statusCode == HttpStatus.ok) {
    bool isError = future.data['error'];
    if (!isError) {
      flModels = future.data['results'];
    }
  } else {
    //todo
  }

  var response = flModels.toString().replaceAll('_', '').trim();

  print("response = $response");

  return parseFLModel(response);
}

List<FLModel> parseFLModel(String responseBody) {
//  JsonCodec codec = new JsonCodec();
  var jsonObj = json.decode(responseBody);
  final parsed = jsonObj.cast<Map<String, dynamic>>();
  return parsed.map<FLModel>((json) => FLModel.fromJson(json)).toList();
}
