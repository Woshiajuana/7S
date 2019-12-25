
import 'package:flutter/material.dart';

class WowScrollerInfo extends StatefulWidget {

  final builder;
  final double maxExtent;
  final dynamic onNotification;
  final dynamic onLoad;

  WowScrollerInfo({
    this.builder,
    this.maxExtent,
    this.onNotification,
    this.onLoad,
  });

  @override
  _WowScrollerInfoState createState() => _WowScrollerInfoState();
}

class _WowScrollerInfoState extends State<WowScrollerInfo> {

  @override
  Widget build(BuildContext context) {
    return new NotificationListener<ScrollNotification>(
      onNotification: _handleScroll,
      child: widget.builder == null ? new Container() : widget.builder(context, _shrinkOffset, _alpha),
    );
  }

  int _alpha = 0;
  double _shrinkOffset = 0;
  bool _isLoad = false;

  // 滚动监听回调
  bool _handleScroll (ScrollNotification scroll) {
    // 当前滑动距离
    if (widget.maxExtent != null) {
      this.setState(() {
        _shrinkOffset = scroll.metrics.pixels;
        _alpha = _shrinkOffset > widget.maxExtent ? 255 : (_shrinkOffset / widget.maxExtent * 255).clamp(0, 255).toInt();
      });
    }
    if (widget.onNotification != null)
      widget.onNotification(scroll);
    if (widget.onLoad != null && (scroll.metrics.maxScrollExtent - scroll.metrics.pixels < 50)) {
      if (!_isLoad) {
        _isLoad = true;
        widget.onLoad(callback: () => _isLoad = false);
      }
    }
    // 返回false，继续向上传递,返回true则不再向上传递
    return true;
  }

}
