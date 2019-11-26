import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final buildContent;
  final updateStatusBarBrightness;

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.buildContent,
    this.updateStatusBarBrightness,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

//  void updateStatusBarBrightness(shrinkOffset) {
//    if(shrinkOffset > 50) {
//      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//        statusBarBrightness: Brightness.light,
//        statusBarIconBrightness: Brightness.light,
//      ));
//    } else if(shrinkOffset <= 50) {
//      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//        statusBarBrightness: Brightness.dark,
//        statusBarIconBrightness: Brightness.dark,
//      ));
//    }
//  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 236, 100, 47);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if(shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 255, 255, 255);
    }
  }

  Color makeStickyContentTextColor(shrinkOffset, isIcon) {
    if(shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(1-alpha, 255, 255, 255);
    }
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (this.updateStatusBarBrightness != null)
      this.updateStatusBarBrightness(shrinkOffset);
    return new Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: new Stack(
        fit: StackFit.expand,
        children: this.buildContent(
          context,
          shrinkOffset,
          (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt(),
        ),
      ),
    );
  }
}