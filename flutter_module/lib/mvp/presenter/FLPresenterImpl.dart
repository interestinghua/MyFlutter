import 'package:flutter_module/mvp/presenter/FLPresenter.dart';
import 'package:flutter_module/mvp/model/FLRepository.dart';

class FLPresenterImpl implements FLPresenter<FLView> {

	FLView _view;
	FLRepository _repository;

	FLPresenterImpl(this._view) {
		_view.setPresenter(this);
	}

	@override
	void loadFLData(int pageNum, int pageSize) {
		assert(_view != null);

		_repository.fetch(pageNum, pageSize).then((data) {
			_view.onloadFLSuccess(data);
		}).catchError((error) {
			print(error);
			_view.onloadFLFail();
		});
	}

	@override
	init() {
		_repository = new FLRepositoryImpl();
	}

  @override
  attachView(T) {
    // TODO: implement attachView
  }

  @override
  detachView() {
    // TODO: implement detachView
  }
}
