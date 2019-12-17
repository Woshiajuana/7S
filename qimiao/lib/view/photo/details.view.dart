
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:qimiao/model/model.dart';
import "package:intl/intl.dart";

class PhotoDetailsView extends StatefulWidget {

  PhotoDetailsView({
    this.id,
  });

  final String id;

  @override
  _PhotoDetailsViewState createState() => _PhotoDetailsViewState();
}

class _PhotoDetailsViewState extends State<PhotoDetailsView> {

  PhotoJsonModel _photoJsonModel;

  @override
  void initState() {
    super.initState();
    this._reqPhotoInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new WowScrollerInfo(
        maxExtent: 100.0,
        builder: (BuildContext context, double shrinkOffset, int alpha) {
          return new Stack(
            children: <Widget>[
              new WowLoadView(
                status: _photoJsonModel == null,
                child: _photoJsonModel == null ? new Container() : new ListView(
                  padding: const EdgeInsets.all(0),
                  children: <Widget>[
                    _widgetWorkSection(),
                    // 用户
                    _widgetUserSection(),
                    // 标题
                    _widgetInfoSection(),
                    new SizedBox(height: 10.0),
                    // 推荐
                    _widgetRecommendSection(),
                  ],
                ),
              ),
              _widgetAppBarSection(shrinkOffset: shrinkOffset, alpha: alpha),
            ],
          );
        },
      ),
    );
  }

  // 作品
  Widget _widgetWorkSection () {
    String strPath;
    if (_photoJsonModel != null) {
      FileJsonModel fileJsonModel = _photoJsonModel.photo;
      strPath = '${fileJsonModel.base}${fileJsonModel.path}${fileJsonModel.filename}';
    }
    return new Container(
      height: 180.0,
      child: new Stack(
        children: <Widget>[
          new Container(
            child: new CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              imageUrl: strPath ?? '',
              placeholder: (context, url) => new Image.asset(
                Application.util.getImgPath('guide1.png'),
              ),
              errorWidget: (context, url, error) => new Image.asset(
                Application.util.getImgPath('guide1.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 导航条
  Widget _widgetAppBarSection ({
    double shrinkOffset,
    int alpha,
  }) {
    return new Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: new Container(
        color: Color.fromARGB(alpha, 236, 100, 47),
        child: new SafeArea(
          bottom: false,
          child: new Container(
            height: 56.0,
            child: new Row(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.arrow_back,
                    color: shrinkOffset <= 50 ? Colors.white : Color.fromARGB(alpha, 255, 255, 255),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                new SizedBox(width: 24.0),
                new Expanded(
                  flex: 1,
                  child: new Text(
                    _photoJsonModel?.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      color: shrinkOffset <= 50 ? Colors.transparent : Color.fromARGB(alpha, 255, 255, 255),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 用户
  Widget _widgetUserSection () {
    UserJsonModel userJsonModel = _photoJsonModel?.user;
    return new Container(
      color: Colors.white,
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
                        child: new CachedNetworkImage(
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: userJsonModel?.avatar ?? '',
                          placeholder: (context, url) => new Image.asset(
                            Application.util.getImgPath('guide1.png'),
                          ),
                          errorWidget: (context, url, error) => new Image.asset(
                            Application.util.getImgPath('guide1.png'),
                          ),
                        ),
                      ),
                    ),
                    new SizedBox(width: 16.0),
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          userJsonModel?.nickname ?? '',
                          style: new TextStyle(
                            color: Color(0xff333333),
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                        ),
                        new Text(
                          '粉丝：${userJsonModel?.numFollower ?? 0}',
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

  // 标题
  Widget _widgetInfoSection () {
    print('_photoJsonModel => $_photoJsonModel');
    return new Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
      color: Colors.white,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            _photoJsonModel?.title ?? '',
            style: new TextStyle(
              color: Color(0xff333333),
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
          ),
          new SizedBox(height: 10.0),
          new Row(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Icon(Icons.remove_red_eye, size: 14.0, color: Color(0xffbbbbbb)),
                  new SizedBox(width: 2.0),
                  new Text(
                    _photoJsonModel?.volume?.toString() ?? '0',
                    style: new TextStyle(
                      color: Color(0xffbbbbbb),
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              new Expanded(flex: 1, child: new Container()),
              new Row(
                children: <Widget>[
                  new Icon(Icons.av_timer, size: 14.0, color: Color(0xffbbbbbb)),
                  new SizedBox(width: 2.0),
                  new Text(
                    new DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(_photoJsonModel.created_at).toLocal()),
                    style: new TextStyle(
                      color: Color(0xffbbbbbb),
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          new SizedBox(height: 20.0),
          new Row(
            children: <Widget>[
              new Container(
                width: 50.0,
                height: 50.0,
                margin: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  onPressed: () => {},
                  padding: const EdgeInsets.all(0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(
                        Icons.thumb_up,
                        color: Color(0xff999999),
                      ),
                      new SizedBox(height: 3.0),
                      new Text(
                        '100',
                        style: new TextStyle(
                          color: Color(0xff999999),
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                width: 50.0,
                height: 50.0,
                margin: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  onPressed: () => {},
                  padding: const EdgeInsets.all(0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(
                        Icons.thumb_down,
                        color: Color(0xff999999),
                      ),
                      new SizedBox(height: 3.0),
                      new Text(
                        '不喜欢',
                        style: new TextStyle(
                          color: Color(0xff999999),
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                width: 50.0,
                height: 50.0,
                margin: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  onPressed: () => {},
                  padding: const EdgeInsets.all(0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(
                        Icons.favorite,
                        color: Color(0xff999999),
                      ),
                      new SizedBox(height: 3.0),
                      new Text(
                        '100',
                        style: new TextStyle(
                          color: Color(0xff999999),
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 推荐
  Widget _widgetRecommendSection () {
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

  // 获取照片详情
  void _reqPhotoInfo () async {
    await Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqPhotoInfo;
        var data = await Application.util.http.post(strUrl, params: {
          'id': widget.id,
        }, useLoading: false);
        print(data);
        setState(() {
          _photoJsonModel = PhotoJsonModel.fromJson(data);
        });
      } catch (err) {
        Application.util.modal.toast(err);
      }
    });
  }
}
