
import 'package:flutter/material.dart';

class StickyWidgetDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  StickyWidgetDelegate({
    @required this.child,
    @required this.height
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  // minExtent 与 maxExtent 相同, Header不会有收缩效果，类似普通Header。
  @override
  double get maxExtent => this.height;

  @override
  double get minExtent => this.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}