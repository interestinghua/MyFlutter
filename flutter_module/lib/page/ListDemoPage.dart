import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_module/common/widget/ProgressDialog.dart';
import 'package:flutter_module/bean/FLModel.dart';
import 'package:flutter_module/mvp/presenter/FLPresenter.dart';
import 'package:flutter_module/mvp/presenter/FLPresenterImpl.dart';
import 'package:flutter_module/common/widget/MultiTouchPage.dart';
import 'package:flutter_module/mvp/view/FLView.dart';

class ListDemoPage extends StatefulWidget {
  ListDemoPage({Key key}) : super(key: key);

  @override
  _ListDemoPageState createState() {
    _ListDemoPageState view = new _ListDemoPageState();
    FLPresenter presenter = new FLPresenterImpl(view);
    presenter.init();
    return view;
  }
}

class _ListDemoPageState extends State<ListDemoPage> implements FLView {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  ScrollController _scrollController;
  List<FLModel> datas = [];
  FLPresenter _flPresenter;
  int curPageNum = 1;
  bool isSlideUp = false;

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadData();
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
    _scrollController = new ScrollController()..addListener(_scrollListener);
    print("girl");
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrollListener);
  }

  Future<Null> _refreshData() {
    isSlideUp = false;
    final Completer<Null> completer = new Completer<Null>();
    curPageNum = 1;
    _flPresenter.loadFLData(curPageNum, 10);
    //同步方法不更新页面
    setState(() {});
    completer.complete(null);
    return completer.future;
  }

  Future<Null> _loadData() {
    isSlideUp = true;
    final Completer<Null> completer = new Completer<Null>();
    curPageNum = curPageNum + 1;
    _flPresenter.loadFLData(curPageNum, 10);
    //同步方法不更新页面
    setState(() {});
    completer.complete(null);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    var content;

    if (datas.isEmpty) {
      content = getProgressDialog();
    } else {
      content = new ListView.builder(
        //设置physics属性总是可滚动
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: datas.length,
        itemBuilder: buildCard,
      );
    }

    var _refreshIndicator = new RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshData,
      child: content,
    );

    return _refreshIndicator;
  }

  void _goPhotoView(String url) {
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return new MultiTouchPage(url);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: new RotationTransition(
              turns: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }));
  }

  Widget buildCard(BuildContext context, int index) {
    final String item = datas[index].url;
    return new GestureDetector(
      onTap: () {
        _goPhotoView(item);
      },
      child: new Card(
        child: new Image.network(item),
      ),
    );
  }

  @override
  void onloadFLFail() {
		Scaffold.of(context).showSnackBar(new SnackBar(
			content: new Text("Sending Message"),
		));

//    Fluttertoast.showToast(
//        msg: "This is Center Short Toast",
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.CENTER,
//        timeInSecForIos: 1,
//        bgcolor: "#e74c3c",
//        textcolor: '#ffffff');
  }

  @override
  void onloadFLSuccess(List<FLModel> list) {
    if (!mounted) {
      return; //异步处理，防止报错
    }

    setState(() {
      if (isSlideUp) {
        datas.addAll(list);
      } else {
        datas = list;
      }
    });
  }

  @override
  setPresenter(FLPresenter presenter) {
    _flPresenter = presenter;
  }
}

class ListLoadMorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListDemoPage(),
    );
  }
}
