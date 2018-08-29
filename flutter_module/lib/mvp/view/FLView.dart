import 'package:flutter_module/bean/FLModel.dart';
import 'package:flutter_module/mvp/base/IView.dart';

abstract class FLView implements IView {

    void onloadFLSuccess(List<FLModel> list);

    void onloadFLFail();

}