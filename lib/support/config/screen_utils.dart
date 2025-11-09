import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenUtil {
  /// Returns dynamic spacing based on screen height
  static double getDynamicSpacing() {
    final double height = Get.height; // Get screen height dynamically

    if (height < 640) {
      return 6; // Small phones (e.g., iPhone SE, old Android devices)
    } else if (height >= 640 && height < 750) {
      return 8; // Standard smartphones (e.g., iPhone 14, Pixel 6)
    } else if (height >= 750 && height < 900) {
      return 10; // Large phones (e.g., iPhone 14 Pro Max, Galaxy S21)
    } else if (height >= 900 && height < 1100) {
      return 15; // Phablets & Small Tablets
    } else if (height >= 1100 && height < 1300) {
      return 18; // OnePlus 8 Pro, Medium Tablets
    } else {
      return 18; // Large Tablets & Desktops
    }
  }

  double responsiveFontSize(BuildContext context, double baseFontSize) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 400) {
      return baseFontSize - 2;
    }
    return baseFontSize;
  }
}
