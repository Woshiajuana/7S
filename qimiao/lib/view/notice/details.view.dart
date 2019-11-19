import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class NoticeDetailsView extends StatefulWidget {

  const NoticeDetailsView({
    this.title = '',
  });

  final String title;

  @override
  _NoticeDetailsViewState createState() => _NoticeDetailsViewState();
}

class _NoticeDetailsViewState extends State<NoticeDetailsView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          widget.title,
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          _widgetContentSection(),
        ],
      ),
    );
  }

  Widget _widgetContentSection () {
    return new Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0, bottom: 32.0),
      child: new Text(
        '在 MaterialPageRoute 里面设置属性 fullscreenDialog = true，不知道能不能满足你的需求，另，你可以自定义实现一个 Widget 继承自 PageRoute 来自定义动画。在 MaterialPageRoute 里面设置属性 fullscreenDialog = true，不知道能不能满足你的需求，另，你可以自定义实现一个 Widget 继承自 PageRoute 来自定义动画。在 MaterialPageRoute 里面设置属性 fullscreenDialog = true，不知道能不能满足你的需求，另，你可以自定义实现一个 Widget 继承自 PageRoute 来自定义动画。在 MaterialPageRoute 里面设置属性 fullscreenDialog = true，不知道能不能满足你的需求，另，你可以自定义实现一个 Widget 继承自 PageRoute 来自定义动画。在 MaterialPageRoute 里面设置属性 fullscreenDialog = true，不知道能不能满足你的需求，另，你可以自定义实现一个 Widget 继承自 PageRoute 来自定义动画。',
        style: new TextStyle(
          color: Color(0xff666666),
          fontSize: 14.0,
        ),
      ),
    );
  }

}
