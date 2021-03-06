import 'package:flutter_module/mvp/presenter/FLPresenter.dart';
import 'package:flutter_module/mvp/model/FLRepositoryImpl.dart';
import 'package:flutter_module/mvp/model/FLRepository.dart';
import 'package:flutter_module/mvp/view/FLView.dart';

class FLPresenterImpl implements FLPresenter {
  FLView _view; //view
  FLRepository _repository; //model

  FLPresenterImpl(this._view) {
    _view.setPresenter(this);
  }

  void loadFLData(int pageNum, int pageSize) {
//    assert(_view != null);

    _repository.fetch(pageNum, pageSize).then((data) {
      _view.onloadFLSuccess(data);
    }).catchError((error) {
      print(error.toString());
      _view.onloadFLFail(error.toString());
    });
  }

  @override
  init() {
    _repository = new FLRepositoryImpl();
  }
}
