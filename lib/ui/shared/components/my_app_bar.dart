import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/support/config/app_theme.dart';
import 'package:image_app/ui/shared/components/my_heading.dart';
import 'package:image_app/ui/shared/inputs/my_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? title_2;
  final String? subTitle;
  final List<Widget>? actions;
  final List<Widget>? headerActions;
  final bool? automaticallyImplyLeading;
  final VoidCallback? onBackPressed;
  final Widget? titleTrailingWidget;
  final bool showDrawer;
  final bool showIcons;
  final Color? backgroundColor;
  const MyAppBar({
    super.key,
    this.title,
    this.subTitle,
    this.headerActions,
    this.actions,
    this.automaticallyImplyLeading,
    this.onBackPressed,
    this.titleTrailingWidget,
    this.title_2,
    this.showIcons = false, // <== new flag to toggle icons
    this.showDrawer = false,
    this.backgroundColor, // <== new flag to toggle drawer button
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: showIcons ? preferredSize : const Size.fromHeight(56.0),
      child: Container(
        decoration: BoxDecoration(
          color: !isDark
              ? backgroundColor ?? (isDark ? secondaryColor : whiteColor)
              : (isDark ? secondaryColor : whiteColor),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25.h), // Rounded top corners
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.h,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hGap16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showDrawer) ...[
                  _buildDrawerButton(context),
                ] else ...[
                  wGap4
                ],
                if (showIcons) ...[
                  SizedBox(
                    height: 40.h,
                    child: Row(
                      spacing: 12,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child:
                              Icon(Icons.apps, color: blackColor, size: 24.h),
                        ),
                        GestureDetector(
                          onTap: () {
                            // handle notification tap
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Icon(Icons.notifications_outlined,
                                  color: blackColor, size: 24.h),
                              Positioned(
                                right: -6,
                                top: -6,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 16.w,
                                    minHeight: 16.h,
                                  ),
                                  child: MyText(
                                    '3', // your dynamic count here
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ]
              ],
            ),
            hGap12,
            Padding(
              padding: EdgeInsets.only(right: 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Back Button
                  if (automaticallyImplyLeading ?? true)
                    _buildLeadingButton(context),

                  // Logo
                  wGap12,
                  // Title & Subtitle
                  if (title != null || subTitle != null)
                    Expanded(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: onBackPressed,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (title != null) ...[
                                  MyHeading(
                                    title_1: title,
                                    title_2: title_2,
                                  )
                                ],
                                if (subTitle != null) ...[
                                  hGap4,
                                ],
                                if (subTitle != null) ...[
                                  MyText(
                                    subTitle ?? "",
                                    style: textStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? backgroundColor
                                          : secondaryColor,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const Spacer(),
                          titleTrailingWidget ?? const SizedBox()
                        ],
                      ),
                    ),

                  // Actions (Optional)
                  if (actions != null) ...actions!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingButton(BuildContext context) {
    return GestureDetector(
      onTap: onBackPressed,
      child: Icon(
        Icons.arrow_back_ios_new_sharp,
        color: blackColor,
        size: 20,
      ),
    );
  }

  Widget _buildDrawerButton(BuildContext context) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () => Scaffold.of(context).openDrawer(),
        child: Icon(
          Icons.menu,
          color: blackColor,
          size: 24.h,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kIsWeb ? 112.h : 100.h);
}
