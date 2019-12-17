
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:qimiao/model/model.dart';
import "package:intl/intl.dart";

class PhotoListView extends StatefulWidget {
  @override
  _PhotoListViewState createState() => _PhotoListViewState();
}

class _PhotoListViewState extends State<PhotoListView> {

  ListJsonModel _listJsonModel;
  List<PhotoJsonModel> _arrData;
  int _numIndex = 1;
  int _numSize = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._reqPhotoList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '照片',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add, color: Colors.white),
            onPressed: () => Application.router.push(context, 'photoAdded', params: { 'title': '新增照片' }),
          ),
        ],
      ),
      body: new WowLoadView(
        data: _arrData,
        child: new WowScrollListView(
            onRefresh: _handleRefresh,
            onLoad: _handleLoad,
            data: _arrData,
            total: _listJsonModel?.total ?? 0,
            itemBuilder: (content, index) {
              return _widgetPhotoCellItem(index);
            }
        ),
      ),
    );
  }

  // 照片
  Widget _widgetPhotoCellItem (index) {
    PhotoJsonModel photoJsonModel = _arrData[index];
    String strTime = photoJsonModel.created_at != null
        ? new DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(photoJsonModel.created_at).toLocal())
        : '';
    FileJsonModel fileJsonModel = photoJsonModel.photo;
    String strPath = '${fileJsonModel.base}${fileJsonModel.path}${fileJsonModel.filename}';
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            height: 30.0,
            padding: const EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              strTime,
              style: new TextStyle(
                fontSize: 12.0,
                color: Color(0xff666666),
              ),
            ),
          ),
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
                        child: new CachedNetworkImage(
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: strPath,
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
                        child: new FlatButton(
                          onPressed: () => Application.router.push(context, 'photoDetails', params: { 'id': photoJsonModel.id }),
                          child: new Container(),
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
                          photoJsonModel.title ?? '',
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
                                new Icon(Icons.remove_red_eye, size: 14.0, color: Color(0xff999999)),
                                new SizedBox(width: 2.0),
                                new Text(
                                  photoJsonModel.volume?.toString() ?? '0',
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
                                  onPressed: () => _handleOperate(photoJsonModel),
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
  void _handleOperate (PhotoJsonModel photoJsonModel) {
    showDialog(
      context: context,
      barrierDismissible: true,//是否点击空白区域关闭对话框,默认为true，可以关闭
      builder: (BuildContext context) {
        return new ActionSheetDialog(
          arrOptions: [
            {
              'text': '编辑',
              'onPressed': () {
                Application.router.pop(context);
                Application.router.push(context, 'photoAdded', params: { 'title': '编辑作品', 'data': photoJsonModel });
              },
            },
            {
              'text': '删除',
              'onPressed': () => this._doPhotoDelete(photoJsonModel),
            },
          ],
        );
      },
    );
  }

  // 删除
  void _doPhotoDelete (PhotoJsonModel photoJsonModel) async {
    Application.router.pop(context);
    var result = await showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return new ConfirmDialog(
          content: '确定要删除该张照片么？',
        );
      },
    );
    if (result != true) return;
    try {
      String strUrl = Application.config.api.doPhotoDelete;
      Map mapParams = { 'id': photoJsonModel.id };
      await Application.util.http.post(strUrl, params: mapParams);
      setState(() {
        _listJsonModel.total--;
        _arrData.remove(photoJsonModel);
      });
      Application.util.modal.toast('删除成功');
    } catch (err) {
      Application.util.modal.toast(err);
    }
  }

  // 刷新
  void _handleRefresh() async {
    _numIndex = 1;
    await this._reqPhotoList();
  }

  // 下拉加载
  void _handleLoad ({
    Function callback,
  }) async {
    _numIndex++;
    this._reqPhotoList(callback: callback);
  }

  // 获取列表
  void _reqPhotoList ({
    Function callback,
  }) async {
    await Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqPhotoList;
        Map mapParams = { 'numIndex': _numIndex, 'numSize': _numSize };
        _listJsonModel = ListJsonModel.fromJson(await Application.util.http.post(strUrl, params: mapParams, useLoading: false));
        setState(() {
          List<PhotoJsonModel> data = _listJsonModel.list.map((item) => PhotoJsonModel.fromJson(item)).toList();
          _numIndex == 1 ? _arrData = data : _arrData.addAll(data);
        });
      } catch (err) {
        Application.util.modal.toast(err);
      } finally {
        if (callback != null) callback();
      }
    });
  }

}
