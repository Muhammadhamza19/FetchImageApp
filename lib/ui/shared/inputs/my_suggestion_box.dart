import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/support/config/app_theme.dart';
import 'package:image_app/ui/shared/inputs/my_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySuggestionBox extends StatefulWidget {
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

  // New parameters for suggestions
  final List<String>? suggestions;
  final Function(String)? onSuggestionSelected;
  final bool showSuggestionsOnFocus;
  final int maxSuggestionsHeight;
  final bool caseSensitiveSearch;

  const MySuggestionBox({
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
    // Suggestions parameters
    this.suggestions,
    this.onSuggestionSelected,
    this.showSuggestionsOnFocus = true,
    this.maxSuggestionsHeight = 200,
    this.caseSensitiveSearch = false,
  });

  @override
  MyInputBoxWithSuggestionsState createState() =>
      MyInputBoxWithSuggestionsState();
}

class MyInputBoxWithSuggestionsState extends State<MySuggestionBox> {
  late TextEditingController _textController;
  late FocusNode _focusNode;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List<String> _filteredSuggestions = [];
  bool showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _textController = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    if (widget.inputValue != null) {
      _textController.text = widget.inputValue!;
    }

    _focusNode.addListener(_onFocusChanged);
    _updateFilteredSuggestions(_textController.text);
  }

  @override
  void dispose() {
    _hideOverlay();
    if (widget.controller == null) {
      _textController.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      if (widget.showSuggestionsOnFocus && _hasSuggestions()) {
        _showSuggestionsOverlay();
      }
    } else {
      _hideOverlay();
    }
  }

  void _updateFilteredSuggestions(String query) {
    if (widget.suggestions == null || widget.suggestions!.isEmpty) {
      _filteredSuggestions = [];
      return;
    }

    if (query.isEmpty && widget.showSuggestionsOnFocus) {
      _filteredSuggestions = List.from(widget.suggestions!);
    } else {
      _filteredSuggestions = widget.suggestions!.where((suggestion) {
        final searchText =
            widget.caseSensitiveSearch ? suggestion : suggestion.toLowerCase();
        final queryText =
            widget.caseSensitiveSearch ? query : query.toLowerCase();
        return searchText.contains(queryText);
      }).toList();
    }
  }

  bool _hasSuggestions() {
    return widget.suggestions != null && widget.suggestions!.isNotEmpty;
  }

  void _onTextChanged(String value) {
    _updateFilteredSuggestions(value);

    if (_hasSuggestions() && _focusNode.hasFocus) {
      if (_filteredSuggestions.isNotEmpty) {
        _showSuggestionsOverlay();
      } else {
        _hideOverlay();
      }
    }

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  void _onSuggestionTap(String suggestion) {
    _textController.text = suggestion;
    _hideOverlay();

    if (widget.onSuggestionSelected != null) {
      widget.onSuggestionSelected!(suggestion);
    }

    if (widget.onChanged != null) {
      widget.onChanged!(suggestion);
    }
  }

  void _showSuggestionsOverlay() {
    if (_overlayEntry != null || _filteredSuggestions.isEmpty) return;

    setState(() {
      showSuggestions = true;
    });

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width -
            32, // Adjust based on your padding
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0.0, 56.0), // Adjust based on your input height
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: widget.maxSuggestionsHeight.toDouble(),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? secondaryColor : whiteColor,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: isDark ? primaryColor : textFieldBorderColor,
                  ),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: _filteredSuggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = _filteredSuggestions[index];
                    return InkWell(
                      onTap: () => _onSuggestionTap(suggestion),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          border: index < _filteredSuggestions.length - 1
                              ? Border(
                                  bottom: BorderSide(
                                    color: isDark
                                        ? primaryColor.withValues(alpha: 0.3)
                                        : textFieldBorderColor.withValues(
                                            alpha: 0.3),
                                  ),
                                )
                              : null,
                        ),
                        child: MyText(
                          suggestion,
                          style: textStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark ? whiteColor : secondaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      setState(() {
        showSuggestions = false;
      });
    }
  }

  bool get isKeyboardInput => true;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        key: Key('inputBoxWithSuggestions_${widget.keyIndex ?? ""}'),
        child: GestureDetector(
          onTap: widget.disable ? null : widget.onTap,
          child: _inputBox(),
        ),
      ),
    );
  }

  Widget _inputBox() {
    return TextFormField(
      style: textStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: isDark ? whiteColor : secondaryColor,
      ),
      enableInteractiveSelection: widget.enableInteractiveSelection ?? false,
      keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
      maxLines: widget.maxLines ?? 1,
      focusNode: _focusNode,
      autofocus: widget.autofocus ?? false,
      controller: _textController,
      obscureText: widget.obscureText ?? false,
      onFieldSubmitted: (value) {
        _hideOverlay();
        if (widget.onFieldSubmitted != null) {
          widget.onFieldSubmitted!(value);
        }
      },
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
        iconColor: widget.iconColor ?? primaryColor,
        enabledBorderColor: widget.borderColor ?? textFieldBorderColor,
        floatingLabelBehavior: widget.floatingLabelBehavior,
        onTranslate: widget.translate ?? () {},
      ),
      textInputAction: widget.textInputAction ?? TextInputAction.done,
      onChanged: _onTextChanged,
      onTap: () {
        if (_hasSuggestions() && widget.showSuggestionsOnFocus) {
          _showSuggestionsOverlay();
        }
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
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
