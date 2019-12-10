
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/model/model.dart';

class NoticeView extends StatefulWidget {
  @override
  _NoticeViewState createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {

  ScrollController _scrollController = new ScrollController();

  

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '消息',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: new RefreshIndicator(
        onRefresh: _onRefresh,
        child: new ListView(
          children: <Widget>[
            _widgetNoticeItem(),
            _widgetNoticeItem(),
            _widgetNoticeItem(),
            _widgetNoticeItem(),
            _widgetNoticeItem(),
            _widgetNoticeItem(),
          ]
        ),
      ),
    );
  }

  // 消息
  Widget _widgetNoticeItem () {
    return new Container(
      height: 70,
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          bottom: new BorderSide(
            color: Color(0xffdddddd),
            width: 0.5,
          )
        ),
      ),
      child: new FlatButton(
        onPressed: () => Application.router.push(context, 'noticeDetails', params: { 'title': '实名认证' }),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  '2019/09/09 10:10:10',
                  style: new TextStyle(
                    color: Color(0xff999999),
                    fontSize: 12.0,
                  ),
                ),
                new SizedBox(height: 5.0),
                new Text(
                  '实名认证',
                  style: new TextStyle(
                    color: Color(0xff666666),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            new Icon(Icons.arrow_forward_ios, size: 18.0, color: Color(0xff999999)),
          ],
        )
      ),
    );
  }

  Future<void> _onRefresh() async {
    print("RefreshListPage _onRefresh()");
//    await Future.delayed(Duration(seconds: 2), () {
//      _list = List.generate(15, (i) => "我是刷新出的数据${i}");
//      setState(() {});
//    });
  }

}
