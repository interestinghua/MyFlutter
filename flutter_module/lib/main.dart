import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_module/page/HomePage.dart';
import 'package:flutter_module/page/DashboardPage.dart';
import 'package:flutter_module/page/NotificationPage.dart';
import 'package:flutter_module/page/ListDemoPage.dart';

//window.defaultRouteName
void main() => runApp(new MyApp("app/notification"));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String route;

  MyApp(this.route);

  @override
  Widget build(BuildContext context) {
    switch (route) {
      case "app/home":
        return new MaterialApp(
          home: new HomePage(),
        );
        break;
      case "app/dashboard":
        return new MaterialApp(
          home: new DashboardPage(),
        );
        break;
      case "app/notification":
        return new MaterialApp(
//          home: new NotificationPage(),
          home: new ListDemoPage(),
        );
        break;
      default:
        return Center(
          child:
              Text('Unknown route: $route', textDirection: TextDirection.ltr),
        );
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
