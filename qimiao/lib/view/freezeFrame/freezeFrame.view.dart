
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:date_utils/date_utils.dart';
import 'package:image_picker/image_picker.dart';
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
            dayBuilder: (BuildContext context, DateTime day, bool isSelected) {
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
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: isAfter ? Colors.transparent : isSelected ? Theme.of(context).primaryColor : Color(0xffbbbbbb),
                ),
                child: new Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    imageUrl == null ? new Container() : new CachedNetworkImage(
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
                    new Text(
                      Utils.formatDay(day).toString(),
                      style: !isAfter || isSelected ? new TextStyle(color: Colors.white) : new TextStyle(
                        color: Color(0xffbbbbbb),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
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
  void _reqPhotoList (List<DateTime> arrDate) async {
    Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqPhotoList;
        var data = await Application.util.http.post(strUrl, params: {
          'startTime': '${DateFormat('yyyy-MM-dd HH:mm:ss').format(arrDate[0])}',
          'endTime': '${DateFormat('yyyy-MM-dd HH:mm:ss').format(arrDate[arrDate.length - 1])}',
        });
        _arrPhotoData = List<PhotoJsonModel>.from(data.map((item) => PhotoJsonModel.fromJson(item)).toList());
      } catch (err) {
        Application.util.modal.toast(err);
      }
    });
  }



}