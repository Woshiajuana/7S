
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


    var c = new WowCalendar();

    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        centerTitle: true,
        title: new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.arrow_back_ios, size: 18.0),
                onPressed: () => {},
              ),
              new Text(
                '2019-10-12',
                style: new TextStyle(
                  fontSize: 18.0,
                ),
              ),
              new IconButton(
                icon: new Icon(Icons.arrow_forward_ios, size: 18.0),
                onPressed: () => {},
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () => {},
          )
        ],
      ),
      body: new ListView(
        children: <Widget>[
          c,
          _widgetCalendarSection(),
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

  // 日历
  Widget _widgetCalendarSection () {
    return new Container(
//        showChevronsToChangeRange: false,
//      isExpandable: true,
//      showCalendarPickerIcon: true,
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
