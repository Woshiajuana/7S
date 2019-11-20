import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class UpgradeDialog extends StatefulWidget {

  const UpgradeDialog({Key key, this.arrContent}) : super(key: key);

  final List<String> arrContent;

  @override
  _UpgradeDialogState createState() => new _UpgradeDialogState();
}

class _UpgradeDialogState extends State<UpgradeDialog> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      type: MaterialType.transparency,
      child: new Stack(
        children: <Widget>[
          new Align(
            child: new Container(
              width: 300.0,
              child: new Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  _widgetContentSection(),
                  _widgetHeaderSection(),
                ],
              ),
            ),
          ),
          _widgetCloseSection(),
        ],
      ),
    );
  }
  // 头部图片
  Widget _widgetHeaderSection () {
    return new Positioned(
      left: 0,
      right: 0,
      top: -30.0,
      child: new Center(
        child: new Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(180.0),
          ),
          child: new Image.asset(
            Application.util.getImgPath('logo-300'),
            width: 120.0,
            height: 120.0,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  // 关闭按钮
  Widget _widgetCloseSection () {
    return new Positioned(
      left: 0,
      right: 0,
      bottom: 70.0,
      child: new Center(
        child: new Container(
          width: 40.0,
          height: 40.0,
          decoration: new BoxDecoration(
            border: new Border.all(color: Color(0xffcccccc), width: 1.0),
            borderRadius: new BorderRadius.circular(30.0),
          ),
          child: new IconButton(
            padding: const EdgeInsets.all(0),
            icon: new Icon(Icons.close, color: Color(0xffcccccc)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
    );
  }

  // 内容主体
  Widget _widgetContentSection () {

    List<String> _arrContent = widget.arrContent ?? [];

    // 立即更新 or 进度条
    Widget _widgetButtonItem () {
      return new Container(
        width: 220.0,
        height: 40.0,
        margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        decoration: new BoxDecoration(
          color: Application.config.style.mainColor,
          borderRadius: new BorderRadius.circular(20.0),
        ),
        child: new FlatButton(
          onPressed: () => print(2),
          child: new Text(
            '立即更新',
            style: new TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      );
    }

    return new Container(
      width: 300.0,
      height: 300.0,
      padding: const EdgeInsets.only(top: 100.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: new Column(
        children: <Widget>[
          new Text(
            '哦豁~发现新版本了...',
            style: new TextStyle(
              color: Color(0xff333333),
              fontSize: 18.0,
            ),
          ),
          new SizedBox(height: 20.0),
          new Expanded(
            flex: 1,
            child: new Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: new ListView(
                children: _arrContent.map((item) => new Text(
                  item??'',
                  style: new TextStyle(
                    color: Color(0xff666666),
                  ),
                )).toList(),
              ),
            ),
          ),
          new Container(
            width: 220.0,
            height: 40.0,
            margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            decoration: new BoxDecoration(
              color: Application.config.style.mainColor,
              borderRadius: new BorderRadius.circular(20.0),
            ),
            child: new FlatButton(
              onPressed: () => print(2),
              child: new Text(
                '立即更新',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleSure () async {
    try {
      Navigator.of(context).pop(true);
    } catch (err) {
    }
  }

}
