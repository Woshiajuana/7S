
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:flutter/widgets.dart';
import 'package:qimiao/view/world/content.view.dart';
//import 'package:barcode_scan/barcode_scan.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class WorldView extends StatefulWidget {
  @override
  _WorldViewState createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true; // 要点2

  @override
  Widget build(BuildContext context) {
    super.build(context); // 要点3

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
                    new WorldContentView(),
                    new WorldContentView(useFollowing: true),
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
              margin: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: new FlatButton(
                onPressed: () => scan(),
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


  String barcode;

  Future scan() async {
    Application.router.push(context, 'wordQrScan');
//    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', '取消', true, null);
//    try {
//      String barcode = await BarcodeScanner.scan();
//      setState(() => this.barcode = barcode);
//    } on Exception catch (e) {
//      if (e == BarcodeScanner.CameraAccessDenied) {
//        setState(() {
//          this.barcode = 'The user did not grant the camera permission!';
//        });
//      } else {
//        setState(() => this.barcode = 'Unknown error: $e');
//      }
//    } on FormatException {
//      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
//    } catch (e) {
//      setState(() => this.barcode = 'Unknown error: $e');
//    } finally {
//      print('到这里了 => $barcode');
//    }
  }

  Future _handleScan() async {
//    print('到这里了到这里了');
//    String barcode = await BarcodeScanner.scan();
//    try {
//      String barcode = await BarcodeScanner.scan();
      print('xxxxxxxxx => $barcode');
//    } catch (e) {
//      print(e);
//    }
  }

}