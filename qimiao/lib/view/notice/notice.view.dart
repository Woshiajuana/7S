
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/model/model.dart';

class NoticeView extends StatefulWidget {
  @override
  _NoticeViewState createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {

  ScrollController _scrollController;
  List<NoticeJsonModel> _arrData = [];
  bool _isLoading = false;
  int _numIndex = 1;
  int _numSize = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      var position = _scrollController.position;
      // 小于50px时，触发上拉加载；
      if (position.maxScrollExtent - position.pixels < 50) {
//        _loadMore();
      }
    });
    this._reqNoticeList();
  }

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
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _arrData.length == 0 ? 0 : _isLoading ? _arrData.length + 1 : _arrData.length,
          itemBuilder: (context, index) {
            return _getRow(context, index);
          },
        ),
      ),
    );
  }

  // 获取列
  Widget _getRow(BuildContext context, int index) {
    if (index < _arrData.length) {
      return _widgetNoticeItem(noticeJsonModel: _arrData[index]);
    }
    return _getMoreWidget();
  }

  // 加载
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                '加载中...',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 消息
  Widget _widgetNoticeItem ({
    NoticeJsonModel noticeJsonModel,
  }) {
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

  void _reqNoticeList () async {
    try {
      Future.delayed(Duration(milliseconds: 0)).then((e) async{
        String strUrl = Application.config.api.reqNoticeList;
        Map mapParams = { 'numIndex': _numIndex, 'numSize': _numSize, 'nature': 'PRIVATE' };
        ListJsonMode listJsonMode = ListJsonMode.fromJson(await Application.util.http.post(strUrl, params: mapParams, useLoading: false));
        setState(() {
          _arrData = listJsonMode.list;
        });
      });
    } catch (err) {
      Application.util.modal.toast(err);
    }
  }

}
