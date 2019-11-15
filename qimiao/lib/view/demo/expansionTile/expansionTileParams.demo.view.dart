
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class ExpansionTileParams extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        title: new Text(
          'ExpansionTileParams',
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          _widgetTileItem(),
          _widgetTileItem(),
          _widgetTileItem(),
          _widgetTileItem(),
          _widgetTileItem(),
        ],
      ),
    );
  }

  Widget _widgetTileItem () {
    return new Container(
      color: Colors.white,
      child: new ExpansionTile(
        // 最前面的 widget
//        leading: new Icon(Icons.phone_android),
        // 替换默认箭头
//        trailing: Icon(Icons.phone_iphone),
        title: new Text('Parent'),
        // 默认是否展开
        initiallyExpanded: false,
        // 展开时候的背景色
        backgroundColor: Colors.white,
        // 展开或者收缩的回调，true 表示展开
        onExpansionChanged: (expanded) => print('ExpansionTile is ${expanded ? 'expanded' : 'collapsed'}'),
        children: List.generate(10, (position) =>
          new Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: new Text('Children ${position + 1}'),
            height: 50.0,
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
    );
  }
}
