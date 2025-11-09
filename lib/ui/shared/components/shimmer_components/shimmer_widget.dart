import 'package:flutter/material.dart';
import 'package:image_app/support/config/app_color.dart';
import 'package:shimmer/shimmer.dart';

/// This is merely a wrapper class to allow the use of the Shimmer package
/// when we're in a loading state and to ignore it if not.
class ShimmerWidget extends StatelessWidget {
  final Widget child;

  const ShimmerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: borderColor,
      highlightColor: backgroundColor,
      child: child,
    );
  }
}
