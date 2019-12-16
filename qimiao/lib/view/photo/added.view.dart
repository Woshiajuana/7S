
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class PhotoAddView extends StatefulWidget {
  @override
  _PhotoAddViewState createState() => _PhotoAddViewState();
}

class _PhotoAddViewState extends State<PhotoAddView> {

  String _strEmail; // 邮箱

  TextEditingController _emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '作品编辑',
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
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          _widgetWorkSection(),
          _widgetInfoSection(),
          _widgetInputSection(
            controller: _emailController,
            hintText: '邮箱',
            value: _strEmail,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => setState(() => _strEmail = value),
            onClear: () { _emailController.clear(); setState(() => _strEmail = ''); },
            onEye: () => {},
          ),
          _widgetShareSection(),
        ],
      ),
    );
  }

  // 作品
  Widget _widgetWorkSection () {
    return new Container(
      height: 180.0,
      child: new Stack(
        children: <Widget>[
          new Container(
            child: new Image.asset(
              Application.util.getImgPath('guide1.png'),
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          new Container(
            width: double.infinity,
            height: double.infinity,
            decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, .3),
            ),
            child: new FlatButton(
              onPressed: () => {},
              child: new Icon(Icons.refresh, size: 40.0, color: Colors.white)
            ),
          ),
        ],
      ),
    );
  }

  // 点赞 播放次数
  Widget _widgetInfoSection () {
    return new Container(
      padding: const EdgeInsets.all(16.0),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            color: Color(0xffbbbbbb),
            width: 0.5,
          ),
        ),
      ),
      child: new Row(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Icon(Icons.live_tv, size: 16.0, color: Color(0xff999999)),
              new SizedBox(width: 2.0),
              new Text(
                '100',
                style: new TextStyle(
                  color: Color(0xff999999),
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          new SizedBox(width: 30.0),
          new Row(
            children: <Widget>[
              new Icon(Icons.thumb_up, size: 16.0, color: Color(0xff999999)),
              new SizedBox(width: 2.0),
              new Text(
                '100',
                style: new TextStyle(
                  color: Color(0xff999999),
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // input
  Widget _widgetInputSection ({
    TextEditingController controller,
    Widget child,
    String hintText = '',
    bool isObscure = false,
    String value = '',
    bool useEye = false,
    TextInputType keyboardType,
    dynamic onChanged,
    dynamic onClear,
    dynamic onEye,
  }) {
    return new Container(
      height: 50.0,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            color: Color(0xffcccccc),
            width: 0.5,
          ),
        ),
      ),
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new TextField(
              controller: controller,
              obscureText: isObscure,
              keyboardType: keyboardType,
              decoration: new InputDecoration(
                hintText: hintText,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
          new Offstage(
            offstage: (value == '' || value == null),
            child: new IconButton(
              icon: new Icon(Icons.clear, size: 20.0, color: Color(0xff666666)),
              onPressed: onClear,
            ),
          ),
          useEye ? new IconButton(
            icon: new Icon(Icons.remove_red_eye, size: 20.0, color: isObscure ? Color(0xff666666) : Application.config.style.mainColor),
            onPressed: onEye,
          ) : new Container(),
          child ?? new Container(),
        ],
      ),
    );
  }

  bool check = false;

  // 分享到世界按钮
  Widget _widgetShareSection () {
    return new Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            '添加到世界',
            style: new TextStyle(
              color: Color(0xff666666),
              fontSize: 16.0,
            ),
          ),
          new Switch(
            value: this.check,
            activeColor: Application.config.style.mainColor,     // 激活时原点颜色
            onChanged: (bool val) {
              this.setState(() {
                this.check = !this.check;
              });
            },
          )
        ],
      ),
    );
  }
}
