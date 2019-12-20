import 'package:flutter/material.dart';

class NoticeDetailsView extends StatefulWidget {

  const NoticeDetailsView({
    this.title = '',
    this.content = '',
  });

  final String title;
  final String content;

  @override
  _NoticeDetailsViewState createState() => _NoticeDetailsViewState();
}

class _NoticeDetailsViewState extends State<NoticeDetailsView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 32.0),
      child: new Text(
        widget.content,
        style: new TextStyle(
          color: Color(0xff666666),
          fontSize: 14.0,
        ),
      ),
    );
  }

}
