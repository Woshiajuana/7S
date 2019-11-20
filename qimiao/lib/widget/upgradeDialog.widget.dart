import 'package:flutter/material.dart';

class UpgradeDialog extends StatefulWidget {

  const UpgradeDialog({Key key, this.content}) : super(key: key);

  final String content;

  @override
  _UpgradeDialogState createState() => new _UpgradeDialogState();
}

class _UpgradeDialogState extends State<UpgradeDialog> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      type: MaterialType.transparency,
      child: new Container(
        width: 100.0,
        height: 100.0,
        color: Colors.red,
      ),
    );
  }

  // 关闭按钮
  Widget _widgetCloseSection () {
    return new Positioned(
      left: 0,
      right: 0,
      bottom: 100.0,
      child: new Center(
        child: new Container(
          width: 40.0,
          height: 40.0,
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.white, width: 1.0),
            borderRadius: new BorderRadius.circular(30.0),
          ),
          child: new IconButton(
              padding: const EdgeInsets.all(0),
              icon: new Icon(Icons.close, color: Colors.white),
              onPressed: null
          ),
        ),
      ),
    );
  }

  // 内容主体
  Widget _widgetContentSection () {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          new Container(
            width: 300.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: new Column(
              children: <Widget>[
                // 输入
                _widgetContent(),
                // 按钮
                _widgetButtonSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetContent () {
    return new Container(
      margin: const EdgeInsets.only(top: 25.0, bottom: 25.0, left: 16.0, right: 16.0),
      child: new Center(
        child: new Text(
          widget.content ?? '',
          style: new TextStyle(
            color: Color(0xff2d2a34),
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _widgetButtonSection () {
    return new Container(
      height: 45.0,
      decoration: new BoxDecoration(
        border: new Border(
          top: new BorderSide(
            color: Color(0xfff0f0f0),
            width: 0.8,
          ),
        )
      ),
      child: new Row(
        children: <Widget>[
          _widgetButtonItem(
            text: '取消',
            color: Color(0xff6b6e73),
            border: true,
            onPressed: () => Navigator.of(context).pop(),
          ),
          _widgetButtonItem(
            text: '确认',
            color: Color(0xff3896ff),
            onPressed: () => _handleSure(),
          ),
        ],
      ),
    );
  }

  Widget _widgetButtonItem ({
    String text = '',
    Color color,
    bool border = false,
    dynamic onPressed,
  }) {
    return new Expanded(
      flex: 1,
      child: new FlatButton(
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
        child: new Container(
          decoration: new BoxDecoration(
            border: border ? new Border(
              right: new BorderSide(
                color: Color(0xfff0f0f0),
                width: 0.8,
              ),
            ) : null,
          ),
          height: 45.0,
          child: new Center(
            child: new Text(
              text,
              style: new TextStyle(
                fontSize: 14.0,
                color: color,
              ),
            ),
          ),
        ),
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
