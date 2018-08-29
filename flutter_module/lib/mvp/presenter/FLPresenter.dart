import 'package:flutter_module/mvp/view/FLView.dart';
import 'package:flutter_module/mvp/base/IPresenter.dart';

abstract class FLPresenter<FLView> implements IPresenter<FLView> {
  loadFLData(int pageNum, int pageSize);
}
