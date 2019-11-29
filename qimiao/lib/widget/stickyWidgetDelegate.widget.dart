
import 'package:flutter/material.dart';

class StickyWidgetDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxExtentHeight;
  final double minExtentHeight;

  StickyWidgetDelegate({
    @required this.child,
    @required this.maxExtentHeight,
    @required this.minExtentHeight
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  // minExtent 与 maxExtent 相同, Header不会有收缩效果，类似普通Header。
  @override
  double get maxExtent => this.maxExtentHeight;

  @override
  double get minExtent => this.minExtentHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}