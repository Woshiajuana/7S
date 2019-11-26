
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/cellLink.widget.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:flukit/flukit.dart';

class WorldView extends StatefulWidget {
  @override
  _WorldViewState createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverPersistentHeader(
            pinned: true,
            delegate: new SliverCustomHeaderDelegate(
              collapsedHeight: 56,
              expandedHeight: 200,
              paddingTop: MediaQuery.of(context).padding.top,
              buildContent: (BuildContext context, double shrinkOffset, int alpha) {
                return <Widget> [
                  _widgetCarouselSection(shrinkOffset: shrinkOffset, alpha: alpha),
                  _widgetAppBarSection(shrinkOffset: shrinkOffset, alpha: alpha),
                ];
              }
            ),
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(
              <Widget>[
                new Container(height: 200.0, color: Colors.blue),
                new Container(height: 200.0, color: Colors.red),
                new Container(height: 200.0, color: Colors.blue),
                new Container(height: 200.0, color: Colors.red),
                new Container(height: 200.0, color: Colors.blue),
                new Container(height: 200.0, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 轮播图
  Widget _widgetCarouselSection ({
    double shrinkOffset,
    int alpha,
  }) {

    // 引导页数据
    List<String> _arrGuide = [
      Application.util.getImgPath('guide1.png'),
      Application.util.getImgPath('guide2.png'),
      Application.util.getImgPath('guide3.png'),
      Application.util.getImgPath('guide4.png'),
    ];

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
          child: new Image.asset(
            item,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        );
      }).toList(),
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



  void _handleExitOut () async {
    var result = await showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return new WillPopScope(
          child: new UpgradeDialog(),
          onWillPop: () async {
            return Future.value(false);
          }
        );
      },
    );
    if (result != true) return;
    try {
//      await Application.util.store.clear();
    } catch (err) {

    } finally {
      Application.router.replace(context, 'login');
    }
  }


}
