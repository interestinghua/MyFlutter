import 'package:flutter_module/mvp/base/IPresenter.dart';

abstract class FLPresenter implements IPresenter {
  loadFLData(int pageNum, int pageSize);
}
