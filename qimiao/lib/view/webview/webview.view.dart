import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {

  const WebView({
    this.title = '',
    this.url = '',
  });

  final String title;
  final String url;

  @override
  _WebViewState createState() => new _WebViewState();
}

class _WebViewState extends State<WebView> {

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
      appBar: new AppBar(
//        leading: _isIndex ? new Container() : new FlatButton(
//          onPressed: () => _flutterWebviewPlugin.goBack(),
//          child: new Icon(Icons.arrow_back, color: Colors.white),
//        ),
        title: new Text(
          _stringTitle,
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
//        centerTitle: true,
        actions: <Widget>[
          new GestureDetector(
            onTap: () => _flutterWebviewPlugin.reload(),
            child: new Container(
              padding: const EdgeInsets.only(right: 10.0),
              child: new Center(
                child: new Text(
                  '刷新',
                  style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //获取h5页面标题
  void _getWebTitle() async {
    _stringTitle = await _flutterWebviewPlugin.evalJavascript('window.document.title');
    _stringTitle = _stringTitle.replaceAll('"', '') ?? widget.title;
    setState(() {});
  }

}