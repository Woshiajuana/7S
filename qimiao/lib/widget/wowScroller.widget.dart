
import 'package:flutter/material.dart';

class WowScroller extends StatefulWidget {

  final builder;
  final double maxExtent;

  WowScroller({
    this.builder,
    @required this.maxExtent,
  });

  @override
  _WowScrollerState createState() => _WowScrollerState();
}

class _WowScrollerState extends State<WowScroller> {

  @override
  Widget build(BuildContext context) {
    return new NotificationListener<ScrollNotification>(
      onNotification: _handleScroll,
      child: widget.builder == null ? new Container() : widget.builder(context, _shrinkOffset, _alpha),
    );
  }

  int _alpha = 0;
  double _shrinkOffset = 0;
//  double _lastShrinkOffset = 0;
  // 滚动监听回调
  bool _handleScroll (ScrollNotification scroll) {
    // 当前滑动距离
    this.setState(() {
      _shrinkOffset = scroll.metrics.pixels;
      _alpha = _shrinkOffset > widget.maxExtent ? 255 : (_shrinkOffset / widget.maxExtent * 255).clamp(0, 255).toInt();
    });
    // 返回false，继续向上传递,返回true则不再向上传递
    return true;
  }

}
