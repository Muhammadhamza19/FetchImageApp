import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/ui/shared/inputs/my_text.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton(
      {super.key, required this.text, this.textStyle, this.onTap});
  final String text;
  final TextStyle? textStyle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MyText(
        text,
        style: textStyle ??
            TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.0),
      ),
    );
  }
}
