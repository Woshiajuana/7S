
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/view/friend/follower.view.dart';
import 'package:qimiao/view/friend/following.view.dart';


class FriendView extends StatefulWidget {
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
    _tabController = new TabController(vsync: this, length: 2);
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
        bottom: new TabBar(
          tabs: <Widget>[
            new Tab(
              child: new Text(
                '关注',
              ),
            ),
            new Tab(
              child: new Text(
                '粉丝',
              ),
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
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
