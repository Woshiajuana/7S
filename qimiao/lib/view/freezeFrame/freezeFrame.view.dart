
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:date_utils/date_utils.dart';
import 'package:qimiao/model/model.dart';
import 'package:intl/intl.dart';
import 'package:qimiao/common/utils/date.util.dart';

class FreezeFrameView extends StatefulWidget {
  @override
  _FreezeFrameViewState createState() => _FreezeFrameViewState();
}

class _FreezeFrameViewState extends State<FreezeFrameView> with TickerProviderStateMixin {

  //这里就是关键的代码，定义一个key
  GlobalKey<WowCalendarState> _childViewKey;
  DateTime _dateTime;
  List<PhotoJsonModel> _arrPhotoData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateTime = DateTime.now();
    _childViewKey = new GlobalKey<WowCalendarState>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        title: new Row(
          children: <Widget>[
            new IconButton(
              icon: new Icon(Icons.arrow_back_ios, size: 18.0, color: Colors.white),
              onPressed: () => _childViewKey.currentState.previousMonth(),
            ),
            new Text(
              DateFormat('yyyy/MM').format(_dateTime),
              style: new TextStyle(
                fontSize: 18.0,
              ),
            ),
            new IconButton(
              icon: new Icon(Icons.arrow_forward_ios, size: 18.0, color: Colors.white),
              onPressed: () => _childViewKey.currentState.nextMonth(),
            ),
          ],
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.help, color: Colors.white),
            onPressed: () => _handleHelp(),
          )
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new WowCalendar(
            key: _childViewKey,
            onSelected: (DateTime day, List<DateTime> arrDay) {
              if (day != null) {
                setState(() {
                  _dateTime = day;
                });
              }
              this._reqPhotoList(arrDay);
            },
            dayBuilder: _handleDayBuilder,
          ),
          _widgetContentSection(),
        ],
      ),
    );
  }

  // 渲染
  Widget _handleDayBuilder (BuildContext context, DateTime day, bool isSelected) {
    bool isAfter = day.isAfter(new DateTime.now());
    PhotoJsonModel photoJsonModel;
    String imageUrl;
    if (_arrPhotoData != null) {
      _arrPhotoData.forEach((item) {
        bool isSameDay = DateUtil.isSameDay(DateTime.parse(item.created_at).toLocal(), day);
        if (isSameDay) photoJsonModel = item;
      });
      if (photoJsonModel != null) {
        FileJsonModel fileJsonModel = photoJsonModel.photo;
        imageUrl = '${fileJsonModel.base}${fileJsonModel.path}${fileJsonModel.filename}';
      }
    }
    return new Container(
      margin: const EdgeInsets.all(5.0),
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          imageUrl == null ? new Container() : new ClipOval(
            child: new CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              imageUrl: imageUrl ?? '',
              placeholder: (context, url) => new Image.asset(
                Application.util.getImgPath('mine_head_bg.png'),
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => new Image.asset(
                Application.util.getImgPath('mine_head_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Offstage(
            offstage: imageUrl == null,
            child: new Container(
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
          ),
          new Offstage(
            offstage: !isSelected,
            child: new Container(
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          new Text(
            Utils.formatDay(day).toString(),
            style: new TextStyle(color: imageUrl != null || isSelected ? Colors.white : isAfter ? Color(0xffbbbbbb) : Color(0xff333333)),
          ),
        ],
      ),
    );
  }

  // 内容
  Widget _widgetContentSection () {
    PhotoJsonModel photoJsonModel;
    String imageUrl;
    if (_arrPhotoData != null) {
      _arrPhotoData.forEach((item) {
        bool isSameDay = DateUtil.isSameDay(DateTime.parse(item.created_at).toLocal(), _dateTime);
        if (isSameDay) photoJsonModel = item;
      });
      if (photoJsonModel != null) {
        FileJsonModel fileJsonModel = photoJsonModel.photo;
        imageUrl = '${fileJsonModel.base}${fileJsonModel.path}${fileJsonModel.filename}';
      }
    }
    String strDate = DateFormat('yyyy/MM/dd').format(_dateTime);
    return new Container(
      margin: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Icon(Icons.access_time, size: 20.0),
              new SizedBox(width: 8.0),
              new Text(
                strDate,
                style: new TextStyle(
                    color: Color(0xff333333),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          new Container(
            height: 160.0,
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            width: double.infinity,
            child: new Stack(
              children: <Widget>[
                new Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: new CachedNetworkImage(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: imageUrl ?? '',
                    placeholder: (context, url) => new Container(
                      color: Color(0xff999999),
                    ),
                    errorWidget: (context, url, error) => new Container(
                      color: Color(0xff999999),
                    ),
                  ),
                ),
                new Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: new Container(
                    height: 100.0,
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x00000000),
                          Color(0x90000000),
                        ],
                      ),
                    ),
                  ),
                ),
                new Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, .3),
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(255, 255, 255, 0.2),
                        ),
                        child: new IconButton(
                          icon: new Icon(Icons.camera_enhance, color: Colors.white),
                          onPressed: () async {
                            PhotoJsonModel data = await Application.router.push(context, 'photoAdded', params: {
                              'title': photoJsonModel == null ? '新增照片-${strDate}' : '编辑照片-${strDate}',
                              'data': photoJsonModel,
                              'createdAt': strDate,
                            });
                            if (data != null) {
                              setState(() {
                                if (photoJsonModel != null) {
                                  _arrPhotoData[_arrPhotoData.indexOf(photoJsonModel)] = data;
                                } else {
                                  _arrPhotoData.add(data);
                                }
                              });
                            }
                          },
                        ),
                      ),
                      photoJsonModel == null ? new Container() : new Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(255, 255, 255, 0.2),
                        ),
                        child: new IconButton(
                          icon: new Icon(Icons.remove_red_eye, color: Colors.white),
                          onPressed: () => Application.router.push(context, 'photoDetails', params: { 'id': photoJsonModel.id }),
                        ),
                      )
                    ],
                  ),
                ),
                new Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    photoJsonModel?.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
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

  void _handleHelp () {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return new AlertToastDialog(
          content: '照片作品一天只能保存一个哦...',
        );
      },
    );
  }

  // 请求
  void _reqPhotoList (List<DateTime> arrDate) async {
    Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqPhotoList;
        var data = await Application.util.http.post(strUrl, params: {
          'startTime': '${DateFormat('yyyy-MM-dd HH:mm:ss').format(arrDate[0])}',
          'endTime': '${DateFormat('yyyy-MM-dd HH:mm:ss').format(arrDate[arrDate.length - 1])}',
        }, useLoading: false);
        setState(() {
          _arrPhotoData = List<PhotoJsonModel>.from(data.map((item) => PhotoJsonModel.fromJson(item)).toList());
        });
      } catch (err) {
        Application.util.modal.toast(err);
      }
    });
  }

}