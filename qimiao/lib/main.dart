
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qimiao/redux/app.redux.dart';
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


  // 创建Store 引用appState 中的 appReducer 创建的 Reducer
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(

    ),
  );

  MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new ScopedModel<StateModel>(
      model: new StateModel(),
      child: MaterialApp(
        title: 'WoosaiMall',
        theme: ThemeData(
          primaryColor: Application.config.style.mainColor,
//          primarySwatch: MaterialColor(),
        ),
        routes: Application.router.routes,
      ),
    );
  }
}
