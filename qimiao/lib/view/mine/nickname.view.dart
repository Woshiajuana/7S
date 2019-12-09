
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/model/model.dart';

class MineNicknameView extends StatefulWidget {

  MineNicknameView({
    this.nickname,
  });

  final String nickname;

  @override
  _MineNicknameViewState createState() => _MineNicknameViewState();
}

class _MineNicknameViewState extends State<MineNicknameView> {

  String _strNickname;
  TextEditingController _nicknameController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('1${widget.nickname}');
    _strNickname = widget.nickname ?? '';
    _nicknameController = TextEditingController(text: _strNickname);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<StateModel>(
      builder: (context, child, model) {
        return new Scaffold(
          backgroundColor: Application.config.style.backgroundColor,
          appBar: new AppBar(
            elevation: 0,
            title: new Text(
              '修改昵称',
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
      },
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
            controller: _nicknameController,
            style: new TextStyle(
              fontSize: 14.0,
            ),
            maxLength: 10,
            decoration: new InputDecoration(
              hintText: '汉字/字母/数字，符号表情党你奏凯...',
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            onChanged: (value) => setState(() => _strNickname = value),
          ),
          new Positioned(
            right: 0,
            top: 0,
            child: new Offstage(
              offstage: (_strNickname == '' || _strNickname == null),
              child: new IconButton(
                icon: new Icon(Icons.clear, size: 20.0, color: Color(0xff666666)),
                onPressed: () { _nicknameController.clear(); setState(() => _strNickname = ''); },
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
                  '好昵称不赶紧下手，等着被别人抢吗？',
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
      if (_strNickname == null || _strNickname == '')
        throw '点我干嘛?昵称你都没填...';
      String strUrl = Application.config.api.doUserUpdateInfo;
      Map<String, String> mapParams = { 'nickname': _strNickname };
      await Application.util.http.post(strUrl, params: mapParams);
      var state = StateModel.of(context);
      UserJsonModel userJsonModel = state.user;
      userJsonModel.nickname = _strNickname;
      String userInfoJsonKey = Application.config.store.userJson;
      await Application.util.store.set(userInfoJsonKey, userJsonModel.toJson());
      state.setUserJsonModel(userJsonModel);
      Application.util.modal.toast('修改成功');
      Application.router.pop(context);
    } catch (err) {
      Application.util.modal.toast(err);
    }
  }

}
