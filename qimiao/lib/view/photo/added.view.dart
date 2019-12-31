
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:qimiao/model/model.dart';
import 'package:image_picker/image_picker.dart';

class PhotoAddView extends StatefulWidget {

  PhotoAddView({
    this.title = '',
    this.data,
    this.createdAt = '',
  });

  final String title;
  final String createdAt;
  final PhotoJsonModel data;

  @override
  _PhotoAddViewState createState() => _PhotoAddViewState();
}

class _PhotoAddViewState extends State<PhotoAddView> {

  String _strTitle; // 标题
  bool _isNature = false;
  File _fileImage;
  TextEditingController _titleController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _strTitle = widget.data?.title ?? '';
    _titleController = TextEditingController(text: _strTitle);
    _isNature = widget.data?.nature == 'PUBLIC';
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          widget.title ?? '',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: <Widget>[
          new Container(
            width: 70.0,
            child: new FlatButton(
              onPressed: () => _handleSubmit(),
              padding: const EdgeInsets.all(0),
              child: new Text(
                '保存',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          _widgetWorkSection(),
          _widgetInputSection(
            controller: _titleController,
            hintText: '标题',
            value: _strTitle,
            onChanged: (value) => setState(() => _strTitle = value),
            onClear: () { _titleController.clear(); setState(() => _strTitle = ''); },
            onEye: () => {},
          ),
          _widgetShareSection(),
        ],
      ),
    );
  }

  // 作品
  Widget _widgetWorkSection () {
    String strPath;
    if (widget.data != null) {
      FileJsonModel fileJsonModel = widget.data.photo;
      strPath = '${fileJsonModel.base}${fileJsonModel.path}${fileJsonModel.filename}';
    }
    return new Container(
      height: 240.0,
      child: new Stack(
        children: <Widget>[
          strPath != null && _fileImage == null ? new Container(
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
          ) : new Container(),
          _fileImage == null ? new Container() : new Container(
            child: new Image.file(
              _fileImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          new Container(
            width: double.infinity,
            height: double.infinity,
            decoration: new BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, .3),
            ),
            child: new FlatButton(
              onPressed: () => _handleConfirm(),
              child: new Icon(Icons.refresh, size: 40.0, color: Colors.white)
            ),
          ),
        ],
      ),
    );
  }

  // input
  Widget _widgetInputSection ({
    TextEditingController controller,
    Widget child,
    String hintText = '',
    bool isObscure = false,
    String value = '',
    bool useEye = false,
    TextInputType keyboardType,
    dynamic onChanged,
    dynamic onClear,
    dynamic onEye,
  }) {
    return new Container(
      height: 50.0,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            color: Color(0xffcccccc),
            width: 0.5,
          ),
        ),
      ),
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new TextField(
              controller: controller,
              obscureText: isObscure,
              keyboardType: keyboardType,
              decoration: new InputDecoration(
                hintText: hintText,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: onChanged,
            ),
          ),
          new Offstage(
            offstage: (value == '' || value == null),
            child: new IconButton(
              icon: new Icon(Icons.clear, size: 20.0, color: Color(0xff666666)),
              onPressed: onClear,
            ),
          ),
          useEye ? new IconButton(
            icon: new Icon(Icons.remove_red_eye, size: 20.0, color: isObscure ? Color(0xff666666) : Application.config.style.mainColor),
            onPressed: onEye,
          ) : new Container(),
          child ?? new Container(),
        ],
      ),
    );
  }

  // 分享到世界按钮
  Widget _widgetShareSection () {
    return new Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            '添加到世界',
            style: new TextStyle(
              color: Color(0xff666666),
              fontSize: 16.0,
            ),
          ),
          new Switch(
            value: _isNature,
            activeColor: Application.config.style.mainColor,     // 激活时原点颜色
            onChanged: (bool val) {
              this.setState(() => _isNature = !_isNature);
            },
          ),
        ],
      ),
    );
  }

  // 弹窗
  void _handleConfirm () {
    showDialog(
      context: context,
      barrierDismissible: true,//是否点击空白区域关闭对话框,默认为true，可以关闭
      builder: (BuildContext context) {
        return new ActionSheetDialog(
          arrOptions: [
            {
              'text': '相册',
              'child': new Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: new Icon(Icons.photo, color: Color(0xff666666)),
              ),
              'onPressed': () => _handleImagePicker(source: ImageSource.gallery),
            },
            {
              'text': '拍照',
              'child': new Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: new Icon(Icons.camera_enhance, color: Color(0xff666666)),
              ),
              'onPressed': () => _handleImagePicker(source: ImageSource.camera),
            }
          ],
        );
      },
    );
  }

  // 上传图片
  void _handleImagePicker ({
    ImageSource source,
  }) async {
    try {
      Application.router.pop(context);
      var image = await ImagePicker.pickImage(source: source);
      if (image == null) return null;
      setState(() => _fileImage = image);
    } catch (err) {
      Application.util.modal.toast(err);
    }
  }

  // 提交信息
  void _handleSubmit () async {
    try {
      bool isAdded = widget.data == null;
      if (isAdded && _fileImage == null)
        throw '图片都没选择呀...';
      if (_strTitle == null || _strTitle == '')
        throw '好歹得写个标题吧...';
      Map data;
      String strUrl = Application.config.api.doFileUpload;
      if (_fileImage != null) {
        String path = _fileImage.path;
        String name = path.substring(path.lastIndexOf('/') + 1, path.length);
        FormData formData = new FormData.from({
          'file': new UploadFileInfo(new File(path), name),
          'type': 'PHOTO',
        });
        data = await Application.util.http.post(strUrl, params: formData);
      }
      strUrl = isAdded ? Application.config.api.doPhotoCreate : Application.config.api.doPhotoUpdate;

      String createdAt = widget?.createdAt ?? '';
      if (createdAt != '') {
        if (DateUtil.isSameDay(DateTime.parse(createdAt.replaceAll('/', '-')), new DateTime.now())) {
          createdAt = '';
        }
      }

      var result = await Application.util.http.post(strUrl, params: {
        'id': widget.data?.id ?? '',
        'photo': data == null ? widget.data.photo.id : data['file'],
        'title': _strTitle,
        'nature': _isNature ? 'PUBLIC' : 'PRIVACY',
        'created_at': isAdded ? createdAt : '',
      });
      PhotoJsonModel photoJsonModel = PhotoJsonModel.fromJson(result);
      Application.util.modal.toast('保存成功');
      if (isAdded) {
        eventBus.fire(MineEvent());
        eventBus.fire(PhotoListEvent());
      }
//      Application.router.pop(context, params: photoJsonModel);
    } catch (err) {
      print(err);
      Application.util.modal.toast(err);
    }
  }
}
