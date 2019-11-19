import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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

  FlutterWebviewPlugin _flutterWebviewPlugin;
  String _stringTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stringTitle = widget.title;
    _flutterWebviewPlugin = new FlutterWebviewPlugin();
    _flutterWebviewPlugin.onUrlChanged.listen((String url) {
      _getWebTitle();
    });
  }

  @override
  void dispose() {
    _flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WebviewScaffold(
      url: widget.url,
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
      bottomNavigationBar: new Container(color: Color(0x11ffffff), width: 100, height: 100,),
      appBar: new AppBar(
        title: new Text(
          _stringTitle,
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
//        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.more_horiz), onPressed: () => _handleShowDialog()),
//          new GestureDetector(
//            onTap: () => _flutterWebviewViewPlugin.reload(),
//            child: new Container(
//              padding: const EdgeInsets.only(right: 10.0),
//              child: new Center(
//                child: new Text(
//                  '刷新',
//                  style: new TextStyle(
//                    fontSize: 14.0,
//                    color: Colors.white,
//                  ),
//                ),
//              ),
//            ),
//          ),
        ],
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
  void _getWebTitle() async {
    _stringTitle = await _flutterWebviewPlugin.evalJavascript('window.document.title');
    _stringTitle = _stringTitle.replaceAll('"', '') ?? widget.title;
    setState(() {});
  }

}