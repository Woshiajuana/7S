
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:qimiao/model/model.dart';
import 'package:qimiao/view/friend/following.view.dart';
import 'dart:ui';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._reqUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new WowScrollerInfo(
        maxExtent: 310,
        builder: (BuildContext context, double shrinkOffset, int alpha) {
          return new WowLoadView(
            status: _userJsonModel == null,
            child: new NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//                print('shrinkOffset <= 50 => ${shrinkOffset <= 50}  alpha => ${alpha}' );
                return <Widget>[
                  new SliverAppBar(
                    title:  new Text(
                      _userJsonModel?.nickname ?? '',
                      style: new TextStyle(
                        color: shrinkOffset <= 50 ? Colors.transparent : Color.fromARGB(alpha, 255, 255, 255),
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
                          _widgetHeaderSection(shrinkOffset: shrinkOffset, alpha: alpha),
                        ],
                      ),
                    ),
                    leading: new IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {},
                    ),
                  ),
//                  new SliverToBoxAdapter(
//                    child: new Container(
//                      height: 310.0,
//                      child: new Stack(
//                        children: <Widget>[
//                          _widgetHeaderDefBgSection(),
//                          _widgetHeaderBgSection(),
//                          _widgetHeaderSection(shrinkOffset: shrinkOffset, alpha: alpha),
//                          _widgetAppBarSection(shrinkOffset: shrinkOffset, alpha: alpha),
//                        ],
//                      ),
//                    ),
//                  ),
                ];
              },
              body: new SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
                    _widgetPhotoCellItem(),
                    _widgetPhotoCellItem(),
                    _widgetPhotoCellItem(),
                    _widgetPhotoCellItem(),
                    _widgetPhotoCellItem(),
                    _widgetPhotoCellItem(),
                    _widgetPhotoCellItem(),
                    _widgetPhotoCellItem(),
                    _widgetPhotoCellItem(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 照片
  Widget _widgetPhotoCellItem () {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            height: 30.0,
            padding: const EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              '2019-11-18',
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
                        child: new Image.asset(
                          Application.util.getImgPath('guide1.png'),
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
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
                      children: <Widget>[
                        new Text(
                          '初始预售普吉岛扫地机阿三破搭配师激动啊上坡',
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
                                  '100',
                                  style: new TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new Icon(Icons.thumb_up, size: 14.0, color: Color(0xff999999)),
                                new SizedBox(width: 2.0),
                                new Text(
                                  '100',
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
                                  onPressed: () => _handleOperate(),
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
          ],
        );
      },
    );
  }

  // 导航条
  Widget _widgetAppBarSection ({
    double shrinkOffset,
    int alpha,
  }) {
    return new Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: new Container(
        color: Color.fromARGB(alpha, 236, 100, 47),
        child: new SafeArea(
          bottom: false,
          child: new Container(
            height: 56.0,
            child: new Row(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.arrow_back,
                    color: shrinkOffset <= 50 ? Colors.white : Color.fromARGB(alpha, 255, 255, 255),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                new SizedBox(width: 24.0),
                new Text(
                  '我是阿倦啊',
                  style: new TextStyle(
                    color: shrinkOffset <= 50 ? Colors.transparent : Color.fromARGB(alpha, 255, 255, 255),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
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

  // 默认背景
  Widget _widgetHeaderDefBgSection () {
    return new Container(
      height: 310.0,
      decoration: new BoxDecoration(
        color: Color(0xffdddddd),
        image: new DecorationImage(
          image: new AssetImage(Application.util.getImgPath('mine_head_bg.png')),
          fit: BoxFit.cover,
        ),
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
      } catch (err) {
        Application.util.modal.toast(err);
      }
    });
  }

}
