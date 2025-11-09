import 'package:image_app/ui/shared/components/shimmer_components/box_size.dart';
import 'package:flutter/material.dart';
import 'package:image_app/ui/shared/components/shimmer_components/shimmer_widget.dart';

/// Should directly mimic and InputBox style and shape when loading
class LoadingInputBox extends StatelessWidget {
  const LoadingInputBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShimmerWidget(
      child: InputDecorator(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(14.0),
          labelText: '..........................',
          border: OutlineInputBorder(),
        ),
        child: Box.text(width: BoxSize.quarter, fontSize: 16.0),
      ),
    );
  }
}
