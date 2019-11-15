
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class NestedScrollViewParams extends StatelessWidget {

  final _tabs = <String>['TabA', 'TabB'];
  final colors = <Color>[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.yellow,
    Colors.deepPurple
  ];


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new DefaultTabController(
        length: _tabs.length,
        child: new NestedScrollView(
          headerSliverBuilder: (context, innerScrolled) => <Widget>[
            new SliverOverlapAbsorber(
              // 传入 handle 值，直接通过 `sliverOverlapAbsorberHandleFor` 获取即可
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: new SliverAppBar(
                pinned: true,
                title: new Text(
                  'NestedScrollViewParams',
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                expandedHeight: 200.0,
                flexibleSpace: new FlexibleSpaceBar(background: Image.network(Application.config.style.srcDemoUrl, fit: BoxFit.cover)),
                bottom: new TabBar(tabs: _tabs.map((tab) => new Text(tab, style: new TextStyle(fontSize: 18.0))).toList()),
                forceElevated: innerScrolled,
              ),
            )
          ],
          body: new TabBarView(
            children: _tabs
            // 这边需要通过 Builder 来创建 TabBarView 的内容，否则会报错
            // NestedScrollView.sliverOverlapAbsorberHandleFor must be called with a context that contains a NestedScrollView.
            .map((tab) => Builder(
              builder: (context) => new CustomScrollView(
                // key 保证唯一性
                key: new PageStorageKey<String>(tab),
                slivers: <Widget>[
                // 将子部件同 `SliverAppBar` 重叠部分顶出来，否则会被遮挡
                  new SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  ),
                  new SliverGrid(
                    delegate: new SliverChildBuilderDelegate(
                      (_, index) => Image.network(Application.config.style.srcDemoUrl),
                      childCount: 8
                    ),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                  ),
                  new SliverFixedExtentList(
                    delegate: new SliverChildBuilderDelegate(
                      (_, index) => new Container(
                        child: new Text(
                          '$tab - item${index + 1}',
                          style: new TextStyle(fontSize: 20.0, color: colors[index % 6]),
                        ),
                        alignment: Alignment.center
                      ),
                      childCount: 15
                    ),
                    itemExtent: 50.0
                  ),
                ],
              ),
            )
          ).toList()),
        )
      ),
    );
  }
}
