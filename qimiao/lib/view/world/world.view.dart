
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/cellLink.widget.dart';

class WorldView extends StatefulWidget {
  @override
  _WorldViewState createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new ListView(
        children: <Widget>[
          _widgetHeaderSection(),
          new CellLinkWidget(
            labelText: 'GetHub',
          ),
          new CellLinkWidget(
            labelText: '关于我们',
            onPressed: () => Application.router.push(context, 'about'),
          ),
          new CellLinkWidget(
            labelText: '更新记录',
          ),
        ],
      ),
    );
  }

  Widget _widgetHeaderSection () {
    return new Container(
      margin: const EdgeInsets.only(top: 100.0, bottom: 50.0),
      child: new Column(
        children: <Widget>[
          new Icon(
            Icons.face,
            size: 100,
            color: Application.config.style.mainColor,
          ),
          new Text(
            'WowFlutter v0.0.1',
            style: new TextStyle(
              color: Application.config.style.mainColor,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

}
