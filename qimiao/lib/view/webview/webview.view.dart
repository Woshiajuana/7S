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
//    _flutterWebviewPlugin = new FlutterWebviewPlugin();
//    _flutterWebviewPlugin.onUrlChanged.listen((String url) {
//      _getWebTitle();
//    });
  }

  @override
  void dispose() {
//    _flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WebviewScaffold(
      url: "https://www.baidu.com",
      appBar: new AppBar(
        title: new Text("Widget webview"),
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