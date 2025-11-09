import 'package:image_app/support/helper/device_info_helper.dart';
import 'package:image_app/ui/shared/inputs/my_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_app/view_models/user_view_model.dart';
import 'package:image_app/support/config/app_color.dart';
import 'package:flutter/material.dart';

/// padding
const kPaddingEdges4 = EdgeInsets.symmetric(horizontal: 4);
const kPaddingEdges8 = EdgeInsets.symmetric(horizontal: 8);
const kPaddingEdges12 = EdgeInsets.symmetric(horizontal: 12);
const kPaddingEdges16 = EdgeInsets.symmetric(horizontal: 16);
const kPaddingEdges20 = EdgeInsets.symmetric(horizontal: 20);
const kPaddingEdges24 = EdgeInsets.symmetric(horizontal: 24);
const kPaddingEdges28 = EdgeInsets.symmetric(horizontal: 28);
const kPaddingEdges32 = EdgeInsets.symmetric(horizontal: 32);

/// height
const double kButtonHeight = 48;

/// border radius
final BorderRadius kBorderRadius12 = BorderRadius.circular(12);

/// generic gap height
final hGap2 = SizedBox(height: 2.h);

final hGap4 = SizedBox(height: 4.h);
final hGap8 = SizedBox(height: 8.h);
final hGap12 = SizedBox(height: 12.h);
final hGap16 = SizedBox(height: 16.h);
final hGap20 = SizedBox(height: 20.h);
final hGap24 = SizedBox(height: 24.h);
final hGap28 = SizedBox(height: 28.h);
final hGap32 = SizedBox(height: 32.h);

/// generic gap width
final wGap4 = SizedBox(width: 4.w);
final wGap8 = SizedBox(width: 8.w);
final wGap12 = SizedBox(width: 12.w);
final wGap16 = SizedBox(width: 16.w);
final wGap20 = SizedBox(width: 20.w);
final wGap24 = SizedBox(width: 24.w);
final wGap28 = SizedBox(width: 28.w);
final wGap32 = SizedBox(width: 32.w);

/// Text theme secondary color
/// body color always primary color
/// label color always secondary color
/// title color always secondary color

TextStyle textStyle({
  double? fontSize,
  String? fontFamily,
  FontStyle? fontStyle,
  Color? color,
  FontWeight? fontWeight,
}) =>
    TextStyle(
      fontSize: fontSize?.sp ?? 13.0.sp,
      fontFamily: fontFamily ?? 'Poppins-Regular',
      fontStyle: fontStyle ?? FontStyle.normal,
      color: color ?? primaryColor, //primary1Color,
      fontWeight: fontWeight ?? FontWeight.normal,
    );

/// Button - primary
ButtonStyle get primaryButtonStyle => ButtonStyle(
      shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
          (Set<WidgetState> states) {
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
        );
      }),
      padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
          (Set<WidgetState> states) {
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 15);
      }),
      backgroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) return secondaryColor;
        return primaryColor;
      }),
      foregroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) return backgroundColor;
        return backgroundColor;
      }),
    );

/// Button - secondary
ButtonStyle get secondaryButtonStyle => ButtonStyle(
      shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
          (Set<WidgetState> states) {
        return RoundedRectangleBorder(
          side: BorderSide(color: primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(0)),
        );
      }),
      padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
          (Set<WidgetState> states) {
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 15);
      }),
      backgroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) return secondaryColor;
        return backgroundColor;
      }),
      foregroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) return primaryColor;
        return primaryColor;
      }),
    );

/// Button - disable
ButtonStyle get disableButtonStyle => ButtonStyle(
      shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
          (Set<WidgetState> states) {
        return const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        );
      }),
      padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>(
          (Set<WidgetState> states) {
        return const EdgeInsets.symmetric(horizontal: 16);
      }),
      backgroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) return Colors.grey[400]!;
        return Colors.grey[400]!;
      }),
      foregroundColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) return backgroundColor;
        return backgroundColor;
      }),
    );

/// textfield
InputDecoration textFieldDecoration(String label,
        {IconData? prefixIcon,
        IconData? suffixIcon,
        void Function()? onTapSuffix}) =>
    InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      fillColor: whiteColor,
      filled: true,
      contentPadding: const EdgeInsets.only(
          left: 30.0, top: 15.0, right: 15.0, bottom: 15.0),
      hintText: label,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(right: 25.0),
        child: Icon(
          prefixIcon,
          size: 35,
          color: Colors.grey[500],
        ),
      ),
      prefixStyle: Theme.of(Get.context!).textTheme.labelLarge,
      suffixStyle: Theme.of(Get.context!).textTheme.labelLarge,
      suffixIcon: GestureDetector(
        onTap: onTapSuffix,
        child: Icon(
          suffixIcon,
          color: Colors.grey[500],
        ),
      ),
      hintStyle: Theme.of(Get.context!).textTheme.labelLarge,
      enabledBorder: UnderlineInputBorder(
        // borderRadius: BorderRadius.only(),
        borderSide: BorderSide(color: disabledColor, width: 1.0),
      ),
      focusedBorder: UnderlineInputBorder(
        // borderRadius: BorderRadius.circular(50.0),
        borderSide: BorderSide(color: disabledColor, width: 1.0),
      ),
      border: UnderlineInputBorder(
        // borderRadius: BorderRadius.circular(50.0),
        borderSide: BorderSide(color: disabledColor, width: 1.0),
      ),
      disabledBorder: UnderlineInputBorder(
        // borderRadius: BorderRadius.circular(50.0),
        borderSide: BorderSide(color: disabledColor, width: 1.0),
      ),
      errorBorder: const UnderlineInputBorder(
        // borderRadius: BorderRadius.circular(50.0),
        borderSide: BorderSide(color: Colors.red, width: 1.0),
      ),
    );

