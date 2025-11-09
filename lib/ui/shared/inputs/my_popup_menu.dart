import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/support/config/app_theme.dart';
import 'package:image_app/ui/shared/inputs/my_text.dart';
import 'package:flutter/material.dart';

class MyPopupMenu extends StatelessWidget {
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String>? onSelected;

  const MyPopupMenu({
    super.key,
    required this.options,
    this.selectedValue,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (context) {
        return options.map((option) {
          return PopupMenuItem<String>(
            value: option,
            child: MyText(option),
          );
        }).toList();
      },
      child: selectedValue != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyText(
                  selectedValue ?? '',
                  style: textStyle(
                    color: secondaryColor_1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            )
          : null,
    );
  }
}
