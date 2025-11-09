import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefBaseUrl = "PREF_BASE_URL";
const String prefAccessToken = "PREF_ACCESS_TOKEN";
const String prefActivationCode = "PREF_ACTIVATION_CODE";

class AppSharedPref {
  /// PREF

  static Future<bool> init() async {
    final prefs = await SharedPreferences.getInstance();
    Get.put(prefs);
    return true;
  }

  static void setAccessToken(String accessToken) {
    final SharedPreferences pref = Get.find();
    pref.setString(prefAccessToken, accessToken);
  }

  static String? getAccessToken() {
    final SharedPreferences pref = Get.find();
    final value = pref.getString(prefAccessToken);
    return (value ?? "").isEmpty ? null : value;
  }

  static void setBaseUrl(String baseUrl) {
    final SharedPreferences pref = Get.find();
    pref.setString(prefBaseUrl, baseUrl);
  }

  static String? getBaseUrl() {
    final SharedPreferences pref = Get.find();
    final value = pref.getString(prefBaseUrl);
    return (value ?? "").isEmpty ? null : value;
  }

  static void setActivationCode(String activationCode) {
    final SharedPreferences pref = Get.find();
    pref.setString(prefActivationCode, activationCode);
  }

  static String? getActivationCode() {
    final SharedPreferences pref = Get.find();
    final value = pref.getString(prefActivationCode);
    return (value ?? "").isEmpty ? null : value;
  }

  static Future<void> clearAllPrefs() async {
    final SharedPreferences pref = Get.find();
    await pref.clear();
  }

  static Future<void> removePref(String key) async {
    final SharedPreferences pref = Get.find();
    await pref.remove(key);
  }
}
