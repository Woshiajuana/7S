
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:date_utils/date_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qimiao/model/model.dart';
import "package:intl/intl.dart";

class FreezeFrameView extends StatefulWidget {
  @override
  _FreezeFrameViewState createState() => _FreezeFrameViewState();
}

class _FreezeFrameViewState extends State<FreezeFrameView> {

  DateTime _dateTime;
  List<PhotoJsonModel> _arrPhotoData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateTime = DateTime.now();
//    this._reqPhotoList();
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
        title: new Text(
          DateFormat('yyyy/MM').format(_dateTime),
          style: new TextStyle(
            fontSize: 18.0,
          ),
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
          // 日历
          new WowCalendar(
            onSelected: (DateTime day, List<DateTime> arrDay) {
              setState(() {
                _dateTime = day;
              });
            },
            dayBuilder: (BuildContext context, DateTime day, bool isSelected) {
              bool isAfter = day.isAfter(new DateTime.now());
              return new Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5.0),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: isAfter ? Colors.transparent : isSelected ? Theme.of(context).primaryColor : Color(0xffbbbbbb),
                ),
                child: new Text(
                  Utils.formatDay(day).toString(),
                  style: !isAfter || isSelected ? new TextStyle(color: Colors.white) : new TextStyle(
                    color: Color(0xffbbbbbb),
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
          // 日历
//          _widgetCalendarSection(),
          // 标题
//          _widgetTitleSection(),
          // 视频
//          _widgetVideoSection(),
          // 照片
//          _widgetPhotoSection(),
        ],
      ),
    );
  }


  // 标题
  Widget _widgetTitleSection () {
    return new Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            Utils.apiDayFormat(_dateTime),
            style: new TextStyle(
              fontSize: 18.0,
              color: Color(0xff333333),
            ),
          ),
          new SizedBox(height: 5.0),
          new Text(
            '您今日已拍摄一段视频，一张照片了哦...',
            style: new TextStyle(
              fontSize: 12.0,
              color: Color(0xff999999),
            ),
          ),
        ],
      ),
    );
  }

  // 视频
  Widget _widgetVideoSection () {
    return new Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
      height: 160.0,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
        boxShadow: [
          new BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0.0, 1.0), //阴影xy轴偏移量
          ),
        ],
      ),
      child: new Stack(
        children: <Widget>[
          new Container(
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: new Image.asset(
                Application.util.getImgPath('guide1.png'),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          new Container(
            width: double.infinity,
            height: double.infinity,
            decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, .2),
              borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
            ),
            child: new FlatButton(
              onPressed: () => this._handleAddConfirm(),
              child: new Icon(Icons.add, size: 40.0, color: Colors.white)
            ),
          ),
          new Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: new Container(
              height: 60.0,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
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
            padding: const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 6.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.live_tv, size: 14.0, color: Color(0xffdddddd)),
                        new SizedBox(width: 2.0),
                        new Text(
                          '100',
                          style: new TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.thumb_up, size: 14.0, color: Color(0xffdddddd)),
                        new SizedBox(width: 2.0),
                        new Text(
                          '100',
                          style: new TextStyle(
                            color: Color(0xffdddddd),
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
                        child: new Icon(Icons.more_vert, size: 18.0, color: Color(0xffdddddd))
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  // 照片
  Widget _widgetPhotoSection () {
    return new Container(
      margin: const EdgeInsets.all(16.0),
      height: 160.0,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
        boxShadow: [
          new BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0.0, 1.0), //阴影xy轴偏移量
          ),
        ],
      ),
      child: new Stack(
        children: <Widget>[
          new Container(
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: new Image.asset(
                Application.util.getImgPath('guide1.png'),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          new Container(
            width: double.infinity,
            height: double.infinity,
            decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, .2),
              borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
            ),
            child: new FlatButton(
                onPressed: () => {},
                child: new Icon(Icons.add, size: 40.0, color: Colors.white)
            ),
          ),
          new Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: new Container(
              height: 60.0,
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
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
            padding: const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 6.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.live_tv, size: 14.0, color: Color(0xffdddddd)),
                        new SizedBox(width: 2.0),
                        new Text(
                          '100',
                          style: new TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.thumb_up, size: 14.0, color: Color(0xffdddddd)),
                        new SizedBox(width: 2.0),
                        new Text(
                          '100',
                          style: new TextStyle(
                            color: Color(0xffdddddd),
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
                          child: new Icon(Icons.more_vert, size: 18.0, color: Color(0xffdddddd))
                      ),
                    ),
                  ],
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
          content: '视频、图片作品一天只能保存一个哦...',
        );
      },
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
                Navigator.of(context).pop();
                Application.router.push(context, 'videoDetails');
              },
            },
            {
              'text': '举报',
              'onPressed': () => print('拍照'),
            },
            {
              'text': '编辑',
              'onPressed': () {
                Navigator.of(context).pop();
                Application.router.push(context, 'freezeFrameDetails');
              },
            },
          ],
        );
      },
    );
  }

  // 操作
  void _handleAddConfirm () async {
    showDialog(
      context: context,
      barrierDismissible: true,//是否点击空白区域关闭对话框,默认为true，可以关闭
      builder: (BuildContext context) {
        return new ActionSheetDialog(
          arrOptions: [
            {
              'text': '从相册中获取',
              'onPressed': () async {
                var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                print('相册返回：' + image.toString());
              },
            },
            {
              'text': '直接拍照',
              'onPressed': () async {
                var image = await ImagePicker.pickImage(source: ImageSource.camera);
                print('拍照返回：' + image.toString());
              },
            },
            {
              'text': '拍摄视频',
              'onPressed': () async {
                var image = await ImagePicker.pickVideo(source: ImageSource.camera);
                print('拍摄视频：' + image.toString());
              },
            },
            {
              'text': '选取视频',
              'onPressed': () async {
                var image = await ImagePicker.pickVideo(source: ImageSource.gallery);
                print('选取视频：' + image.toString());
              },
            },
          ],
        );
      },
    );
  }

  // 请求
  void _reqPhotoList () async {
    Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqPhotoList;
        var data = await Application.util.http.post(strUrl, useLoading: false);
        ListJsonModel listJsonModel = ListJsonModel.fromJson(data);
        listJsonModel.list.forEach((item) => _arrPhotoData.add(PhotoJsonModel.fromJson(item)));
      } catch (err) {
        Application.util.modal.toast(err);
      }
    });
  }



}
