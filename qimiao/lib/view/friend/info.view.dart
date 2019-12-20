
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
                floating: false,
                pinned: true,
                snap: false,
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
              ),
            ];
          },
          body: new WowLoadView(
            data: _arrData,
            child: new ListView.builder(
              padding: const EdgeInsets.all(0),
              physics: new AlwaysScrollableScrollPhysics(),
//              controller: _scrollController,
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
              count == total ? '没有更多啦' : '加载中...',
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
            padding: const EdgeInsets.all(10.0),
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
                        child: new FlatButton(
                          onPressed: () => Application.router.push(context, 'photoDetails', params: { 'id': photoJsonModel.id }),
                          child: new Container(),
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
                                  ),
                                ),
                              ],
                            ),
                            new Container(
                              height: 20.0,
                              width: 20.0,
                              child: new FlatButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () => _handleOperate(photoJsonModel),
                                  child: new Icon(Icons.more_vert, size: 18.0, color: Color(0xff999999))
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
      color: Colors.red,
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
            labelText: '视频',
            valueText: _userJsonModel?.numVideo?.toString() ?? '0',
          ),
          _widgetBaseInfoItem(
            labelText: '照片',
            valueText: _userJsonModel?.numPhoto?.toString() ?? '0',
          ),
        ],
      ),
    );
  }

  // 操作
  void _handleOperate (PhotoJsonModel photoJsonModel) {
    showDialog(
      context: context,
      barrierDismissible: true,//是否点击空白区域关闭对话框,默认为true，可以关闭
      builder: (BuildContext context) {
        return new ActionSheetDialog(
          arrOptions: [
            {
              'text': '编辑',
              'onPressed': () {
                Application.router.pop(context);
                Application.router.push(context, 'photoAdded', params: { 'title': '编辑作品', 'data': photoJsonModel });
              },
            },
            {
              'text': '删除',
              'onPressed': () => this._doPhotoDelete(photoJsonModel),
            },
          ],
        );
      },
    );
  }

  // 删除
  void _doPhotoDelete (PhotoJsonModel photoJsonModel) async {
    Application.router.pop(context);
    var result = await showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return new ConfirmDialog(
          content: '确定要删除该张照片么？',
        );
      },
    );
    if (result != true) return;
    try {
      String strUrl = Application.config.api.doPhotoDelete;
      Map mapParams = { 'id': photoJsonModel.id };
      await Application.util.http.post(strUrl, params: mapParams);
      setState(() {
        _listJsonModel.total--;
        _arrData.remove(photoJsonModel);
      });
      Application.util.modal.toast('删除成功');
    } catch (err) {
      Application.util.modal.toast(err);
    }
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

  // 刷新
  void _handleRefresh() async {
    _numIndex = 1;
    await this._reqPhotoList();
  }

  // 下拉加载
  void _handleLoad ({
    Function callback,
  }) async {
    _numIndex++;
    this._reqPhotoList(callback: callback);
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

}
