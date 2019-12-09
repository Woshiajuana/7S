
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/model/model.dart';

class MineSignatureView extends StatefulWidget {

  MineSignatureView({
    this.signature,
  });

  final String signature;

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
    _strSignature = widget.signature ?? '';
    _signatureController = TextEditingController(text: _strSignature);
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
              onPressed: () => _handleSubmit(),
              padding: const EdgeInsets.all(0),
              child: new Text(
                '确认',
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

  // 提交
  void _handleSubmit () async {
    try {
      if (_strSignature == null || _strSignature == '')
        throw '点我干嘛?昵称你都没填...';
      Application.util.loading.show(context);
      String strUrl = Application.config.api.doUserUpdateInfo;
      Map<String, String> mapParams = { 'signature': _strSignature };
      await Application.util.http.post(strUrl, params: mapParams, useFilter: false);
      var state = StateModel.of(context);
      UserJsonModel userJsonModel = state.user;
      userJsonModel.signature = _strSignature;
      String userInfoJsonKey = Application.config.store.userJson;
      await Application.util.store.set(userInfoJsonKey, userJsonModel.toJson());
      state.setUserJsonModel(userJsonModel);
      Application.util.loading.hide();
      Application.util.modal.toast('修改成功');
      Application.router.pop(context);
    } catch (err) {
      Application.util.loading.hide();
      Application.util.modal.toast(err);
    }
  }

}
