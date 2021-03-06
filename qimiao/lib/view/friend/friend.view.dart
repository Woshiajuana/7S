
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/view/friend/follower.view.dart';
import 'package:qimiao/view/friend/following.view.dart';

class FriendView extends StatefulWidget {

  FriendView({
    this.index = 0,
  });

  final int index;

  @override
  _FriendViewState createState() => _FriendViewState();
}

class _FriendViewState extends State<FriendView> with SingleTickerProviderStateMixin  {

  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2, initialIndex: widget?.index ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '我的好友',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
        bottom: new PreferredSize(
          child: new Material(
            child: new Container(
              height: 44.0,
              decoration: new BoxDecoration(
                color: Colors.white,
                border: new Border(
                  bottom: new BorderSide(
                    color: Color(0xffdddddd),
                    width: 0.5,
                  ),
                ),
              ),
              child: new TabBar(
                controller: _tabController,
                unselectedLabelColor: Color(0xff999999),
                labelColor: Application.config.style.mainColor,
                indicatorColor: Application.config.style.mainColor,
                tabs: <Widget>[
                  Tab(text: '关注'),
                  Tab(text: '粉丝'),
                ],
              ),
            ),
          ),
          preferredSize: new Size(double.infinity, 44.0),
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new FriendFollowingView(),
          new FriendFollowerView(),
        ],
      ),
    );
  }


}
