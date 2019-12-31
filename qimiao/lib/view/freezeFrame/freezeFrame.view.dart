
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:date_utils/date_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qimiao/model/model.dart';
import 'package:intl/intl.dart';

class FreezeFrameView extends StatefulWidget {
  @override
  _FreezeFrameViewState createState() => _FreezeFrameViewState();
}

class _FreezeFrameViewState extends State<FreezeFrameView> with TickerProviderStateMixin {

  DateTime _dateTime;
  List<PhotoJsonModel> _arrPhotoData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateTime = DateTime.now();
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
        ],
      ),
    );
  }


  void _handleHelp () {
//    showDialog(
//      context: context,
//      builder: (BuildContext buildContext) {
//        return new AlertToastDialog(
//          content: '视频、图片作品一天只能保存一个哦...',
//        );
//      },
//    );
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
//        Application.util.modal.toast(err);
      }
    });
  }



}