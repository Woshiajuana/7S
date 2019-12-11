
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/model/model.dart';
import 'package:qimiao/widget/widget.dart';

class NoticeView extends StatefulWidget {
  @override
  _NoticeViewState createState() => _NoticeViewState();
}

class _NoticeViewState extends State<NoticeView> {

  ScrollController _scrollController;
  ListJsonMode _listJsonMode;
  List<NoticeJsonModel> _arrData;
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
        _loadingMore();
      }
    });
    this._reqNoticeList();
  }

  @override
  Widget build(BuildContext context) {
    int len = _arrData?.length ?? 0;
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
      body: new WowLoadView(
        data: _arrData,
        child: new RefreshIndicator(
          onRefresh: _handleRefresh,
          child: new ListView.builder(
            physics: new AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: _isLoading ? len + 1 : len,
            itemBuilder: (context, index) {
              return _getRow(context, index);
            },
          ),
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
    int numTotal = _listJsonMode?.total ?? 0;
    int len = _arrData?.length ?? 0;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            numTotal == len ? new Container() : SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                numTotal == len ? '加载完毕' : '加载中...',
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
        onPressed: () => Application.router.push(context, 'noticeDetails', params: { 'title': noticeJsonModel.title ?? '' }),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  noticeJsonModel.created_at ?? '',
                  style: new TextStyle(
                    color: Color(0xff999999),
                    fontSize: 12.0,
                  ),
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
  Future<void> _handleRefresh() async {
    _numIndex = 1;
    await this._reqNoticeList();
  }

  // 下拉加载
  void _loadingMore () async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      int numTotal = _listJsonMode?.total ?? 0;
      int len = _arrData?.length ?? 0;
      if (numTotal == len) return null;
      _numIndex++;
      this._reqNoticeList();
    }
  }

  void _reqNoticeList () async {
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
        _isLoading = false;
      }
    });
  }

}
