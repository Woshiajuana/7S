
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

    // 引导页数据
    List<String> _arrGuide = [
      Application.util.getImgPath('guide1'),
      Application.util.getImgPath('guide2'),
      Application.util.getImgPath('guide3'),
      Application.util.getImgPath('guide4'),
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
            onPressed: () => {},
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
    return new Container(
      
    );
  }

}
