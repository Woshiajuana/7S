
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/widgets.dart';
import 'package:qimiao/model/model.dart';

class WorldView extends StatefulWidget {
  @override
  _WorldViewState createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> {

  List<PhotoJsonModel> _arrRecommend;

  @override
  void initState() {
    super.initState();
    this._reqPhotoRecommend();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.mainColor,
      body: new SafeArea(
        bottom: false,
        child: new Container(
          color: Application.config.style.backgroundColor,
          child: new DefaultTabController(
            length: 2,
            child: new NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  // 搜索
                  _widgetSearchSection(),
                  // tab 切换条
                  _widgetTabSection(context),
                ];
              },
              body: new Container(
                padding: const EdgeInsets.only(top: 40.0),
                child: new TabBarView(
                  children: <Widget>[
                    new WowLoadView(
                      status: _arrRecommend == null,
                      child: new RefreshIndicator(
                        child: new GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3,
                            // 左右间隔
                            crossAxisSpacing: 5,
                            // 上下间隔
                            mainAxisSpacing: 5,
                            //宽高比 默认1
                            childAspectRatio: 3 / 4,
                          ),
                          itemCount: _arrRecommend?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return _widgetPhotoItem(index);
                          }
                        ),
                        onRefresh: _onRefresh,
                      ),
                    ),
                    new ListView(
                      children: <Widget>[
//                        _widgetPhotoItem(1),
                        new SizedBox(height: 10.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 搜索
  Widget _widgetSearchSection () {
    return new SliverToBoxAdapter(
      child: new Container(
        height: 56.0,
        color: Application.config.style.mainColor,
        child: new Row(
          children: <Widget>[
            new SizedBox(width: 16.0),
            new Expanded(
              flex: 1,
              child: new Container(
                height: 30,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                child: new FlatButton(
                  onPressed: () => Application.router.push(context, 'search'),
                  padding: const EdgeInsets.all(0),
                  child: new Row(
                    children: <Widget>[
                      new SizedBox(width: 12.0),
                      new Icon(Icons.search, size: 18.0, color: Color(0xff999999)),
                      new SizedBox(width: 10.0),
                      new Text(
                        '什么？找不到你想要的？试试我吧...',
                        style: new TextStyle(
                          color: Color(0xff999999),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            new Container(
              width: 40.0,
              height: 40.0,
              child: new FlatButton(
                onPressed: () => {},
                padding: const EdgeInsets.all(8.0),
                child: new Image.asset(
                  Application.util.getImgPath('scan-icon.png'),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // tab 切换
  Widget _widgetTabSection (BuildContext context) {
    return new SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      child: new SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: new StickyWidgetDelegate(
          maxExtentHeight: 40.0,
          minExtentHeight: 40.0,
          child: new Container(
            height: 40.0,
            decoration: new BoxDecoration(
              color: Application.config.style.mainColor,
              border: new Border(
                bottom: new BorderSide(
                  color: Color(0xffdddddd),
                  width: 0.5,
                ),
              ),
            ),
            child: new TabBar(
              labelColor: Colors.white,
              labelStyle: new TextStyle(
                fontSize: 18.0,
              ),
              unselectedLabelStyle: new TextStyle(
                fontSize: 14.0,
              ),
              unselectedLabelColor: Color(0xffdddddd),
              indicatorColor: Application.config.style.mainColor,
              indicatorWeight: 0.1,
              tabs: <Widget>[
                new Tab(
                  child: new Text(
                    '推荐',
                  ),
                ),
                new Tab(
                  child: new Text(
                    '关注',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 内容
  Widget _widgetPhotoItem (int index) {
    PhotoJsonModel photoJsonModel = _arrRecommend[index];
    FileJsonModel fileJsonModel = photoJsonModel.photo;
    String imageUrl = '${fileJsonModel.base}${fileJsonModel.path}${fileJsonModel.filename}';
    int len = _arrRecommend?.length ?? 0;
    return new Container(
      margin: EdgeInsets.only(top: index < 2 ? 5.0 : 0, bottom: (index + (len%2 == 0 ? 2 : 1)) >= len ? 5.0 : 0),
      decoration: new BoxDecoration(
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0.0, 0.0), //阴影xy轴偏移量
            blurRadius: 1.0, //阴影模糊程度
            spreadRadius: 1.0 //阴影扩散程度
          )
        ],
      ),
      child: new Stack(
        children: <Widget>[
          new Container(
            width: double.infinity,
            height: double.infinity,
            child: new CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              imageUrl: imageUrl,
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
          new Container(
            decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.3),
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
            padding: const EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  photoJsonModel?.title ?? '',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                new SizedBox(height: 5.0),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Text(
                        photoJsonModel?.user?.nickname ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                          fontSize: 12.0,
                          color: Color(0xffbcbcbc),
                        ),
                      ),
                      flex: 1,
                    ),
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.remove_red_eye, size: 12.0, color: Color(0xffbcbcbc)),
                        new SizedBox(width: 2.0),
                        new Text(
                          photoJsonModel?.volume?.toString() ?? '0',
                          style: new TextStyle(
                            color: Color(0xffbcbcbc),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          new FlatButton(
            onPressed: () => Application.router.push(context, 'photoDetails', params: { 'id': photoJsonModel.id }),
            child: new Container(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  // 下拉刷新方法,为list重新赋值
  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () async {
      await this._reqPhotoRecommend();
    });
  }

  // 获取推荐内容
  void _reqPhotoRecommend () async {
    await Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqPhotoRecommend;
        List data = await Application.util.http.post(strUrl, params: {
          'limit': 20,
        }, useLoading: false);
        setState(() {
          List<PhotoJsonModel> d = data.map((item) => PhotoJsonModel.fromJson(item)).toList();
          _arrRecommend == null ? _arrRecommend = d : _arrRecommend.insertAll(0, d);
        });
      } catch (err) {
        Application.util.modal.toast(err);
      }
    });
  }

}