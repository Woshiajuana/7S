import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewView extends StatefulWidget {

  const WebviewView({
    this.title = '',
    this.url = '',
  });

  final String title;
  final String url;

  @override
  _WebviewViewState createState() => new _WebviewViewState();
}

class _WebviewViewState extends State<WebviewView> {

  String _stringTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stringTitle = widget.title;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          _stringTitle,
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.more_horiz), onPressed: () => _handleShowDialog()),
        ],
      ),
      body: new WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,///JS执行模式
      ),
    );
  }

  // 呼出底部弹窗
  void _handleShowDialog () {

    showDialog(
      barrierDismissible: true,//是否点击空白区域关闭对话框,默认为true，可以关闭
      context: context,
      builder: (BuildContext context) {
        return new Material(
          type: MaterialType.transparency,
          child: new Column(
            children: <Widget>[
              new Expanded(flex: 1, child: new Container()),
              new Container(
                child: new FlatButton(
                  onPressed: () => {},
                  child: new Text(
                    '取消',
                    style: new TextStyle(
                      color: Color(0xff999999),
                      fontSize: 16.0
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }


  //获取h5页面标题

}