
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/cellLink.widget.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:date_utils/date_utils.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {

  DateTime _dateTime;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {

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
                Utils.apiDayFormat(_dateTime),
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
          _widgetCalendarSection(),
        ],
      ),
    );
  }

  // 日历
  Widget _widgetCalendarSection () {
    int _millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
    return new Container(
      child: new WowCalendar(
        isExpandable: true,
        onSelectedRangeChange: (x) {
          print('onSelectedRangeChange=>$x');
        },
        onDateSelected: (d) => setState(() => _dateTime = d),
        dayBuilder: (BuildContext context, DateTime day, bool isSelected) {
          return new Container(
            child: new Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: new BoxDecoration(
                    color: isSelected ? Application.config.style.mainColor :  _millisecondsSinceEpoch < day.millisecondsSinceEpoch ? Colors.transparent : Color(0xffdddddd) ,
                    borderRadius: new BorderRadius.all(new Radius.circular(40.0)),
                  ),
                ),
                new Text(
                  day?.day?.toString()??'',
                  style: new TextStyle(
                    color: isSelected ? Colors.white :  _millisecondsSinceEpoch < day.millisecondsSinceEpoch ? Color(0xff999999) : Colors.white
                  ),
                )
              ],
            ),
          );
        },
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
