import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
Future<Map<String, dynamic>> getDeviceInfo() async {
  Map<String, dynamic> deviceDetails = {};
  try {
    if (Platform.isAndroid) {
      // Android Device Info
      final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceDetails = {
        'platform': 'Android',
        'deviceName': androidInfo.model, // Device name for Android
        'deviceInfo':
            'Android ${androidInfo.version.release}', // OS info for Android
        'deviceId': androidInfo.id, // Unique device ID for Android
      };
    } else if (Platform.isIOS) {
      // iOS Device Info
      final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceDetails = {
        'platform': 'iOS',
        'deviceName': iosInfo.utsname.machine,
        'deviceInfo': 'iOS ${iosInfo.systemVersion}',
        'deviceId': iosInfo.identifierForVendor,
      };
    }
  } catch (e) {
    print("Error fetching device info: $e");
  }
  return deviceDetails;
}

/// To keep things simple and "generic" we deal with small, medium, large.
/// This means platform, mobile or desktop, is irrelevant.
/// In general, based on width -
/// [small] mobile (<600)
/// [medium] tablet (600-950)
/// [large] desktop/large tablets (>950)
enum ScreenSize { small, medium, large }

ScreenSize getScreenSize(BuildContext context) {
  final deviceWidth = _getDeviceWidth(context);
  if (deviceWidth > 950) {
    return ScreenSize.large;
  }
  if (deviceWidth > 600) {
    return ScreenSize.medium;
  }
  return ScreenSize.small;
}

double getScaledSize(BuildContext context, double size) {
  final screenSize = getScreenSize(context);
  double size0 = size;
  if (screenSize == ScreenSize.medium) {
    size0 = size * 1.5;
  }
  if (screenSize == ScreenSize.large) {
    size0 = size * 2;
  }
  return size0;
}

double getMinScaleFactor(BuildContext context) {
  final screenSize = getScreenSize(context);
  if (screenSize == ScreenSize.medium) return 1;
  if (screenSize == ScreenSize.large) return 1;
  return 0.75;
}

double getMaxScaleFactor(BuildContext context) {
  final screenSize = getScreenSize(context);
  if (screenSize == ScreenSize.medium) return 2;
  if (screenSize == ScreenSize.large) return 2.5;
  return 1.5;
}

/// For mobile devices (iOS and Android) the width will depend on the orientation
double _getDeviceWidth(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final orientation = mediaQuery.orientation;
  double deviceWidth = 0.0;

  if ((kIsWeb) && orientation == Orientation.landscape) {
    deviceWidth = mediaQuery.size.height;
  } else {
    deviceWidth = mediaQuery.size.width;
  }
  return deviceWidth;
}

bool isPortrait(BuildContext context) =>
    MediaQuery.of(context).orientation == Orientation.portrait;

bool isLandscape(BuildContext context) =>
    MediaQuery.of(context).orientation == Orientation.landscape;

bool isLargeScreen(BuildContext context) =>
    getScreenSize(context) == ScreenSize.large;

bool isMediumScreen(BuildContext context) =>
    getScreenSize(context) == ScreenSize.medium;

bool isSmallScreen(BuildContext context) =>
    getScreenSize(context) == ScreenSize.small;

/// For dual layout UI changes the device must be Medium or Large and in Landscape
bool useDualLayout(BuildContext context) =>
    getScreenSize(context) != ScreenSize.small &&
    MediaQuery.of(context).orientation == Orientation.landscape;
