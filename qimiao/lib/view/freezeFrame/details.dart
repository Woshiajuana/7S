
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class FreezeFrameDetailsView extends StatefulWidget {
  @override
  _FreezeFrameDetailsViewState createState() => _FreezeFrameDetailsViewState();
}

class _FreezeFrameDetailsViewState extends State<FreezeFrameDetailsView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '作品编辑',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          _widgetWorkSection(),
        ],
      ),
    );
  }

  // 作品
  Widget _widgetWorkSection () {
    return new Container(
      height: 180.0,
      child: new Stack(
        children: <Widget>[
          new Container(
            child: new Image.asset(
              Application.util.getImgPath('guide1.png'),
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          new Container(
            width: double.infinity,
            height: double.infinity,
            decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, .3),
            ),
            child: new FlatButton(
              onPressed: () => {},
              child: new Icon(Icons.play_circle_filled, size: 30.0, color: Colors.white)
            ),
          ),
        ],
      ),
    );
  }

  // 点赞


}
