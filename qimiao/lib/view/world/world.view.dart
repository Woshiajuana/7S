
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:flukit/flukit.dart';

import 'package:flutter/widgets.dart';

class WorldView extends StatefulWidget {
  @override
  _WorldViewState createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> with SingleTickerProviderStateMixin {

  TabController _tabController;
  final List _tabBarList = [
    {"id": "5b1fdbee30025ae5371ac363", "name": "动漫"},
    {"id": "5b1fd85730025ae5371abaed", "name": "综艺"}
  ];

//  @override
//  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            // snap: true,
            centerTitle: true,
            title: Text("Popular", style: TextStyle(fontFamily: "Lobster")),
            backgroundColor: Theme.of(context).primaryColor,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 36.0),
              child: Container(
                height: 36.0,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Color.fromARGB(255,192, 193, 195),
                  indicator: TabBarIndictorComponent(context: context),
                  tabs: <Widget>[
                    Tab(text: "动漫"),
                    Tab(text: "综艺")
                  ],
                ),
              ),
            ),
          )
        ];
      },
      body: TabBarView(
          controller: _tabController,
          children: [
            new Container(child: new Text('1'),),
            new Container(child: new Text('2'),)
          ]
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


class TabBarIndictorComponent extends Decoration {

  BuildContext context;
  Color bgColor;

  TabBarIndictorComponent({ @required this.context, this.bgColor = Colors.white });

  @override
  BoxPainter createBoxPainter([onChanged]) => _TabBarIndictorBoxPainter(context, bgColor);
}

class _TabBarIndictorBoxPainter extends BoxPainter {

  BuildContext context;
  Color bgColor;

  _TabBarIndictorBoxPainter(this.context, this.bgColor);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint();
    paint.color = bgColor;
    paint.style = PaintingStyle.fill;
    final width = 33.0;
    final height = 2.0;
    canvas.drawRect(
        Rect.fromLTWH(offset.dx - width / 2 + configuration.size.width / 2,
            configuration.size.height - height - 5.0, width, height),
        paint
    );
  }
}