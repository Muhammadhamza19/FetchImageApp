import 'package:image_app/support/config/app_color.dart';
import 'package:flutter/material.dart';

class MySearchBox extends StatelessWidget {
  const MySearchBox(
      {super.key,
      this.controller,
      required this.onChanged,
      this.suffixIcon,
      this.borderRadius,
      this.iconSize,
      this.hintText,
      this.hintStyle,
      this.keyboardType,
      this.textInputAction,
      this.onSubmitted,
      this.height});
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final IconData? suffixIcon;
  final double? borderRadius, iconSize;
  final String? hintText;
  final TextStyle? hintStyle;
  final double? height;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        textInputAction: textInputAction ?? TextInputAction.search,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hintText ?? 'Search for actions or people',
          hintStyle:
              hintStyle ?? const TextStyle(color: Colors.black26, fontSize: 14),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          fillColor: disabledColor,
          filled: true,
          suffixIcon: Icon(
            size: iconSize ?? 20,
            suffixIcon ?? Icons.search,
            color: disabledTextColor,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 35)),
        ),
      ),
    );
  }
}
