
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:flukit/flukit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qimiao/common/utils/timer.util.dart';
import 'package:qimiao/model/model.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  TimerUtil _timerUtil;
  int _count = 5;
  int _status = 0;  // 0:启动页  1:引导页  2:广告页

  // 倒计时
  void _countDown () {
    _timerUtil = new TimerUtil(mTotalTime: _count * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      if (_tick <= 0) {
        _handleJudgeTo();
      } else {
        setState(() {
          _count = _tick.toInt();
        });
      }
    });
    _timerUtil.startCountDown();
  }

  @override
  void initState() {
    super.initState();
    this._judgeShowPage();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          // 启动页
          new Offstage(
            offstage: !(_status == 0),
            child: _widgetSplashSection(),
          ),
          // 引导页
          new Offstage(
            offstage: !(_status == 1),
            child: _widgetGuideSection(),
          ),
          // 广告业
          new Offstage(
            offstage: !(_status == 2),
            child: _widgetAdvertSection(),
          ),
        ],
      ),
    );
  }

  // 启动页
  Widget _widgetSplashSection () {
    return new Image.asset(
      Application.util.getImgPath('splash_bg.png'),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    );
  }

  // 引导页
  Widget _widgetGuideSection () {

    // 引导页数据
    List<String> _arrGuide = [
      Application.util.getImgPath('guide1.png'),
      Application.util.getImgPath('guide2.png'),
      Application.util.getImgPath('guide3.png'),
      Application.util.getImgPath('guide4.png'),
    ];

    // 立即体验按钮
    Widget _widgetButtonItem () {
      return new Align(
        alignment: Alignment.bottomCenter,
        child: new Container(
          width: 240.0,
          height: 45.0,
          margin: const EdgeInsets.only(bottom: 80.0),
          decoration: new BoxDecoration(
            color: Application.config.style.mainColor,
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF999999),
                blurRadius: 1.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: new FlatButton(
            onPressed: () => _handleJudgeTo(),
            child: new Text(
              '立即体验',
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      );
    }

    // 引导页轮播
    return new Swiper(
      autoStart: false,
      circular: false,
      indicator: new CircleSwiperIndicator(
        radius: 4.0,
        padding: const EdgeInsets.only(bottom: 40.0),
        itemColor: Colors.black26,
      ),
      children: _arrGuide.map((item) {
        return new Container(
          child: new Stack(
            children: <Widget>[
              new Image.asset(
                item,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
              item == _arrGuide[_arrGuide.length - 1]
                  ? _widgetButtonItem()
                  : new SizedBox(),
            ],
          ),
        );
      }).toList(),
    );
  }

  // 广告页
  Widget _widgetAdvertSection () {

    // 广告页面
    Widget _widgetAdvertItem () {
      return new InkWell(
        onTap: () => {},
        child: new Container(
          alignment: Alignment.center,
          child: new CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            imageUrl: 'https://img3.mukewang.com/szimg/5d919e87087c044201400140-140-140.jpg',
            placeholder: (context, url) => _widgetSplashSection(),
            errorWidget: (context, url, error) => _widgetSplashSection(),
          ),
        ),
      );
    }

    // 跳过倒计时
    Widget _widgetCountDownItem () {
      return new Positioned(
        top: 35.0,
        right: 20.0,
        child: new Container(
          width: 60.0,
          height: 26.0,
          decoration: new BoxDecoration(
            border: new Border.all(width: 0.5, color: Colors.red),
            borderRadius: new BorderRadius.circular(20.0),
          ),
          child: new FlatButton(
            padding: const EdgeInsets.all(0),
            onPressed: () => _handleJudgeTo(),
            child: new Text(
              '跳过 $_count s',
              style: new TextStyle(fontSize: 12.0, color: Colors.red),
            ),
          ),
        ),
      );
    }

    return new Container(
      child: new Stack(
        children: <Widget>[
          _widgetAdvertItem(),
          _widgetCountDownItem(),
        ],
      ),
    );
  }

  // 根据用户是否第一次打开 APP 来显示 引导页 还是 广告业
  void _judgeShowPage () async {
    String firstTimeKey = Application.config.store.firstTime;
    var firstTime = await Application.util.store.get(firstTimeKey);
    setState(() {
      _status = firstTime == null ? 1 : 2;
      if (firstTime == null) {
        _status = 1;
        Application.util.store.set(firstTimeKey, 'true');
      } else {
        _status = 2;
        _countDown();
      }
    });
  }

  // 根据用户是否已登录来判断是否跳转到对应页面
  void _handleJudgeTo () async {
    String userInfoJsonKey = Application.config.store.userJson;
    var userInfoJson = await Application.util.store.get(userInfoJsonKey);
    if (userInfoJson == null) {
      return Application.router.replace(context, 'login');
    }
    UserJsonModel userJsonModel = UserJsonModel.fromJson(userInfoJson);
    StateModel.of(context).setUserJsonModel(userJsonModel);
    Application.router.replace(context, 'app');
  }

  @override
  void dispose() {
    if (_timerUtil != null) _timerUtil.cancel(); // 记得中dispose里面把timer cancel。
    super.dispose();
  }

}
