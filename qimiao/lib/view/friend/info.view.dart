
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:qimiao/model/model.dart';
import "package:intl/intl.dart";

class FriendInfoView extends StatefulWidget {

  FriendInfoView({
    this.id,
  });

  final String id;

  @override
  _FriendInfoViewState createState() => _FriendInfoViewState();
}

class _FriendInfoViewState extends State<FriendInfoView> {

  UserJsonModel _userJsonModel;
  ScrollController _scrollController;
  int _alpha = 0;
  double _shrinkOffset = 0;

  ListJsonModel _listJsonModel;
  List<PhotoJsonModel> _arrData;
  int _numIndex = 1;
  int _numSize = 10;
  bool _isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _shrinkOffset = _scrollController.position.pixels;
        _alpha = (_shrinkOffset / 310 * 255).clamp(0, 255).toInt();
      });
    });
    this._reqUserInfo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count = _arrData?.length ?? 0;
    int total = _listJsonModel?.total ?? 0;
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new WowLoadView(
        status: _userJsonModel == null,
        child: new NotificationListener<ScrollNotification>(
          onNotification: _handleScroll,
          child: new NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title:  new Text(
                    _userJsonModel?.nickname ?? '',
                    style: new TextStyle(
                      color: _shrinkOffset <= 50 ? Colors.transparent : Color.fromARGB(_alpha, 255, 255, 255),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  expandedHeight: 310.0 - MediaQueryData.fromWindow(window).padding.top,
                  floating: true,
                  pinned: true,
                  snap: true,
                  flexibleSpace: new FlexibleSpaceBar(
                    background: new Stack(
                      children: <Widget>[
                        _widgetHeaderBgSection(),
                        _widgetHeaderSection(shrinkOffset: _shrinkOffset, alpha: _alpha),
                      ],
                    ),
                  ),
                  leading: new IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Application.router.pop(context),
                  ),
                  actions: <Widget>[
                    StateModel.of(context)?.user?.id == widget?.id ? new Container() :
                    new IconButton(
                      onPressed: () => _doFollowUpdate(),
                      icon: new Icon((_userJsonModel?.follower ?? '') == '' ? Icons.favorite_border : Icons.favorite),
                    ),
                  ],
                ),
              ];
            },
            body: new WowLoadView(
              data: _arrData,
              child: new RefreshIndicator(
                onRefresh: _handleRefresh,
                child: new ListView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: new AlwaysScrollableScrollPhysics(),
                  itemCount: _isLoading ? count + 1 : count,
                  itemBuilder: (context, index) {
                    if (index < count) {
                      return _widgetPhotoCellItem(index);
                    }
                    return _widgetMoreCellItem(count: count, total: total);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _widgetMoreCellItem ({
    int count,
    int total,
  }) {
    return new Center(
      child: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            count == total ? new Container() : new SizedBox(
              width: 15,
              height: 15,
              child: new CircularProgressIndicator(
                strokeWidth: 1.0,
              ),
            ),
            new SizedBox(width: 10.0),
            new Text(
              total == 0 ? '' : count == total ? '没有更多啦' : '加载中...',
              style: new TextStyle(fontSize: 12.0, color: Color(0xff999999)),
            ),
          ],
        ),
      ),
    );
  }

  // 照片
  Widget _widgetPhotoCellItem (index) {
    PhotoJsonModel photoJsonModel = _arrData[index];
    String strTime = photoJsonModel.created_at != null
        ? new DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(photoJsonModel.created_at).toLocal())
        : '';
    FileJsonModel fileJsonModel = photoJsonModel.photo;
    String strPath = '${fileJsonModel.base}${fileJsonModel.path}${fileJsonModel.filename}';
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            height: 30.0,
            padding: const EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              strTime,
              style: new TextStyle(
                fontSize: 12.0,
                color: Color(0xff666666),
              ),
            ),
          ),
          new Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                top: new BorderSide(
                  color: Color(0xffdddddd),
                  width: 0.5,
                ),
                bottom: new BorderSide(
                  color: Color(0xffdddddd),
                  width: 0.5,
                ),
              ),
            ),
            child: new FlatButton(
              padding: const EdgeInsets.all(10.0),
              onPressed: () => Application.router.push(context, 'photoDetails', params: { 'id': photoJsonModel.id }),
              child:  new Row(
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

  // 头部内容
  Widget _widgetHeaderSection ({
    double shrinkOffset,
    int alpha,
  }) {
    int a = (alpha * 1.3).toInt();
    if (a > 255) a = 255;
    return new Container(
      height: 310,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // 用户信息
          alpha < 200 ? _widgetUserInfoSection(
            shrinkOffset: shrinkOffset,
            alpha: a,
          ) : new Container(),
          // 用户基本信息
          alpha < 200 ? _widgetFollowGroup(
            shrinkOffset: shrinkOffset,
            alpha: a,
          ) : new Container(),
          // tab 切换
        ],
      ),
    );
  }

  Widget _widgetUserInfoSection ({
    double shrinkOffset,
    int alpha,
  }) {
    return new Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      child:  new Column(
        children: <Widget>[
          // 昵称
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  _userJsonModel?.nickname ?? '',
                  style: new TextStyle(
                    color: Color.fromARGB(255 - alpha, 255, 255, 255),
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          new SizedBox(height: 3.0),
          new Text(
            _userJsonModel?.signature ?? '这个家伙什么都没留下...',
            style: new TextStyle(
              color: Color.fromARGB(255 - alpha, 187, 187, 187),
              fontSize: 12.0,
            ),
          ),
          new SizedBox(height: 12.0),
        ],
      ),
    );
  }

  // 头部背景
  Widget _widgetHeaderBgSection () {
    return new Container(
      height: 310.0,
      alignment: Alignment.bottomCenter,
      child: new Stack(
        children: <Widget>[
          new Container(
            height: 310.0,
            child:new CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              imageUrl: _userJsonModel?.avatar ?? '',
              placeholder: (context, url) => new Image.asset(
                Application.util.getImgPath('mine_head_bg.png'),
              ),
              errorWidget: (context, url, error) => new Image.asset(
                Application.util.getImgPath('mine_head_bg.png'),
              ),
            ),
          ),
          new Container(
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
          new Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: new Container(
              height: 150.0,
              decoration: new BoxDecoration(
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
        ],
      ),
    );
  }

  // 粉丝 or 关注
  Widget _widgetFollowGroup ({
    double shrinkOffset,
    int alpha,
  }) {
    Widget _widgetBaseInfoItem ({
      String labelText = '',
      String valueText = '',
      dynamic onPressed,
    }) {
      return new Expanded(
        flex: 1,
        child: new FlatButton(
            onPressed: onPressed,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  valueText,
                  style: new TextStyle(
                    color: Color.fromARGB(255 - alpha, 255, 255, 255),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                new SizedBox(height: 3.0),
                new Text(
                  labelText,
                  style: new TextStyle(
                    color: Color.fromARGB(255 - alpha, 255, 255, 255),
                    fontSize: 10.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            )
        ),
      );
    }
    return new Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _widgetBaseInfoItem(
            labelText: '粉丝',
            valueText: _userJsonModel?.numFollower?.toString() ?? '0',
          ),
          _widgetBaseInfoItem(
            labelText: '关注',
            valueText: _userJsonModel?.numFollowing?.toString() ?? '0',
          ),
          _widgetBaseInfoItem(
            labelText: '照片',
            valueText: _userJsonModel?.numPhoto?.toString() ?? '0',
          ),
        ],
      ),
    );
  }

  // 刷新
  Future<void> _handleRefresh() async {
    setState(() => _isLoading = false);
    _numIndex = 1;
    await this._reqPhotoList();
  }

  void _reqUserInfo () async {
    Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        if (widget.id == null) throw '缺省用户id';
        String strUrl = Application.config.api.reqUserInfo;
        var data = await Application.util.http.post(strUrl, params: {
          'id': widget.id,
        }, useLoading: false);
        setState(() {
          _userJsonModel = UserJsonModel.fromJson(data);
        });
        this._reqPhotoList();
      } catch (err) {
        Application.util.modal.toast(err);
      }
    });
  }

  // 滚动监听回调
  bool _handleScroll (ScrollNotification scroll) {
    // 当前滑动距离
    var position = scroll.metrics;
    // 小于50px时，触发上拉加载；
    if (position.maxScrollExtent - position.pixels < 30) {
      this._handleLoad();
    }
    // 返回false，继续向上传递,返回true则不再向上传递
    return true;
  }

  // 下拉加载
  void _handleLoad ({
    Function callback,
  }) async {
    if (!_isLoading) {
      setState(() => _isLoading = true);
      int total = _listJsonModel?.total ?? 0;
      int count = _arrData?.length ?? 0;
      if (total <= count) return null;
      _numIndex++;
      this._reqPhotoList(callback: () {
        setState(() => _isLoading = false);
      });
    }
  }

  // 获取列表
  void _reqPhotoList ({
    Function callback,
  }) async {
    await Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqPhotoList;
        Map mapParams = { 'numIndex': _numIndex, 'numSize': _numSize, 'user': widget.id };
        _listJsonModel = ListJsonModel.fromJson(await Application.util.http.post(strUrl, params: mapParams, useLoading: false));
        setState(() {
          List<PhotoJsonModel> data = _listJsonModel.list.map((item) => PhotoJsonModel.fromJson(item)).toList();
          _numIndex == 1 ? _arrData = data : _arrData.addAll(data);
        });
      } catch (err) {
        Application.util.modal.toast(err);
      } finally {
        if (callback != null) callback();
      }
    });
  }

  // 关注取消关注
  void _doFollowUpdate () async {
    try {
      String strUrl = Application.config.api.doFollowUpdate;
      var data = await Application.util.http.post(strUrl, params: {
        'id': _userJsonModel?.id ?? '',
      });
      setState(() {
        _userJsonModel.follower = data ?? '';
        _userJsonModel.numFollower = (data ?? '') == '' ? _userJsonModel.numFollower - 1 : _userJsonModel.numFollower + 1;
      });
      Application.util.modal.toast((data ?? '') == '' ? '已取消关注' : '关注成功');
    } catch (err) {
      Application.util.modal.toast(err);
    }
  }

}
