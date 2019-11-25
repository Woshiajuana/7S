
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class MineSignatureView extends StatefulWidget {
  @override
  _MineSignatureViewState createState() => _MineSignatureViewState();
}

class _MineSignatureViewState extends State<MineSignatureView> {

  String _strSignature;
  TextEditingController _signatureController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signatureController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '个性签名',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: <Widget>[
          new Container(
            width: 70.0,
            child: new FlatButton(
              onPressed: () => {},
              padding: const EdgeInsets.all(0),
              child: new Text(
                '保存',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          _widgetInputSection(),
          _widgetPromptSection(),
        ],
      ),
    );
  }

  // 输入框
  Widget _widgetInputSection () {
    return new Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: new Stack(
        children: <Widget>[
          new TextField(
            controller: _signatureController,
            style: new TextStyle(
              fontSize: 14.0,
            ),
            maxLength: 20,
            decoration: new InputDecoration(
              hintText: '一句话介绍自己个，符号表情党你奏凯...',
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            onChanged: (value) => setState(() => _strSignature = value),
          ),
          new Positioned(
            right: 0,
            top: 0,
            child: new Offstage(
              offstage: (_strSignature == '' || _strSignature == null),
              child: new IconButton(
                icon: new Icon(Icons.clear, size: 20.0, color: Color(0xff666666)),
                onPressed: () { _signatureController.clear(); setState(() => _strSignature = ''); },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 提示文案
  Widget _widgetPromptSection () {
    return new Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.only(top: 2.0),
            child: new Icon(Icons.info, color: Application.config.style.mainColor, size: 15.0),
          ),
          new SizedBox(width: 5.0),
          new Expanded(
            flex: 1,
            child: new Wrap(
              children: <Widget>[
                new Text(
                  '什么？20个字不够形容自己个的帅气？就不能精简下？',
                  style: new TextStyle(
                    fontSize: 12.0,
                    color: Color(0xff999999),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
