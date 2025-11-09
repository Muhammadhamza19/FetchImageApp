import 'package:flutter/material.dart';

enum BoxSize { tenth, quarter, half, threeQuarter, full }

/// A generic grey box to be used for Shimmer loading effect.
/// Width of data is difficult to predict hence the percentage of screen calculations
class Box extends StatelessWidget {
  final BoxSize? width;
  final BoxSize? height;
  final double? explicitWidth;
  final double? explicitHeight;
  final double? fontSize;
  final bool isText;

  const Box(
      {super.key,
      this.width = BoxSize.full,
      this.height = BoxSize.quarter,
      this.explicitWidth,
      this.explicitHeight,
      this.fontSize,
      this.isText = false});

  const Box.text(
      {super.key,
      this.width = BoxSize.full,
      this.height = BoxSize.tenth,
      this.explicitWidth,
      this.explicitHeight,
      this.fontSize,
      this.isText = true});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (isText) {
      return _boxWithText(explicitWidth ?? calculateSize(width!, screenWidth));
    } else {
      return _box(
          width: explicitWidth ?? calculateSize(width!, screenWidth),
          height: explicitHeight ?? calculateSize(height!, screenHeight));
    }
  }

  Widget _boxWithText(double width) {
    return Container(
      width: width,
      color: Colors.grey,
      child: Text('', style: TextStyle(fontSize: fontSize)),
    );
  }

  Widget _box({required double width, required double height}) {
    return Container(width: width, height: height, color: Colors.grey);
  }

  double calculateSize(BoxSize boxSize, double size) {
    switch (boxSize) {
      case BoxSize.tenth:
        return size / 10;
      case BoxSize.quarter:
        return size / 4;
      case BoxSize.half:
        return size / 2;
      case BoxSize.threeQuarter:
        return size * 0.75;
      default:
        return size;
    }
  }
}
