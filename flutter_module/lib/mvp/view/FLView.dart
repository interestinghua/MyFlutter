import 'package:flutter_module/bean/FLModel.dart';
import 'package:flutter_module/mvp/base/IView.dart';
import 'package:flutter_module/mvp/presenter/FLPresenter.dart';

abstract class FLView implements IView<FLPresenter> {
  void onloadFLSuccess(List<FLModel> list);

  void onloadFLFail(String error);
}
