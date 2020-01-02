
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:qimiao/model/model.dart';
import "package:intl/intl.dart";

class CollectListView extends StatefulWidget {
  @override
  _CollectListViewState createState() => _CollectListViewState();
}

class _CollectListViewState extends State<CollectListView> {

  ListJsonModel _listJsonModel;
  List<CollectJsonModel> _arrData;
  int _numIndex = 1;
  int _numSize = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._reqHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '收藏',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.delete_outline),
            onPressed: () => _handleClear(),
          ),
        ],
      ),
      body: new WowLoadView(
        data: _arrData,
        child: new WowScrollListView(
            onRefresh: _handleRefresh,
            onLoad: _handleLoad,
            data: _arrData,
            total: _listJsonModel?.total ?? 0,
            itemBuilder: (content, index) {
              return _widgetPhotoCellItem(index);
            }
        ),
      ),
    );
  }

  // 照片
  Widget _widgetPhotoCellItem (index) {
    CollectJsonModel collectJsonModel = _arrData[index];
    PhotoJsonModel photoJsonModel = collectJsonModel.photo;
    String strTime = collectJsonModel.created_at != null
        ? new DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(collectJsonModel.created_at).toLocal())
        : '';
    FileJsonModel fileJsonModel = photoJsonModel.photo;
    String strPath = '${fileJsonModel.base}${fileJsonModel.path}${fileJsonModel.filename}';
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                bottom: new BorderSide(
                  color: Color(0xffdddddd),
                  width: 0.5,
                ),
              ),
            ),
            child: new FlatButton(
              padding: const EdgeInsets.all(10.0),
              onPressed: () => Application.router.push(context, 'photoDetails', params: { 'id': photoJsonModel.id }),
              child: new Row(
                children: <Widget>[
                  new Container(
                    width: 120.0,
                    height: 77.0,
                    child: new Stack(
                      children: <Widget>[
                        new ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: new CachedNetworkImage(
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: strPath,
                            placeholder: (context, url) => new Image.asset(
                              Application.util.getImgPath('guide1.png'),
                            ),
                            errorWidget: (context, url, error) => new Image.asset(
                              Application.util.getImgPath('guide1.png'),
                            ),
                          ),
                        ),
                        new Container(
                          decoration: new BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            borderRadius: new BorderRadius.circular(6.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new SizedBox(width: 10.0),
                  new Expanded(
                    flex: 1,
                    child: new Container(
                      height: 77.0,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            photoJsonModel.title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Color(0xff333333),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          new Expanded(child: new Container(), flex: 1),
                          new Container(
                            child: new Text(
                              photoJsonModel?.user?.nickname,
                              style: new TextStyle(
                                color: Color(0xff999999),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          new SizedBox(height: 4.0),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  new Icon(Icons.remove_red_eye, size: 14.0, color: Color(0xff999999)),
                                  new SizedBox(width: 2.0),
                                  new Text(
                                    photoJsonModel.volume?.toString() ?? '0',
                                    style: new TextStyle(
                                      color: Color(0xff999999),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              new Text(
                                strTime,
                                style: new TextStyle(
                                  fontSize: 12.0,
                                  color: Color(0xff999999),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 操作
  void _handleClear () async {
    var result = await showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return new ConfirmDialog(
          content: '确定要清空浏览历史？',
        );
      },
    );
    if (result != true) return;
    try {
      String strUrl = Application.config.api.doHistoryClear;
      await Application.util.http.post(strUrl);
      this._reqHistoryList();
      Application.util.modal.toast('清除成功');
    } catch (err) {
      Application.util.modal.toast(err);
    }
  }

  // 刷新
  void _handleRefresh() async {
    _numIndex = 1;
    await this._reqHistoryList();
  }

  // 下拉加载
  void _handleLoad ({
    Function callback,
  }) async {
    _numIndex++;
    this._reqHistoryList(callback: callback);
  }

  // 获取列表
  void _reqHistoryList ({
    Function callback,
  }) async {
    await Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqCollectList;
        Map mapParams = { 'numIndex': _numIndex, 'numSize': _numSize };
        _listJsonModel = ListJsonModel.fromJson(await Application.util.http.post(strUrl, params: mapParams, useLoading: false));
        setState(() {
          List<CollectJsonModel> data = _listJsonModel.list.map((item) => CollectJsonModel.fromJson(item)).toList();
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
