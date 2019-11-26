
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/cellLink.widget.dart';
import 'package:qimiao/widget/widget.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new ListView(
        children: <Widget>[
          _widgetHeaderSection(),
          new CellLinkWidget(
            labelText: 'GetHub',
            onPressed: () => _handleExitOut(),
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

  void _handleExitOut () async {
    var result = await showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return new WillPopScope(
            child: new UpgradeDialog(),
            onWillPop: () async {
              return Future.value(false);
            }
        );
      },
    );
    if (result != true) return;
    try {
//      await Application.util.store.clear();
    } catch (err) {

    } finally {
      Application.router.replace(context, 'login');
    }
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
