
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/model/state/state.model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({Key key}) : super(key: key);

  final stateModel = new StateModel();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new ScopedModel<StateModel>(
      model: stateModel,
      child: new MaterialApp(
        title: '7S',
        theme: new ThemeData(
          primaryColor: Application.config.style.mainColor,
          primarySwatch:  Application.config.style.primarySwatch,
        ),
        routes: Application.router.routes,
      ),
    );
  }
}
