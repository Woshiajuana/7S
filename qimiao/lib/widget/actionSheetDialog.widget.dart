
import 'package:flutter/material.dart';

class ActionSheetDialog extends StatefulWidget {

  const ActionSheetDialog({
    Key key,
    this.arrOptions,
  }) : super(key: key);

  final List arrOptions;

  @override
  _ActionSheetDialogState createState() => _ActionSheetDialogState();
}

class _ActionSheetDialogState extends State<ActionSheetDialog> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _widgetButtonGroup(),
          new SizedBox(height: 10.0),
          _widgetButtonItem(
            onPressed: () => Navigator.of(context).pop(),
            text: '取消',
            color: Color(0xff999999),
          ),
        ],
      ),
    );
  }

  Widget _widgetButtonGroup () {
    int _numLen = widget.arrOptions?.length??0;
    if (_numLen == 0) return new Container();
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: new Column(
        children: widget.arrOptions.asMap().keys.map((index) => _widgetButtonItem(
          text: widget.arrOptions[index]['text'],
          child: widget.arrOptions[index]['child'],
          onPressed: widget.arrOptions[index]['onPressed'],
          color: Color(0xff333333),
          useBorder: _numLen - 1 != index,
        )).toList(),
      ),
    );
  }

  Widget _widgetButtonItem ({
    dynamic onPressed,
    String text = '',
    Widget child,
    Color color,
    bool useBorder = false,
  }) {
    return new Container(
      height: 50.0,
      width: double.infinity,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: new Container(
        decoration: new BoxDecoration(
          border: useBorder ? new Border(
            bottom: new BorderSide(color: Color(0xff999999), width: 0),
          ) : null,
        ),
        child: new FlatButton(
          onPressed: onPressed,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              child ?? new Container(),
              new Text(
                text,
                style: new TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
