import 'package:flutter/material.dart';

class MyAssetImage extends StatelessWidget {
  final String imageName;
  final double height;
  final double width;
  final String tooltipText;
  final Function(String)? onClick;
  final bool isCircular; // Add the isCircular parameter
  final Color? color;
  final bool isFlavor;

  const MyAssetImage({
    super.key,
    required this.imageName,
    this.height = 30.0,
    this.width = 30.0,
    this.tooltipText = "",
    this.onClick,
    this.isFlavor = false,
    this.isCircular = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    const a = String.fromEnvironment('FLUTTER_APP_FLAVOR');

    final Widget imageWidget = Image(
      image: isFlavor
          ? AssetImage("assets/images/$a/$imageName.png")
          : AssetImage("assets/images/icons/$imageName.png"),
      height: height,
      width: width,
      fit: BoxFit.fill,
      color: color,
      colorBlendMode: color != null ? BlendMode.srcIn : null,
    );

    if (onClick == null) {
      // If `onClick` is null, just return the image
      return isCircular
          ? ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(50.0), // All corners rounded
              ),
              child: imageWidget,
            )
          : imageWidget; // Return the normal image without any corner modification
    }

    // If `onClick` is not null, wrap the image in a GestureDetector with a Tooltip
    return MouseRegion(
      key: const Key("MyAssetImage"),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onClick!(imageName),
        child: Tooltip(
          message: tooltipText,
          child: isCircular
              ? ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30.0), // All corners rounded
                  ),
                  child: imageWidget,
                )
              : imageWidget, // Return the normal image without any corner modification
        ),
      ),
    );
  }
}
