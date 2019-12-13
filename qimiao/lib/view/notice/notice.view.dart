
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/model/model.dart';
import 'package:qimiao/widget/widget.dart';
import "package:intl/intl.dart";
import 'package:date_format/date_format.dart';

class NoticeView extends StatefulWidget {
  @override
  _NoticeViewState createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {

  ListJsonMode _listJsonMode;
  List<NoticeJsonModel> _arrData;
  int _numIndex = 1;
  int _numSize = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._reqNoticeList();
  }

  @override
  Widget build(BuildContext context) {
    print(formatDate(DateTime.now(), [yyyy, "年", mm, "月", dd, ' ', HH, ':', nn, ':', ss]));
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '消息2',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: new WowLoadView(
        data: _arrData,
        child: new WowScrollListView(
          onRefresh: _handleRefresh,
          onLoad: _handleLoad,
          data: _arrData,
          total: _listJsonMode?.total ?? 0,
          itemBuilder: (content, index) {
            return _widgetNoticeItem(noticeJsonModel: _arrData[index]);
          }
        ),
      ),
    );
  }

  // 消息
  Widget _widgetNoticeItem ({
    NoticeJsonModel noticeJsonModel,
  }) {
    String time = noticeJsonModel.created_at != null ? formatDate(DateTime.parse(noticeJsonModel.created_at), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]) : '';
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
        onPressed: () => Application.router.push(context, 'noticeDetails', params: { 'title': noticeJsonModel.title ?? '' }),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Text(
                      time,
                      style: new TextStyle(
                        color: Color(0xff999999),
                        fontSize: 12.0,
                      ),
                    ),
                    new Offstage(
                      offstage: noticeJsonModel?.unread != true,
                      child: new Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
                        decoration: new BoxDecoration(
                          border: new Border.all(
                            color: Colors.red,
                            width: 0.5,
                          ),
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child: new Text(
                          'new',
                          style: new TextStyle(
                            color: Colors.red,
                            fontSize: 8.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new SizedBox(height: 5.0),
                new Text(
                  noticeJsonModel.title ?? '',
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

  // 刷新
  void _handleRefresh() async {
    _numIndex = 1;
    await this._reqNoticeList();
  }

  // 下拉加载
  void _handleLoad ({
    Function callback,
  }) async {
    _numIndex++;
    this._reqNoticeList(callback: callback);
  }

  void _reqNoticeList ({
    Function callback,
  }) async {
    await Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqNoticeList;
        Map mapParams = { 'numIndex': _numIndex, 'numSize': _numSize, 'nature': 'PRIVATE' };
        _listJsonMode = ListJsonMode.fromJson(await Application.util.http.post(strUrl, params: mapParams, useLoading: false));
        setState(() {
          List<NoticeJsonModel> data = _listJsonMode.list.map((item) => NoticeJsonModel.fromJson(item)).toList();
          _numIndex == 1 ? _arrData = data : _arrData.addAll(data);
        });
      } catch (err) {
        Application.util.modal.toast(err);
      } finally {
        if (callback != null) callback();
      }
    });
  }

}
