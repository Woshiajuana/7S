
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/model/model.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MineQrCodeView extends StatefulWidget {
  @override
  _MineQrCodeViewState createState() => _MineQrCodeViewState();
}

class _MineQrCodeViewState extends State<MineQrCodeView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '二维码名片',
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
                '分享',
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
      body: new Container(
        alignment: Alignment.center,
        child: new Container(
          width: 300.0,
          height: 360.0,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(10.0),
            border: new Border.all(color: Color(0xffdddddd), width: 0.5),
          ),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _widgetUserSection(),
              _widgetQrCodeSection(),
            ],
          ),
        ),
      ),
    );
  }

  // 用户信息
  Widget _widgetUserSection () {
    return new Container(
      width: 200.0,
      child: new Row(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              border: new Border.all(color: Color(0xFF9E9E9E), width: 0.5), // 边色与边宽度
              color: Color(0xFF9E9E9E), // 底色
              borderRadius: new BorderRadius.circular((41)), // 圆角度
            ),
            child: new ClipOval(
              child: new CachedNetworkImage(
                width: 36.0,
                height: 36.0,
                fit: BoxFit.cover,
                imageUrl: StateModel.of(context)?.user?.avatar ?? '',
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
          ),
          new SizedBox(width: 10.0),
          new Expanded(
            flex: 1,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  StateModel.of(context)?.user?.nickname ?? '',
                  style: new TextStyle(
                    color: Color(0xff666666),
                    fontSize: 14.0,
                  ),
                ),
                new SizedBox(height: 3.0),
                new Text(
                  StateModel.of(context)?.user?.signature ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                    color: Color(0xff999999),
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 用户二维码
  Widget _widgetQrCodeSection () {
    return new Container(
      width: 200.0,
      color: Color(0xffeeeeee),
      margin: const EdgeInsets.only(top: 10.0),
      child: new QrImage(
        data: '7S_USER_ID:${StateModel.of(context)?.user?.id}',
        version: QrVersions.auto,
        size: 200,
        gapless: false,
//        embeddedImage: new NetworkImage(),
//        embeddedImageStyle: QrEmbeddedImageStyle(
//          size: Size(50, 50),
//        ),
      ),
    );
  }
}
