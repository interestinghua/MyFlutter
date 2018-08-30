import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/widget/ProgressDialog.dart';
import 'package:flutter_module/bean/FLModel.dart';
import 'package:flutter_module/mvp/presenter/FLPresenter.dart';
import 'package:flutter_module/mvp/presenter/FLPresenterImpl.dart';
import 'package:flutter_module/common/widget/MultiTouchPage.dart';
import 'package:flutter_module/mvp/view/FLView.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListDemoPage extends StatefulWidget {
  ListDemoPage({Key key}) : super(key: key);

  @override
  _ListDemoPageState createState() {
    _ListDemoPageState view = new _ListDemoPageState();
    FLPresenter presenter = new FLPresenterImpl(view);
    presenter.init(); //初始化数据请求
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

  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  TextStyle subtitleStyle =
      new TextStyle(color: const Color(0xFFB5BDC0), fontSize: 12.0);

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

  Widget buildCard(BuildContext context, int index) {
    FLModel flModel = datas[index];
    String item = flModel.url;
    String id = flModel.createdAt;
    String desc = flModel.desc;

    var idRow = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text("时间: " + id, style: titleTextStyle),
        )
      ],
    );

    var descRow = new Row(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: new Text(
            '内容描述: ' + desc,
            style: subtitleStyle,
          ),
        ),
      ],
    );

    var thumbImgUrl = flModel.images[0];
    var thumbImg = new Container(
      margin: const EdgeInsets.all(10.0),
      width: 60.0,
      height: 60.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFECECEC),
        image: new DecorationImage(
            image: new ExactAssetImage('./images/img_load_fail.png'),
            fit: BoxFit.cover),
        border: new Border.all(
          color: const Color(0xFFECECEC),
          width: 2.0,
        ),
      ),
    );
    if (thumbImgUrl != null && thumbImgUrl.length > 0) {
      thumbImg = new Container(
        margin: const EdgeInsets.all(10.0),
        width: 60.0,
        height: 60.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFECECEC),
          image: new DecorationImage(
              image: new NetworkImage(thumbImgUrl), fit: BoxFit.cover),
          border: new Border.all(
            color: const Color(0xFFECECEC),
            width: 2.0,
          ),
        ),
      );
    }

    var row = new Row(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(6.0),
          child: new Container(
            width: 100.0,
            height: 80.0,
            color: const Color(0xFFECECEC),
            child: new Center(
              child: thumbImg,
            ),
          ),
        ),
        new Expanded(
          flex: 1,
          child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                idRow,
                new Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                  child: descRow,
                )
              ],
            ),
          ),
        )
      ],
    );

    void _goPhotoView(String url) {
      Navigator.of(context).push(new PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return new MultiTouchPage(url);
          },
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return new FadeTransition(
              opacity: animation,
              child: new RotationTransition(
                turns:
                    new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                child: child,
              ),
            );
          }));
    }

//    return new GestureDetector(
//      onTap: () {
//        //这里可以写点击跳转的逻辑
//        _goPhotoView();
//      },
//      child: row,
//    );

    return new InkWell(
      child: row,
      onTap: () {
        /*Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => new NewsDetailPage(id: itemData['detailUrl'])
        ));*/
      },
    );
  }

  @override
  void onloadFLFail(error) {
//    Scaffold.of(context).showSnackBar(new SnackBar(
//      content: new Text("Sending Message"),
//    ));

    Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        bgcolor: "#e74c3c",
        textcolor: '#ffffff');
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
