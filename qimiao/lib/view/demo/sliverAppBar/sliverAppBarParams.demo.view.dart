
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class SliverAppBarParams extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            title: new Text(
              'SliverAppBarParams',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
            // 展开的高度
            expandedHeight: 300.0,
            // 强制显示阴影
            forceElevated: true,
            // 设置该属性，当有下滑手势的时候，就会显示 AppBar
            floating: true,
            // 该属性只有在 floating 为 true 的情况下使用，不然会报错
            // 当下滑到一定比例，会自动把 AppBar 展开
//            snap: true,
            // 设置该属性使 Appbar 折叠后不消失
            pinned: true,
            // 通过这个属性设置 AppBar 的背景
            flexibleSpace: new FlexibleSpaceBar(
              // 背景折叠动画
              collapseMode: CollapseMode.parallax,
              background: Image.network(Application.config.style.srcDemoUrl, fit: BoxFit.cover),
            ),
          ),
          // 这个部件一般用于最后填充用的，会占有一个屏幕的高度，
          // 可以在 child 属性加入需要展示的部件
          new SliverFillRemaining(
            child: new Center(
              child: new Text(
                'content',
                style: new TextStyle(fontSize: 30.0),
              )
            ),
          ),
        ],
      ),
    );
  }
}
