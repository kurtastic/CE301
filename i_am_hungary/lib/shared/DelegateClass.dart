import 'package:flutter/material.dart';

class Delegate extends SliverPersistentHeaderDelegate {
  final Color backgroundColor;
  final String _title;
  final double _fontsize;

  Delegate(this.backgroundColor, this._title, this._fontsize);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      // decoration: BoxDecoration(border: Colors.black),
      child: Center(
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.black,
            fontSize: _fontsize,
            fontWeight: FontWeight.w600
          ),
          child: Text(this._title),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
