
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:qimiao/model/model.dart';

class FriendFollowerView extends StatefulWidget {
  @override
  _FriendFollowerViewState createState() => _FriendFollowerViewState();
}

class _FriendFollowerViewState extends State<FriendFollowerView> with AutomaticKeepAliveClientMixin {

  ListJsonModel _listJsonModel;
  List<UserJsonModel> _arrData;
  int _numIndex = 1;
  int _numSize = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._reqFollowerList();
  }

  @override
  bool get wantKeepAlive => true; // 要点2

  @override
  Widget build(BuildContext context) {
    super.build(context); // 要点3

    return new WowLoadView(
      data: _arrData,
      child: new WowScrollListView(
        onRefresh: _handleRefresh,
        onLoad: _handleLoad,
        data: _arrData,
        total: _listJsonModel?.total ?? 0,
        itemBuilder: (content, index) {
          return _widgetCellItem(index);
        },
      ),
    );
  }

  // item
  Widget _widgetCellItem (int index) {
    UserJsonModel userJsonModel = _arrData[index];
    print(userJsonModel.avatar);
    return new Container(
      padding: const EdgeInsets.only(right: 16.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          top: new BorderSide(
            color: Color(0xffdddddd),
            width: 0.5,
          ),
        ),
      ),
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(
              height: 60.0,
              child: new FlatButton(
                onPressed: () => Application.router.push(context, 'friendInfo', params: { 'id': userJsonModel?.id }),
                padding: const EdgeInsets.only(right: 0, left: 16.0),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                        border: new Border.all(color: Color(0xFF9E9E9E), width: 0.5), // 边色与边宽度
                        color: Color(0xFF9E9E9E), // 底色
                        borderRadius: new BorderRadius.circular((41)), // 圆角度
                      ),
                      child: new ClipOval(
                        child: new CachedNetworkImage(
                          width: 36.0,
                          height: 36.0,
                          fit: BoxFit.cover,
                          imageUrl: userJsonModel?.avatar ?? '',
                          placeholder: (context, url) => new Image.asset(
                            Application.util.getImgPath('guide1.png'),
                            width: 36.0,
                            height: 36.0,
                          ),
                          errorWidget: (context, url, error) => new Image.asset(
                            Application.util.getImgPath('guide1.png'),
                            width: 36.0,
                            height: 36.0,
                          ),
                        ),
                      ),
                    ),
                    new SizedBox(width: 10.0),
                    new Expanded(
                      flex: 1,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            userJsonModel?.nickname ?? '',
                            style: new TextStyle(
                              color: Color(0xff666666),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          new SizedBox(height: 4.0),
                          new Text(
                            userJsonModel?.signature ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              color: Color(0xff999999),
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 刷新
  void _handleRefresh() async {
    _numIndex = 1;
    await this._reqFollowerList();
  }

  // 下拉加载
  void _handleLoad ({
    Function callback,
  }) async {
    _numIndex++;
    this._reqFollowerList(callback: callback);
  }

  // 获取列表
  void _reqFollowerList ({
    Function callback,
  }) async {
    await Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqFollowerList;
        Map mapParams = { 'numIndex': _numIndex, 'numSize': _numSize };
        _listJsonModel = ListJsonModel.fromJson(await Application.util.http.post(strUrl, params: mapParams, useLoading: false));
        setState(() {
          List<UserJsonModel> data = _listJsonModel.list.map((item) => UserJsonModel.fromJson(item)).toList();
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