/// date and time theme
TimePickerThemeData get timePickerTheme => TimePickerThemeData(
      backgroundColor: backgroundColor,
      hourMinuteColor: primaryColor,
      hourMinuteTextColor: backgroundColor,
      dialHandColor: greenColor[700],
      dialBackgroundColor: primaryColor,
      entryModeIconColor: primaryColor,
      dayPeriodColor: backgroundColor,
      dialTextColor: backgroundColor,
    );

/// dialog theme
DialogThemeData get dialogTheme => DialogThemeData(
    backgroundColor: isDark ? secondaryColor : backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ));

CheckboxThemeData get checkboxTheme => CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return (primaryColor);
        } else {
          return (disabledColor);
        }
      }),
      checkColor: WidgetStateProperty.all(whiteColor),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: 2, vertical: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      side: WidgetStateBorderSide.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return BorderSide(
              color: textFieldBorderColor,
              width: 2,
            );
          }
          return BorderSide(
            color: textFieldBorderColor,
            width: 2,
          );
        },
      ),
    );

/// card theme
CardThemeData get cardTheme => CardThemeData(
      color: isDark ? secondaryColor : whiteColor,
      margin: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3.0,
    );
ListTileThemeData get listTileTheme => const ListTileThemeData(
      minLeadingWidth: 0,
      // minVerticalPadding: 0,
      // // minTileHeight: 0,
      // horizontalTitleGap: 5,
      // contentPadding: EdgeInsets.symmetric(horizontal: 0),
    );

/// messages theme
void showInfoMessage(String text) {
  Get.snackbar(
    'info'.tr,
    text,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.yellow,
    colorText: whiteColor,
  );
}

void showSuccessMessage(String text, {int duration = 2}) {
  Get.rawSnackbar(
    messageText: Row(
      children: [
        Icon(Icons.check_circle, color: primaryColor, size: 20), // Success icon
        wGap12,
        Expanded(
          child: MyText(
            text,
          ),
        ),
      ],
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.white, // White background
    borderRadius: 12, // Rounded corners
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Margin
    padding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Padding
    boxShadows: [
      BoxShadow(
        color: disabledColor, // Soft shadow
        blurRadius: 6,
        spreadRadius: 1,
        offset: const Offset(0, 3),
      ),
    ],
    isDismissible: true,
    duration: Duration(seconds: duration),
  );
}

void showErrorMessage(String text) {
  Get.rawSnackbar(
    messageText: Row(
      children: [
        const Icon(Icons.close, color: Colors.red, size: 20), // Success icon
        wGap12,
        Expanded(
          child: MyText(
            text,
          ),
        ),
      ],
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.white, // White background
    borderRadius: 12, // Rounded corners
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Margin
    padding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 20), // Padding
    boxShadows: [
      BoxShadow(
        color: disabledColor, // Soft shadow
        blurRadius: 6,
        spreadRadius: 1,
        offset: const Offset(0, 3),
      ),
    ],
    isDismissible: true,
    duration: const Duration(seconds: 5),
  );
}

/// light and dark theme
ThemeData get lightTheme => ThemeData(
    fontFamily: 'Popins',
    useMaterial3: false,
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    canvasColor: backgroundColor,
    timePickerTheme: timePickerTheme,
    dialogTheme: dialogTheme,
    cardTheme: cardTheme,
    checkboxTheme: checkboxTheme,
    listTileTheme: listTileTheme);
ThemeData get darkTheme => ThemeData(
      fontFamily: 'Popins',
      useMaterial3: false,
      primaryColor: whiteColor,
      scaffoldBackgroundColor: secondaryColor,
      canvasColor: isDark ? secondaryColor : backgroundColor,
      timePickerTheme: timePickerTheme,
      dialogTheme: dialogTheme,
      cardTheme: cardTheme,
      checkboxTheme: checkboxTheme,
      listTileTheme: listTileTheme,
    );
bool get isDark => UserViewModel.instance().isDarkTheme.value;

String get fontFamily => "Poppins";

/// For ListTiles
VisualDensity visualDensity(BuildContext context) {
  switch (getScreenSize(context)) {
    case ScreenSize.small:
      return VisualDensity.compact;
    case ScreenSize.medium:
      return VisualDensity.comfortable;
    case ScreenSize.large:
      return VisualDensity.standard;
  }
}
