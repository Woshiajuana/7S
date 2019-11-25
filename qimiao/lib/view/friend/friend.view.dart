
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/view/friend/follower.view.dart';
import 'package:qimiao/view/friend/following.view.dart';


class FriendView extends StatefulWidget {
  @override
  _FriendViewState createState() => _FriendViewState();
}

class _FriendViewState extends State<FriendView> {

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
      ),
    );
  }


}
