import 'package:image_app/support/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/ui/shared/inputs/my_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum IconPosition { left, right, start, end }

class MyButton extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final IconPosition iconPosition;
  final double? iconSize;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Color? color;
  final bool fullWidth;
  final double minHeight;
  final Color? borderColor;
  final double minWidth;
  final int? badgeCount; // New parameter for badge count

  const MyButton({
    super.key,
    required this.text,
    this.iconData,
    this.iconPosition = IconPosition.start,
    this.iconSize,
    this.textColor,
    this.onPressed,
    this.color,
    this.fullWidth = false,
    this.minHeight = 0.0,
    this.borderColor,
    this.minWidth = 0.0,
    this.badgeCount, // Add badge count parameter
  });

  @override
  Widget build(BuildContext context) {
    final translatedText = MyText(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: textStyle(
          color: textColor ?? (onPressed != null ? whiteColor : secondaryColor),
          fontSize: 14,
          fontWeight: FontWeight.w600),
    );
    final icon = Icon(
      iconData,
      size: iconSize ?? 16,
      color: onPressed != null ? textColor ?? whiteColor : disabledColor,
    );

    final button = Container(
      constraints: BoxConstraints(minHeight: minHeight, minWidth: minWidth),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // Adjust button size for tablets using below
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                  color: onPressed != null
                      ? borderColor ?? color ?? primaryColor
                      : disabledColor)),
          elevation: 0,
          backgroundColor: color ?? primaryColor,
          disabledBackgroundColor: disabledColor,
          // Background Color
          disabledForegroundColor: disabledColor, //Text Color
        ),
        onPressed: onPressed != null ? () => onPressed!() : null,
        child: iconData != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
                children: <Widget>[
                  if (iconPosition == IconPosition.start) ...[
                    icon,
                    const SizedBox(width: 8.0),
                    Flexible(child: translatedText),
                  ] else ...[
                    Flexible(child: translatedText),
                    const SizedBox(width: 8.0),
                    icon,
                  ],
                ],
              )
            : fullWidth
                ? SizedBox(
                    width: double.infinity,
                    child: Center(child: translatedText),
                  )
                : translatedText,
      ),
    );

    // If badgeCount is null, return button without badge
    if (badgeCount == null) {
      return button;
    }

    // Return button with animated badge
    return Stack(
      clipBehavior: Clip.none,
      children: [
        button,
        Positioned(
          top: -8,
          right: -8,
          child: AnimatedScale(
            scale: badgeCount != null ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.elasticOut,
            child: AnimatedOpacity(
              opacity: badgeCount != null ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                constraints: const BoxConstraints(minWidth: 18),
                height: 18.h,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: MyText(
                    badgeCount! > 99 ? '99+' : badgeCount.toString(),
                    style: textStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
