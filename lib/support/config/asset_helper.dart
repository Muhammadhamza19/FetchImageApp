import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> doesAssetExist(String assetPath) async {
  try {
    await rootBundle.load(assetPath);
    return true;
  } catch (e) {
    return false;
  }
}

Future<Map<String, dynamic>?> getJsonFromAssets(String assetPath) async {
  try {
    return json.decode(await rootBundle.loadString(assetPath));
  } catch (ex) {
    debugPrint(ex.toString());
    return null;
  }
}
