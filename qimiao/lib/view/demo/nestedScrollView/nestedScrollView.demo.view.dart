
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/paramsExplain.widget.dart';
import 'package:qimiao/widget/demoLinkList.widget.dart';

class NestedScrollViewDemo extends StatelessWidget{

  NestedScrollViewDemo({
    Key key,
    this.titleText = '',
  }) : super(key: key);

  final String titleText;

  final Map _objData = {
    'demoLinkList': [
      {
        'labelText': '参数示例',
        'routeName': 'nestedScrollViewParams',
      },
    ],
    'paramsExplain': 'const SliverAppBar({\n' +
        '\r\r\r\rKey key,\n' +
        '\r\r\r\rthis.leading,\n' +
        '\r\r\r\rthis.automaticallyImplyLeading = true,\n' +
        '\r\r\r\rthis.title,\n' +
        '\r\r\r\rthis.actions,\n' +
        '\r\r\r\rthis.flexibleSpace, // 通过这个来设置背景\n' +
        '\r\r\r\rthis.bottom,\n' +
        '\r\r\r\rthis.elevation,\n' +
        '\r\r\r\rthis.forceElevated = false, // 是否显示层次感\n' +
        '\r\r\r\rthis.backgroundColor,\n' +
        '\r\r\r\rthis.brightness,\n' +
        '\r\r\r\rthis.iconTheme,\n' +
        '\r\r\r\rthis.textTheme,\n' +
        '\r\r\r\rthis.primary = true,\n' +
        '\r\r\r\rthis.centerTitle,\n' +
        '\r\r\r\rthis.titleSpacing = NavigationToolbar.kMiddleSpacing,\n' +
        '\r\r\r\rthis.expandedHeight, // 展开的高度\n' +
        '\r\r\r\r// 以下三个等例子再讲\n' +
        '\r\r\r\rthis.floating = false,\n' +
        '\r\r\r\rthis.pinned = false,\n' +
        '\r\r\r\rthis.snap = false,\n' +
        '}),',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        title: new Text(
          titleText,
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new DemoLinkListWidget(demoLinkList: _objData['demoLinkList'],),
          new ParamsExplainWidget(paramsExplain: _objData['paramsExplain'],),
        ],
      ),
    );
  }
}
