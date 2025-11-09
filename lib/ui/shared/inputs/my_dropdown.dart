import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/support/config/app_theme.dart';
import 'package:image_app/ui/shared/inputs/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecibelDropdown<T> extends StatefulWidget {
  final String? label;
  final String? hintText;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final void Function(T?)? onSelected;
  final bool enabled;
  final bool enableSearch;
  final List<TextInputFormatter>? inputFormatters;
  final bool disable;
  final bool labelBold;
  final Color? labelColor;
  final IconData? icon;
  final Color? iconColor;
  final IconData? suffixIcon;
  final Color? suffixColor;
  final Color? borderColor;
  final FloatingLabelBehavior floatingLabelBehavior;
  final bool translate;
  final TextInputType? keyboardType;
  final String? errorText;
  final String? helperText;
  final int? maxLines;
  final Widget? trailingIcon;
  final MenuStyle? menuStyle;
  final double? width;
  final double? menuHeight;
  final TextCapitalization textCapitalization;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? expandedInsets;
  final T? initialSelection;
  const DecibelDropdown({
    super.key,
    this.label,
    this.hintText,
    required this.dropdownMenuEntries,
    this.onSelected,
    this.enabled = true,
    this.enableSearch = true,
    this.inputFormatters,
    this.disable = false,
    this.labelBold = false,
    this.labelColor,
    this.icon,
    this.iconColor,
    this.suffixIcon,
    this.suffixColor,
    this.borderColor,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.translate = false,
    this.keyboardType,
    this.errorText,
    this.helperText,
    this.maxLines = 1,
    this.trailingIcon,
    this.menuStyle,
    this.width,
    this.menuHeight,
    this.textCapitalization = TextCapitalization.none,
    this.textStyle,
    this.expandedInsets,
    this.initialSelection,
  });

  @override
  State<DecibelDropdown> createState() => _DecibelDropdownState<T>();
}

class _DecibelDropdownState<T> extends State<DecibelDropdown<T>> {
  // This will hold the filtered dropdown entries when search is enabled
  List<DropdownMenuEntry<T>> _filteredEntries = [];

  @override
  void initState() {
    super.initState();
    // Initially, set the filtered entries to all dropdown items
    _filteredEntries = widget.dropdownMenuEntries;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      controller: TextEditingController(),
      label: widget.label != null
          ? MyText(
              widget.label!,
              style: textStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? backgroundColor : secondaryColor,
              ),
            )
          : null,
      hintText: widget.hintText,
      dropdownMenuEntries: _filteredEntries,
      onSelected: widget.onSelected,
      enabled: widget.enabled && !widget.disable,
      enableSearch: widget.enableSearch,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      errorText: widget.errorText,
      helperText: widget.helperText,
      trailingIcon: widget.trailingIcon,
      menuStyle: widget.menuStyle ??
          MenuStyle(
            fixedSize: WidgetStateProperty.all(
              const Size.fromWidth(70),
            ),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 10),
            ),
            elevation: WidgetStateProperty.all(4),
            backgroundColor: WidgetStateProperty.all(
              isDark ? secondaryColor : whiteColor,
            ),
            side: WidgetStateProperty.all(
              BorderSide(color: isDark ? primaryColor : textFieldBorderColor),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
      width: widget.width ?? MediaQuery.of(context).size.width,
      menuHeight: widget.menuHeight,
      textStyle: widget.textStyle,
      expandedInsets: widget.expandedInsets,

      // Dynamic options for selection behavior
      selectedTrailingIcon: Icon(widget.suffixIcon),
      alignmentOffset: const Offset(0, 0),
      textAlign: TextAlign.start,
      closeBehavior: DropdownMenuCloseBehavior.all,
      initialSelection: widget.initialSelection,
      filterCallback: widget.enableSearch
          ? (List<DropdownMenuEntry<T>> en, String query) {
              return widget.dropdownMenuEntries
                  .where((entry) =>
                      entry.label.toLowerCase().contains(query.toLowerCase()))
                  .toList();
            }
          : null,
      enableFilter: widget.enableSearch,
      focusNode: FocusNode(),
      requestFocusOnTap: true,
      inputDecorationTheme: inputBoxDecoration(
        fillColor: widget.disable
            ? disabledColor
            : isDark
                ? secondaryColor
                : disabledColor,
        labelBold: widget.labelBold,
        labelColor: widget.labelColor ?? primaryColor,
        icon: widget.icon,
        suffixColor: widget.suffixColor ?? blackColor,
        suffixIcon: widget.suffixIcon,
        iconColor: widget.iconColor ?? primaryColor,
        enabledBorderColor: widget.borderColor ?? textFieldBorderColor,
        floatingLabelBehavior: widget.floatingLabelBehavior,
      ),
    );
  }

  InputDecorationTheme inputBoxDecoration({
    required bool labelBold,
    required IconData? icon,
    required IconData? suffixIcon,
    required Color iconColor,
    required Color labelColor,
    required Color suffixColor,
    required Color? enabledBorderColor,
    required Color fillColor,
    required FloatingLabelBehavior floatingLabelBehavior,
  }) {
    return InputDecorationTheme(
        alignLabelWithHint: true,
        hintStyle: textStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isDark ? backgroundColor : secondaryColor,
        ),
        labelStyle: textStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isDark ? backgroundColor : secondaryColor,
        ),
        floatingLabelBehavior: floatingLabelBehavior,
        fillColor: fillColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: isDark ? backgroundColor : primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDark ? primaryColor : enabledBorderColor!,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ));
  }
}
