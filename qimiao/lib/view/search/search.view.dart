
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  String _strKeyword;
  TextEditingController _keywordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _keywordController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new WowAppBar(
        color: Application.config.style.mainColor,
        child: _widgetSearchSection(
          controller: _keywordController,
          icon: new Icon(Icons.search, size: 18.0, color: Color(0xff999999)),
          hintText: '搜索你想要的吧...',
          value: _strKeyword,
          onChanged: (value) => setState(() => _strKeyword = value),
          onClear: () { _keywordController.clear(); setState(() => _strKeyword = ''); },
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              // 默认推荐 历史搜索等
              _widgetRecommendSection(),

            ],
          ),
        ],
      ),
    );
  }

  // 搜索
  Widget _widgetSearchSection ({
    TextEditingController controller,
    Widget icon,
    String hintText = '',
    bool isObscure = false,
    String value = '',
    bool useEye = false,
    dynamic onChanged,
    dynamic onClear,
  }) {
    return new Container(
      height: 56,
      child: new Row(
        children: <Widget>[
          new SizedBox(width: 16.0),
          new Expanded(
            flex: 1,
            child: new Container(
              height: 30.0,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new SizedBox(width: 6.0),
                  new Container(
                    alignment: Alignment.center,
                    width: 30.0,
                    height: 30.0,
                    child: icon,
                  ),
                  new SizedBox(width: 3.0),
                  new Expanded(
                    flex: 1,
                    child: new TextField(
                      controller: controller,
                      obscureText: isObscure,
                      style: new TextStyle(
                        color: Color(0xff999999),
                        fontSize: 13.0,
                      ),
                      decoration: new InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
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
                    child: new InkWell(
                      child: new Icon(Icons.clear, size: 20.0, color: Color(0xff666666)),
                      onTap: onClear,
                    ),
                  ),
                  new SizedBox(width: 10.0),
                ],
              ),
            ),
          ),
          new Container(
            width: 70.0,
            child: new FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: new Text(
                '取消',
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
    );
  }

  // 推荐
  Widget _widgetRecommendSection () {

    Widget _widgetKeywordItem () {
      return new Container(
        decoration: new BoxDecoration(
          color: Color(0xffeeeeee),
          borderRadius: new BorderRadius.circular(2.0),
        ),
        margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0, bottom: 5.0),
        child: new InkWell(
          onTap: () => {},
          child: new Text(
            '按钮按钮',
            style: new TextStyle(
              color: Color(0xff333333),
              fontSize: 14.0,
            ),
          ),
        ),
      );
    }

    //
    Widget _widgetKeywordCell () {
      return new Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    '标题',
                    style: new TextStyle(
                      fontSize: 12.0,
                      color: Color(0xff333333),
                    ),
                  ),
                  new InkWell(
                    onTap: () => {},
                    child: new Icon(Icons.delete, size: 18.0, color: Color(0xff999999)),
                  ),
                ],
              ),
            ),
            new SizedBox(height: 12.0),
            new Wrap(
              children: <Widget>[
                _widgetKeywordItem(),
                _widgetKeywordItem(),
                _widgetKeywordItem(),
                _widgetKeywordItem(),
                _widgetKeywordItem(),
              ],
            ),
          ],
        ),
      );
    }

    return new Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 16.0, right: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _widgetKeywordCell(),
          _widgetKeywordCell(),
          _widgetKeywordCell(),
        ],
      ),
    );
  }
}
