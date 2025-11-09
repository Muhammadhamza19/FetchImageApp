import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/support/config/app_theme.dart';
import 'package:image_app/ui/shared/inputs/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHeading extends StatelessWidget {
  final String? title_1;
  final String? title_2;

  const MyHeading({super.key, this.title_1, this.title_2});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title_1 != null)
          MyText(
            title_1!,
            style: textStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins-SemiBold',
              color: isDark ? backgroundColor : secondaryColor,
            ),
          ),
        if (title_2 != null) ...[
          MyText(
            title_2!,
            style: textStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: disabledTextColor,
            ),
          ),
        ],
      ],
    );
  }
}
