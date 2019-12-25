
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:qimiao/model/model.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  String _strKeyword;
  TextEditingController _keywordController;

  List<UserJsonModel> _arrUserData;
  List<PhotoJsonModel> _arrPhotoData;

  String _strShowView = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _strKeyword = '';
    _keywordController = TextEditingController(text: _strKeyword);
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
          onSubmitted: (value) {
            setState(() {
              _strShowView = 'result';
            });
            this._handleSearchPreview();
          },
          onChanged: (value) {
            setState(() {
              _strKeyword = value;
              if (_strKeyword == '') {
                _strShowView = '';
              } else {
                _strShowView = 'preview';
                this._handleSearchPreview();
              }
            });
          },
          onClear: () {
            _keywordController.clear();
            setState(() {
              _strKeyword = '';
              _strShowView = '';
            });
          },
        ),
      ),
      body: new Stack(
        children: <Widget>[
          // 默认推荐 历史搜索等
          _widgetRecommendSection(),
          // 预览
          new Offstage(
            offstage: !(_strShowView == 'preview'),
            child: _widgetPreviewSection(),
          ),
          // 结果
          new Offstage(
            offstage: !(_strShowView == 'result'),
            child: _widgetResultSection(),
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
    dynamic onSubmitted,
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
                      onSubmitted: onSubmitted,
                      autofocus: true,
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
            width: 50.0,
            child: new FlatButton(
              padding: const EdgeInsets.all(0),
              onPressed: () => Navigator.of(context).pop(),
              child: new Text(
                '取消',
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
      child: new ListView(
        children: <Widget>[
          _widgetKeywordCell(),
          _widgetKeywordCell(),
          _widgetKeywordCell(),
        ],
      ),
    );
  }

  // 检索关键字
  Widget _widgetPreviewSection () {
    Widget _widgetPreviewItem ({
      String text,
      dynamic onPressed,
    }) {
      return new Container(
        height: 44.0,
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
            bottom: new BorderSide(
              color: Color(0xffdddddd),
              width: 0.5,
            ),
          ),
        ),
        child: new FlatButton(
          onPressed: onPressed,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                    color: Color(0xff666666),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                flex: 1),
              new Icon(Icons.arrow_forward_ios, size: 18.0, color: Color(0xff999999)),
            ],
          ),
        ),
      );
    }
    List<Widget> arrWidget = [];
    if (_arrUserData != null) {
      arrWidget.addAll(_arrUserData.map((UserJsonModel item) => _widgetPreviewItem(
        text: '用户：${item?.nickname}',
        onPressed: () => Application.router.push(context, 'friendInfo', params: { 'id': item?.id }),
      )).toList());
    }
    if (_arrPhotoData != null) {
      arrWidget.addAll(_arrPhotoData.map((PhotoJsonModel item) => _widgetPreviewItem(
        text: '作品：${item?.title}',
        onPressed: () => Application.router.push(context, 'photoDetails', params: { 'id': item.id }),
      )).toList());
    }
    return new Container(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      child: new ListView(
        children: arrWidget,
      ),
    );
  }

  // 结果
  Widget _widgetResultSection () {

    // 用户
    Widget _widgetUserCell() {
      return new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
            bottom: new BorderSide(
              color: Color(0xffdddddd),
              width: 0.5,
            ),
          ),
        ),
        child: new Row(
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: new Container(
                height: 60.0,
                child: new FlatButton(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
                  onPressed: () => Application.router.push(context, 'friendInfo'),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        width: 36.0,
                        height: 36.0,
                        child: new ClipRRect(
                          borderRadius: BorderRadius.circular(36.0),
                          child: new Image.asset(
                            Application.util.getImgPath('guide1.png'),
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      new SizedBox(width: 16.0),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            '我是阿倦啊',
                            style: new TextStyle(
                              color: Color(0xff333333),
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                          ),
                          new Text(
                            '粉丝：1000',
                            style: new TextStyle(
                              color: Color(0xff999999),
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            new SizedBox(width: 16.0),
            new Container(
              width: 60.0,
              height: 26.0,
              decoration: new BoxDecoration(
                color: Application.config.style.mainColor,
                borderRadius: new BorderRadius.circular(2.0),
              ),
              child: new FlatButton(
                onPressed: () => {},
                padding: const EdgeInsets.all(0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.add, size: 18.0, color: Colors.white),
                    new Text(
                      '关注',
                      style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new SizedBox(width: 16.0),
          ],
        ),
      );
    }
    return new Container(
      color: Application.config.style.backgroundColor,
      child: new ListView(
        children: <Widget>[
          _widgetUserCell(),
          new SizedBox(height: 10.0),
          _widgetResultCell(),
        ],
      ),
    );
  }

  // 推荐
  Widget _widgetResultCell () {
    return new Column(
      children: <Widget>[
        _widgetVideoCellItem(),
        _widgetVideoCellItem(),
        _widgetVideoCellItem(),
        _widgetVideoCellItem(),
        _widgetVideoCellItem(),
      ],
    );
  }

  Widget _widgetVideoCellItem () {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                top: new BorderSide(
                  color: Color(0xffdddddd),
                  width: 0.5,
                ),
                bottom: new BorderSide(
                  color: Color(0xffdddddd),
                  width: 0.5,
                ),
              ),
            ),
            child: new Row(
              children: <Widget>[
                new Container(
                  width: 120.0,
                  height: 77.0,
                  child: new Stack(
                    children: <Widget>[
                      new ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: new Image.asset(
                          Application.util.getImgPath('guide1.png'),
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      new Container(
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          borderRadius: new BorderRadius.circular(6.0),
                        ),
                      ),
                    ],
                  ),
                ),
                new SizedBox(width: 10.0),
                new Expanded(
                  flex: 1,
                  child: new Container(
                    height: 77.0,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          '初始预售普吉岛扫地机阿三破搭配师激动啊上坡',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Color(0xff333333),
                          ),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Icon(Icons.live_tv, size: 14.0, color: Color(0xff999999)),
                                new SizedBox(width: 2.0),
                                new Text(
                                  '100',
                                  style: new TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new Icon(Icons.thumb_up, size: 14.0, color: Color(0xff999999)),
                                new SizedBox(width: 2.0),
                                new Text(
                                  '100',
                                  style: new TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            new Container(
                              height: 20.0,
                              width: 20.0,
                              child: new FlatButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () => _handleOperate(),
                                  child: new Icon(Icons.more_vert, size: 18.0, color: Color(0xff999999))
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 操作
  void _handleOperate () {
    showDialog(
      context: context,
      barrierDismissible: true,//是否点击空白区域关闭对话框,默认为true，可以关闭
      builder: (BuildContext context) {
        return new ActionSheetDialog(
          arrOptions: [
            {
              'text': '分享',
              'onPressed': () {
                print('相册1');
              },
            },
            {
              'text': '举报',
              'onPressed': () => print('拍照'),
            },
          ],
        );
      },
    );
  }

  // 搜索预览
  void _handleSearchPreview () async {
    await Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqSearchPreview;
        var data = await Application.util.http.post(strUrl, params: {
          'keyword': _strKeyword,
        }, useLoading: false);
        setState(() {
          _arrUserData = List<UserJsonModel>.from(data['arrUser'].map((item) => UserJsonModel.fromJson(item)).toList());
          _arrPhotoData = List<PhotoJsonModel>.from(data['arrPhoto'].map((item) => PhotoJsonModel.fromJson(item)).toList());
        });
      } catch (err) {
        Application.util.modal.toast(err);
      }
    });
  }

}
