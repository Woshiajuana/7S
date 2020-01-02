
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:qimiao/model/model.dart';

class MineView extends StatefulWidget {
  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true; // 要点2

  StreamSubscription _mineEventSubscription;
  ScrollController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    _mineEventSubscription = eventBus.on<MineEvent>().listen((MineEvent data) {
      this._reqUserInfo();
    });
    this._reqUserInfo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mineEventSubscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    await this._reqUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 要点3

    return new ScopedModelDescendant<StateModel>(
      builder: (context, child, model) {
        return new Scaffold(
          backgroundColor: Application.config.style.backgroundColor,
          body: new Stack(
            children: <Widget>[
              new RefreshIndicator(
                onRefresh: _handleRefresh,
                child: new ListView(
                  padding: const EdgeInsets.all(0),
                  children: <Widget>[
                    _widgetHeaderSection(model: model),
                    _widgetMenuSection(),
                    new SizedBox(height: 10.0),
                  ],
                ),
              ),
              _widgetAppBarSection(model: model),
            ],
          ),
        );
      }
    );
  }

  // appbar
  Widget _widgetAppBarSection ({
    StateModel model,
  }) {
    int numPrivateNotice = model?.user?.numPrivateNotice ?? 0;
    int numPublicNotice = model?.user?.numPublicNotice ?? 0;
    return new Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: new Container(
        color: Colors.transparent,
        child: new SafeArea(
          bottom: false,
          child: new Container(
            height: 56.0,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Container(
                  child: new Stack(
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(Icons.email, color: Colors.white),
                        onPressed: () => Application.router.push(context, 'notice'),
                      ),
                      new Positioned(
                        top: 12.0,
                        right: 11.0,
                        child: new Offstage(
                          offstage: !(numPrivateNotice + numPublicNotice > 0),
                          child: new Container(
                            width: 7.0,
                            height: 7.0,
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: new BorderRadius.circular(6.0),
                              border: new Border.all(color: Colors.transparent, width: 2.0),
                            ),
                          ),
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
    );
  }

  // 头部背景
  Widget _widgetHeaderSection ({
    StateModel model,
  }) {
    return new Container(
      height: 310.0,
      alignment: Alignment.bottomCenter,
      child: new Stack(
        children: <Widget>[
          new Container(
            height: 310.0,
            child: new CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              imageUrl: model?.user?.avatar ?? '',
              placeholder: (context, url) => new Image.asset(
                Application.util.getImgPath('mine_head_bg.png'),
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => new Image.asset(
                Application.util.getImgPath('mine_head_bg.png'),
                fit: BoxFit.cover,
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
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // 用户信息
              _widgetUserInfoSection(model: model),
              // 用户基本信息
              _widgetFollowGroup(model: model),
            ],
          ),
        ],
      ),
    );
  }

  Widget _widgetUserInfoSection ({
    StateModel model,
  }) {
    String nickname = model?.user?.nickname ?? '';
    String email = model?.user?.email ?? '';
    String signature = model?.user?.signature ?? '';
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
                  nickname == '' ? email : nickname,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          new SizedBox(height: 3.0),
          new Text(
            signature == '' ? '这个家伙什么都没留下...' : signature,
            style: new TextStyle(
              color: Color(0xffbbbbbb),
              fontSize: 12.0,
            ),
          ),
          new SizedBox(height: 12.0),
          new Container(
            height: 20.0,
            width: 70.0,
            decoration: new BoxDecoration(
              color: Application.config.style.mainColor,
              borderRadius: new BorderRadius.circular(20.0),
            ),
            child: new FlatButton(
              padding: const EdgeInsets.all(0),
              onPressed: () => Application.router.push(context, 'mineCenter'),
              child: new Text(
                '个人中心',
                style: new TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 10.0,
                  color: Colors.white,
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
    StateModel model,
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
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                new SizedBox(height: 3.0),
                new Text(
                  labelText,
                  style: new TextStyle(
                    color: Colors.white,
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
            valueText: model?.user?.numFollower?.toString() ?? '0',
            onPressed: () => Application.router.push(context, 'friend', params: { 'index': 1 }),
          ),
          _widgetBaseInfoItem(
            labelText: '关注',
            valueText: model?.user?.numFollowing?.toString() ?? '0',
            onPressed: () => Application.router.push(context, 'friend'),
          ),
          _widgetBaseInfoItem(
            labelText: '照片',
            valueText: model?.user?.numPhoto?.toString() ?? '0',
            onPressed: () => Application.router.push(context, 'photoList'),
          ),
        ],
      ),
    );
  }

  // 菜单
  Widget _widgetMenuSection () {
    List _arrMenu = [
      {
        'text': '照片',
        'icon': Icons.photo,
        'useMargin': true,
        'routeName': 'photoList',
      },
      {
        'text': '收藏',
        'icon': Icons.star,
        'useMargin': true,
        'routeName': 'collectList',
      },
      {
        'text': '历史',
        'icon': Icons.history,
        'useMargin': false,
        'routeName': 'historyList',
      },
      {
        'text': '设置',
        'icon': Icons.settings,
        'useMargin': true,
        'routeName': 'setting',
      },
    ];

    Widget _widgetMenuItem ({
      dynamic onPressed,
      Color color,
      String text = '',
      IconData icon,
      bool useMargin = false,
    }) {
      return new Container(
        height: 60.0,
        margin: EdgeInsets.only(top: useMargin ? 10.0 : 0),
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(width: 0.5, color: Color(0xffdddddd)),
              top: new BorderSide(width: useMargin ? 0.5 : 0, color: Color(0xffdddddd))
          ),
        ),
        child: new FlatButton(
          padding: const EdgeInsets.all(0),
          onPressed: onPressed,
          child: new Row(
            children: <Widget>[
              new SizedBox(width: 16.0),
              new Icon(icon, color: Color(0xff666666)),
              new SizedBox(width: 16.0),
              new Text(
                text,
                style: new TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              new Expanded(flex: 1, child: new Container()),
              new Icon(Icons.arrow_forward_ios, size: 18.0, color: Color(0xff999999)),
              new SizedBox(width: 10.0),
            ],
          ),
        ),
      );
    }

    return new Column(
      children: _arrMenu.map((item) {
        return _widgetMenuItem(
          onPressed: () => Application.router.push(context, item['routeName']),
          text: item['text'],
          icon: item['icon'],
          useMargin: item['useMargin'],
        );
      }).toList(),
    );
  }

//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    print('didChangeDependencies');
//  }

  void _reqUserInfo () async {
    await Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqUserInfo;
        var data = await Application.util.http.post(strUrl, useLoading: false);
        Application.util.store.set(Application.config.store.userJson, data);
        UserJsonModel userJsonModel = UserJsonModel.fromJson(data);
        StateModel.of(context).setUserJsonModel(userJsonModel);
      } catch (err) {
        Application.util.modal.toast(err);
      }
    });
  }

}