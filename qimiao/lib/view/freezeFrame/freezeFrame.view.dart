
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:date_utils/date_utils.dart';

class FreezeFrameView extends StatefulWidget {
  @override
  _FreezeFrameViewState createState() => _FreezeFrameViewState();
}

class _FreezeFrameViewState extends State<FreezeFrameView> {

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
        title: new Text(
          '定格',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.help, color: Colors.white),
            onPressed: () => _handleHelp(),
          )
        ],
      ),
      body: new ListView(
        children: <Widget>[
          // 日历
          _widgetCalendarSection(),
          // 标题
          _widgetTitleSection(),
          // 视频
          _widgetVideoSection(),
          // 照片
          _widgetPhotoSection(),
        ],
      ),
    );
  }


  // 标题
  Widget _widgetTitleSection () {
    return new Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            Utils.apiDayFormat(_dateTime),
            style: new TextStyle(
              fontSize: 18.0,
              color: Color(0xff333333),
            ),
          ),
          new SizedBox(height: 5.0),
          new Text(
            '您今日已拍摄一段视频，一张照片了哦...',
            style: new TextStyle(
              fontSize: 12.0,
              color: Color(0xff999999),
            ),
          ),
        ],
      ),
    );
  }

  // 视频
  Widget _widgetVideoSection () {
    return new Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
      height: 160.0,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
        boxShadow: [
          new BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0.0, 1.0), //阴影xy轴偏移量
          ),
        ],
      ),
      child: new Stack(
        children: <Widget>[
          new Container(
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: new Image.asset(
                Application.util.getImgPath('guide1.png'),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          new Container(
            width: double.infinity,
            height: double.infinity,
            decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, .2),
              borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
            ),
            child: new FlatButton(
              onPressed: () => {},
              child: new Icon(Icons.add, size: 40.0, color: Colors.white)
            ),
          ),
          new Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: new Container(
              height: 60.0,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000),
                    Color(0x90000000),
                  ],
                ),
              ),
            ),
          ),
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 6.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.live_tv, size: 14.0, color: Color(0xffdddddd)),
                        new SizedBox(width: 2.0),
                        new Text(
                          '100',
                          style: new TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.thumb_up, size: 14.0, color: Color(0xffdddddd)),
                        new SizedBox(width: 2.0),
                        new Text(
                          '100',
                          style: new TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    new Container(
                      height: 20.0,
                      width: 20.0,
                      child: new FlatButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () => _handleOperate(),
                        child: new Icon(Icons.more_vert, size: 18.0, color: Color(0xffdddddd))
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // 操作
  void _handleOperate () {
    showDialog(
      context: context,
      barrierDismissible: true,//是否点击空白区域关闭对话框,默认为true，可以关闭
      builder: (BuildContext context) {
        return new ActionSheetDialog(
          arrOptions: [
            {
              'text': '分享',
              'onPressed': () {
                print('相册1');
              },
            },
            {
              'text': '举报',
              'onPressed': () => print('拍照'),
            },
            {
              'text': '编辑',
              'onPressed': () {
                Navigator.of(context).pop();
                Application.router.push(context, 'freezeFrameDetails');
              },
            },
          ],
        );
      },
    );
  }

  // 照片
  Widget _widgetPhotoSection () {
    return new Container(
      margin: const EdgeInsets.all(16.0),
      height: 160.0,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
        boxShadow: [
          new BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0.0, 1.0), //阴影xy轴偏移量
          ),
        ],
      ),
      child: new Stack(
        children: <Widget>[
          new Container(
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: new Image.asset(
                Application.util.getImgPath('guide1.png'),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          new Container(
            width: double.infinity,
            height: double.infinity,
            decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, .2),
              borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
            ),
            child: new FlatButton(
                onPressed: () => {},
                child: new Icon(Icons.add, size: 40.0, color: Colors.white)
            ),
          ),
          new Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: new Container(
              height: 60.0,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000),
                    Color(0x90000000),
                  ],
                ),
              ),
            ),
          ),
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 6.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.live_tv, size: 14.0, color: Color(0xffdddddd)),
                        new SizedBox(width: 2.0),
                        new Text(
                          '100',
                          style: new TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.thumb_up, size: 14.0, color: Color(0xffdddddd)),
                        new SizedBox(width: 2.0),
                        new Text(
                          '100',
                          style: new TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    new Container(
                      height: 20.0,
                      width: 20.0,
                      child: new FlatButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () => _handleOperate(),
                          child: new Icon(Icons.more_vert, size: 18.0, color: Color(0xffdddddd))
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 日历
  Widget _widgetCalendarSection () {
    int _millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
    return new Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            color: Color(0xffdddddd),
            width: 0.5,
          ),
        ),
      ),
      child: new WowCalendar(
//        isExpandable: true,
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

  void _handleHelp () {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return new AlertToastDialog(
          content: '视频、图片作品一天只能保存一个哦...',
        );
      },
    );
  }



}
