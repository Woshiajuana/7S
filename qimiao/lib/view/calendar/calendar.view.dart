
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/cellLink.widget.dart';
import 'package:qimiao/widget/widget.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            actions: <Widget>[
              new Container(
                child: new Stack(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(Icons.email),
                      onPressed: () => Application.router.push(context, 'notice'),
                    ),
                    new Positioned(
                      top: 10.0,
                      right: 10.0,
                      child: new Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: new BorderRadius.circular(6.0),
                          border: new Border.all(color: Application.config.style.mainColor, width: 2.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            elevation: 0,
            expandedHeight: 56.0,
            forceElevated: false,
            floating: false,
            pinned: true,
            flexibleSpace: new FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: new Image.asset(Application.util.getImgPath('mine_head_bg.png'), fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: new Container(
              height: 100,
              color: Colors.yellow,
            ),
          ),
          SliverPersistentHeader(    // 可以吸顶的TabBar
            pinned: true,
            delegate: new StickyWidgetDelegate(
              maxExtentHeight: 40.0,
              minExtentHeight: 40.0,
              child: new Container(
                color: Colors.red,
                child: new Text('1'),
                height: 100.0,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: new Container(
              height: 100,
              color: Colors.black,
            ),
          ),
          SliverFillRemaining(        // 剩余补充内容TabBarView
            child: new Column(
              children: <Widget>[
                Center(child: Text('Content of Home')),
                Center(child: Text('Content of Profile')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 日历
  Widget _widgetCalendarSection () {
    return new Calendar(
//        showChevronsToChangeRange: false,
        isExpandable: true,
        showCalendarPickerIcon: false,
        showTodayAction: false,
        showChevronsToChangeRange: false,
        initialCalendarDateOverride: DateTime(2019, 6, 20),
    );
  }

}
