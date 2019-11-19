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
      appBar: new AppBar(
        title: new Text(
          _stringTitle,
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.refresh), onPressed: () => _flutterWebviewPlugin.reload()),
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