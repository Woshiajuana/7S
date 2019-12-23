
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
  List<PhotoJsonModel> _arrRecommend;

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
                    new WowLoadView(
                      status: _arrRecommend == null,
                      child: _arrRecommend == null ? new Container() : new Column(
                        children: _arrRecommend.map((item) => _widgetPhotoCellItem(item)).toList(),
                      ),
                    ),
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
      height: 240.0,
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
    bool isSome = StateModel.of(context).user.id == userJsonModel?.id;
    bool isFollower = _photoJsonModel?.user?.follower != '' ?? false;
    return new Container(
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(
              child: new FlatButton(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 12.0),
                onPressed: ()  {
                  if (isSome) return null;
                  Application.router.push(context, 'friendInfo', params: { 'id': userJsonModel?.id });
                },
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
          isSome ? new Container() : new Container(
            width: 60.0,
            height: 26.0,
            decoration: new BoxDecoration(
              color: isFollower ? Color(0xffbbbbbb) : Application.config.style.mainColor,
              borderRadius: new BorderRadius.circular(2.0),
            ),
            child: new FlatButton(
              onPressed: () => _doFollowUpdate(userJsonModel),
              padding: const EdgeInsets.all(0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(Icons.add, size: 18.0, color: Colors.white),
                  new Text(
                    isFollower ? '已关注' : '关注',
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
        ],
      ),
    );
  }

  // 照片
  Widget _widgetPhotoCellItem (PhotoJsonModel photoJsonModel) {
    FileJsonModel fileJsonModel = photoJsonModel.photo;
    String imageUrl = '${fileJsonModel.base}${fileJsonModel.path}${fileJsonModel.filename}';
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                top: new BorderSide(
                  color: Color(0xffdddddd),
                  width: 0.5,
                ),
              ),
            ),
            child: new FlatButton(
              padding: const EdgeInsets.all(10.0),
              onPressed: () => this._reqPhotoInfo(id: photoJsonModel.id),
              child:  new Row(
                children: <Widget>[
                  new Container(
                    width: 120.0,
                    height: 77.0,
                    child: new Stack(
                      children: <Widget>[
                        new ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: new CachedNetworkImage(
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: imageUrl ?? '',
                            placeholder: (context, url) => new Image.asset(
                              Application.util.getImgPath('guide1.png'),
                            ),
                            errorWidget: (context, url, error) => new Image.asset(
                              Application.util.getImgPath('guide1.png'),
                            ),
                          ),
                        ),
                        new Container(
                          decoration: new BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            borderRadius: new BorderRadius.circular(6.0),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            photoJsonModel?.title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              fontSize: 14.0,
                              color: Color(0xff333333),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          new Expanded(flex: 1, child: new Container()),
                          new Text(
                            photoJsonModel?.user?.nickname ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Color(0xff999999),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          new SizedBox(height: 4.0),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Row(
                                children: <Widget>[
                                  new Icon(Icons.remove_red_eye, size: 14.0, color: Color(0xff999999)),
                                  new SizedBox(width: 2.0),
                                  new Text(
                                    photoJsonModel?.volume?.toString() ?? '0',
                                    style: new TextStyle(
                                      color: Color(0xff999999),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }

  // 获取照片详情
  void _reqPhotoInfo ({ String id }) async {
    String strId = id;
    if (strId == null) strId = widget.id;
    await Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqPhotoInfo;
        var data = await Application.util.http.post(strUrl, params: {
          'id': strId,
        }, useLoading: id != null);
        print(data);
        setState(() {
          _photoJsonModel = PhotoJsonModel.fromJson(data);
        });
        this._reqPhotoRecommend(strId, _photoJsonModel.user.id);
      } catch (err) {
        Application.util.modal.toast(err);
      }

    });
  }

  // 获取推荐
  void _reqPhotoRecommend (id, user) async {
    await Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqPhotoRecommend;
        List data = await Application.util.http.post(strUrl, params: {
          'exclude': [id],
          'limit': 10,
          'user': user,
        }, useLoading: false);
        setState(() {
          _arrRecommend = data.map((item) => PhotoJsonModel.fromJson(item)).toList();
        });
      } catch (err) {
        Application.util.modal.toast(err);
      }
    });
  }

  // 关注取消关注
  void _doFollowUpdate (UserJsonModel userJsonModel) async {
    try {
      String strUrl = Application.config.api.doFollowUpdate;
      var data = await Application.util.http.post(strUrl, params: {
        'id': userJsonModel?.id ?? '',
      });
      setState(() {
        _photoJsonModel.user.follower = data ?? '';
        _photoJsonModel.user.numFollower = (data ?? '') == '' ? _photoJsonModel.user.numFollower - 1 : _photoJsonModel.user.numFollower + 1;
      });
      Application.util.modal.toast((data ?? '') == '' ? '已取消关注' : '关注成功');
    } catch (err) {
      Application.util.modal.toast(err);
    }
  }

}
