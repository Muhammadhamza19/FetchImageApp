import 'package:image_app/support/config/app_color.dart';
import 'package:image_app/support/config/app_theme.dart';
import 'package:image_app/ui/shared/inputs/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_app/ui/shared/components/shimmer_components/box_size.dart';
import 'package:image_app/ui/shared/components/shimmer_components/shimmer_widget.dart';

class ProgressionButtonView extends StatelessWidget {
  final List<ProgressionButton> progressionButtons;
  final bool showBorder;
  final bool loading;
  final WrapAlignment? wrapAlignment;
  final bool removeDecoration;
  final bool fullWidth;
  final double? runSpacing;
  final bool shrink;
  final Color? dominantColor;
  const ProgressionButtonView({
    super.key,
    required this.progressionButtons,
    this.showBorder = true,
    this.loading = false,
    this.wrapAlignment,
    this.removeDecoration = false,
    this.fullWidth = false,
    this.runSpacing,
    this.shrink = true,
    this.dominantColor,
  });

  @override
  Widget build(BuildContext context) {
    if (progressionButtons.isEmpty) return const SizedBox();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: shrink ? 8 : 25,
        horizontal: 10,
      ),
      width: Get.width,
      decoration: removeDecoration
          ? null
          : BoxDecoration(
              color: !isDark
                  ? dominantColor ?? (isDark ? secondaryColor : whiteColor)
                  : (isDark ? secondaryColor : whiteColor),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              border: showBorder
                  ? Border(
                      top: BorderSide(
                        color: dividerColor,
                      ),
                    )
                  : null),
      child: Wrap(
        runSpacing: runSpacing ?? 20,
        spacing: 2,
        alignment: wrapAlignment ?? WrapAlignment.center,
        children: loading ? _loadingView() : _buttonRow(),
      ),
    );
  }

  List<Widget> _buttonRow() {
    return progressionButtons
        .map(
          (button) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: MyButton(
              fullWidth: fullWidth,
              text: button.text.tr,
              iconData: button.icon,
              iconSize: button.iconSize,
              iconPosition: button.iconPosition,
              textColor: button.textColor,
              color: button.color,
              onPressed: button.onPressed,
              minWidth: button.minWidth ?? Get.width * 0.3,
              borderColor: button.borderColor,
              badgeCount: button.count,
            ),
          ),
        )
        .toList();
  }

  List<Widget> _loadingView() {
    return progressionButtons
        .map(
          (button) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
            child: ShimmerWidget(
              child: Box(explicitHeight: 36.0, width: BoxSize.quarter),
            ),
          ),
        )
        .toList();
  }
}

class ProgressionButton {
  final String text;
  final IconData? icon;
  final double? iconSize;
  final Color? color;
  final VoidCallback? onPressed;
  final IconPosition iconPosition;
  final Color? textColor;
  final Color? borderColor;
  final double? minWidth;
  final int? count;

  ProgressionButton({
    required this.text,
    this.icon,
    this.iconSize,
    this.textColor,
    this.color,
    this.minWidth,
    this.onPressed,
    this.borderColor,
    this.count,
    this.iconPosition = IconPosition.start,
  });

  ProgressionButton.iconEnd({
    required this.text,
    this.icon,
    this.iconSize,
    this.textColor,
    this.color,
    this.borderColor,
    this.minWidth,
    this.onPressed,
    this.count,
    this.iconPosition = IconPosition.end,
  });

  ///cancel, delete, reject, decline, close
  ProgressionButton.cancel({
    this.text = 'cancel',
    this.icon = Icons.cancel,
    this.borderColor = Colors.red,
    this.iconPosition = IconPosition.start,
    this.iconSize,
    this.textColor = Colors.red,
    this.color = Colors.white,
    this.minWidth,
    this.count,
    this.onPressed,
  });

  ///submit, save, confirm, accept, done, approve
  ProgressionButton.submit({
    this.text = 'submit',
    this.icon = Icons.check_circle,
    this.borderColor,
    this.iconPosition = IconPosition.start,
    this.iconSize,
    this.textColor,
    this.color,
    this.minWidth,
    this.count,
    this.onPressed,
  });

  ///edit, update, modify
  ProgressionButton.edit({
    this.text = 'edit',
    this.icon = Icons.edit,
    this.borderColor,
    this.iconPosition = IconPosition.start,
    this.iconSize,
    this.textColor,
    this.color,
    this.minWidth,
    this.count,
    this.onPressed,
  });
}
