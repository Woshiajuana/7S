
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class FriendFollowingView extends StatefulWidget {
  @override
  _FriendFollowingViewState createState() => _FriendFollowingViewState();
}

class _FriendFollowingViewState extends State<FriendFollowingView> {

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        _widgetCellItem(),
        _widgetCellItem(),
        _widgetCellItem(),
        _widgetCellItem(),
        _widgetCellItem(),
        _widgetCellItem(),
        _widgetCellItem(),
        _widgetCellItem(),
        _widgetCellItem(),
        _widgetCellItem(),
        _widgetCellItem(),
        _widgetCellItem(),
        _widgetCellItem(),
        _widgetCellItem(),
      ],
    );
  }

  // item
  Widget _widgetCellItem () {
    return new Container(
      padding: const EdgeInsets.only(right: 16.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          top: new BorderSide(
            color: Color(0xffdddddd),
            width: 0.5,
          )
        )
      ),
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(
              height: 60.0,
              child: new FlatButton(
                onPressed: () => Application.router.push(context, 'friendInfo'),
                padding: const EdgeInsets.only(right: 0, left: 16.0),
                child: new Row(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                        border: new Border.all(color: Color(0xFF9E9E9E), width: 0.5), // 边色与边宽度
                        color: Color(0xFF9E9E9E), // 底色
                        borderRadius: new BorderRadius.circular((41)), // 圆角度
                      ),
                      child: new ClipOval(
                        child: new FadeInImage.assetNetwork(
                          width: 36.0,
                          height: 36.0,
                          placeholder: Application.config.style.srcGoodsNull,
                          image: 'http://ossmk2.jfpays.com/www_make_v1/app/static/images/defaultFace013x.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    new SizedBox(width: 10.0),
                    new Expanded(
                      flex: 1,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            '我是阿倦啊',
                            style: new TextStyle(
                              color: Color(0xff666666),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          new SizedBox(height: 4.0),
                          new Text(
                            '7S-ID:00000017S-ID:00000017S-ID:00000017S-ID:00000017S-ID:0000001',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              color: Color(0xff999999),
                              fontSize: 10.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          new SizedBox(width: 10.0),
          new Container(
            width: 50.0,
            height: 24.0,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(36.0),
              border: new Border.all(
                color: Application.config.style.mainColor,
                width: 0.5,
              ),
            ),
            child: new FlatButton(
              onPressed: () => {},
              padding: const EdgeInsets.all(0),
              child: new Text(
                '已关注',
                style: new TextStyle(
                  color: Application.config.style.mainColor,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
