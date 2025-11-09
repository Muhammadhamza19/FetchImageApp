import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_app/startup.dart';
import 'package:image_app/support/config/app_config.dart';
import 'package:image_app/support/config/app_shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize shared preferences
    await AppSharedPref.init();
    await FastCachedImageConfig.init();
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');

    final appConfig = AppConfig();
    await appConfig.initialise(flavor);

    await initDependencies(appConfig);

    runApp(
      const Startup(),
    );
  } catch (e, stack) {
    debugPrint('❌ App failed to start: $e\n$stack');
  } finally {}
}

Future<void> initDependencies(AppConfig appConfig) async {
  // App Config
  Get.put<AppConfig>(appConfig);
}
