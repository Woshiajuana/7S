
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: false,
            child: _widgetSplashSection(),
          )
        ],
      ),
    );
  }

  // 启动页
  Widget _widgetSplashSection () {
    return new Image.asset(
      Application.util.getImgPath('splash_bg'),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    );
  }

  // 引导页
  Widget _widgetGuideSection () {
    List<String> _arrGuide = [
      Application.util.getImgPath('guide1'),
      Application.util.getImgPath('guide2'),
      Application.util.getImgPath('guide3'),
      Application.util.getImgPath('guide4'),
    ];
    return new Swiper();
  }

  // 广告页

}
