import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/support/config/app_theme.dart';
import 'package:image_app/ui/shared/inputs/my_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyInputBox extends StatefulWidget {
  final String? borderLabel;
  final bool labelBold;
  final String? inputValue;
  final Function? clearValue;
  final Function? deleteValue;
  final String? keyIndex;
  final Function()? onTap;
  final Color? borderColor;
  final Color? iconColor;
  final bool disable;
  final bool? enableInteractiveSelection;
  final TextInputType? keyboardType;
  final int? maxLines;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool? obscureText;
  final bool? autofocus;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? translate;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Widget? innerWidget;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool translateInputValue;
  final Color? suffixColor;
  final Color? labelColor;
  final bool mandatory;
  final bool highlightEmptyField;
  final String? errorText;
  final Function()? onSuffixPressed;

  const MyInputBox({
    super.key,
    this.borderLabel,
    this.labelBold = false,
    this.inputValue,
    this.translateInputValue = false,
    this.clearValue,
    this.deleteValue,
    this.keyIndex,
    this.onTap,
    this.borderColor,
    this.disable = false,
    this.enableInteractiveSelection = true,
    this.keyboardType,
    this.maxLines,
    this.labelColor,
    this.icon,
    this.iconColor,
    this.suffixIcon,
    this.textInputAction,
    this.focusNode,
    this.obscureText,
    this.translate,
    this.autofocus,
    this.controller,
    this.onChanged,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.innerWidget,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.suffixColor,
    this.mandatory = false,
    this.highlightEmptyField = false,
    this.errorText,
    this.onSuffixPressed,
  });

  @override
  MyInputBoxState createState() => MyInputBoxState();
}

class MyInputBoxState extends State<MyInputBox> {
  MyInputBoxState();

  bool get isKeyboardInput =>
      widget.onChanged != null || widget.controller != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('inputBox_${widget.keyIndex ?? ""}'),
      child: GestureDetector(
          onTap: widget.disable ? null : widget.onTap, child: _inputBox()),
    );
  }

  Widget _inputBox() {
    return isKeyboardInput
        ? TextFormField(
            style: textStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: isDark ? whiteColor : secondaryColor,
            ),
            initialValue: widget.inputValue,
            enableInteractiveSelection:
                widget.enableInteractiveSelection ?? false,
            keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
            maxLines: widget.maxLines ?? 1,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus ?? false,
            controller: widget.controller,
            obscureText: widget.obscureText ?? false,
            onFieldSubmitted: widget.onFieldSubmitted,
            inputFormatters: widget.inputFormatters ?? [],
            decoration: inputBoxDecoration(
                mandatory: widget.mandatory,
                highlightEmptyField: widget.highlightEmptyField,
                errorText: widget.errorText,
                fillColor: widget.disable
                    ? disabledColor
                    : isDark
                        ? secondaryColor
                        : whiteColor,
                label: widget.borderLabel ?? '',
                onSuffixPressed: widget.onSuffixPressed,
                labelBold: widget.labelBold,
                labelColor: widget.labelColor ?? primaryColor,
                icon: widget.icon,
                suffixColor: widget.suffixColor ?? primaryColor,
                suffixIcon: widget.suffixIcon,
                iconColor: widget.iconColor ??
                    primaryColor, // replace `primaryColor` with actual color if needed
                enabledBorderColor: widget.borderColor ?? textFieldBorderColor,
                floatingLabelBehavior: widget.floatingLabelBehavior,
                onTranslate: widget.translate ?? () {}),
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            onChanged: widget.onChanged,
          )
        : InputDecorator(
            decoration: inputBoxDecoration(
                mandatory: widget.mandatory,
                highlightEmptyField: widget.highlightEmptyField,
                errorText: widget.errorText,
                fillColor: widget.disable
                    ? disabledColor
                    : isDark
                        ? secondaryColor
                        : textFieldColor,
                icon: widget.icon,
                suffixColor: widget.suffixColor ?? primaryColor,
                suffixIcon: widget.suffixIcon,
                onSuffixPressed: widget.onSuffixPressed,
                iconColor: widget.iconColor ??
                    primaryColor, // replace `primaryColor` with actual color if needed
                label: widget.borderLabel ?? '',
                labelBold: widget.labelBold,
                labelColor: widget.labelColor ?? primaryColor,
                floatingLabelBehavior: widget.floatingLabelBehavior,
                enabledBorderColor: ((widget.inputValue ?? "") != "")
                    ? textFieldBorderColor
                    : widget.borderColor ??
                        textFieldBorderColor, // use a default color or `primaryColor`
                onTranslate: widget.translate ?? () {}),
            child: widget.innerWidget ??
                Row(
                  children: <Widget>[
                    Expanded(
                        child: widget.translateInputValue
                            ? MyText(
                                // Make sure to define or replace `TranslatedText`
                                widget.inputValue ?? '',
                                style: textStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? whiteColor : secondaryColor,
                                ),
                              )
                            : Text(
                                widget.inputValue ?? '',
                                style: textStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? whiteColor : secondaryColor,
                                ),
                              )),
                    if (widget.clearValue != null && widget.deleteValue != null)
                      Expanded(child: Container()),
                    if (widget.clearValue != null && widget.deleteValue != null)
                      GestureDetector(
                          onTap: () => widget.deleteValue!(),
                          onLongPress: () => widget.clearValue!(),
                          child: Icon(
                            Icons.backspace,
                            color:
                                primaryColor, // replace `primaryColor` with actual color if needed
                          )),
                  ],
                ),
          );
  }

  InputDecoration inputBoxDecoration({
    required String label,
    required bool labelBold,
    required IconData? icon,
    required IconData? suffixIcon,
    required Color iconColor,
    required Color labelColor,
    required Color suffixColor,
    required Color? enabledBorderColor,
    required Color fillColor,
    required FloatingLabelBehavior floatingLabelBehavior,
    required Function onTranslate,
    required Function()? onSuffixPressed,
    bool highlightEmptyField = false,
    bool mandatory = false,
    String? errorText,
  }) {
    final labelText = MyText(
      // ignore: use_app_strings_for_translated_text
      label,
      style: textStyle(
        fontWeight: labelBold ? FontWeight.bold : FontWeight.normal,
        color: highlightEmptyField || errorText != null
            ? Colors.red[700]
            : secondaryColor,
      ),
    );

    return InputDecoration(
      label: mandatory
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: labelText),
                const Text(' *',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            )
          : labelText,
      error: errorText != null
          ? MyText(
              errorText,
              style: textStyle(
                color: Colors.red[700],
                fontSize: 12.sp,
              ),
            )
          : null,
      alignLabelWithHint: true,
      labelStyle: textStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? whiteColor : const Color(0xFF374151),
      ),
      floatingLabelBehavior: floatingLabelBehavior,
      fillColor: fillColor,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: isDark ? whiteColor : primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: isDark ? primaryColor : enabledBorderColor!,
        ),
      ),
      prefixIcon: icon != null ? Icon(icon, color: iconColor) : null,
      suffixIcon: suffixIcon != null
          ? GestureDetector(
              onTap: onSuffixPressed,
              child: Icon(
                suffixIcon,
                color: suffixColor,
              ),
            )
          : null,
    );
  }
}
