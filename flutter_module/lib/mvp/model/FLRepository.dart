import 'dart:async';
import 'package:flutter_module/bean/FLModel.dart';

abstract class FLRepository {
  Future<List<FLModel>> fetch(int pageNum, int pageSize);
}
