
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:flukit/flukit.dart';

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
            child: _widgetGuideSection(),
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
    return new Swiper(
      autoStart: false,
      circular: false,
      indicator: new CircleSwiperIndicator(
        radius: 4.0,
        padding: const EdgeInsets.only(bottom: 30.0),
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
            ],
          ),
        );
      }).toList(),
    );
  }

  // 广告页

}
