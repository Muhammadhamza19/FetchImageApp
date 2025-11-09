import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/support/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final double? textScaleFactor;
  final bool toUpper;
  final bool disableTranslationMode;
  final bool addQuotations;
  final String? contextOverride;
  final bool hasTranslationContext;

  const MyText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textScaleFactor,
    this.disableTranslationMode = false,
    this.addQuotations = false,
    this.toUpper = false,
    this.contextOverride,
    this.hasTranslationContext = true,
  });

  @override
  Widget build(BuildContext context) {
    return _TranslatedText(
      text: text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      toUpper: toUpper,
      addQuotations: addQuotations,
      contextOverride: contextOverride,
    );
  }
}

class _TranslatedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final double? textScaleFactor;
  final bool? toUpper;
  final bool? addQuotations;
  final String? contextOverride;

  const _TranslatedText({
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textScaleFactor,
    this.toUpper,
    this.addQuotations,
    this.contextOverride,
  });

  @override
  Widget build(BuildContext context) {
    var translatedString = text;
    if (addQuotations ?? false) {
      translatedString = '"$translatedString"';
    }
    if (toUpper ?? false) {
      translatedString = translatedString.toUpperCase();
    }

    return Text(
      translatedString.tr,
      style: style ??
          textStyle(
            fontSize: 13.sp,
            color: isDark ? whiteColor : secondaryColor,
          ),
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap ?? true,
      textScaler: TextScaler.linear(textScaleFactor ?? 1.0),
      overflow: overflow ?? TextOverflow.clip,
    );
  }
}
