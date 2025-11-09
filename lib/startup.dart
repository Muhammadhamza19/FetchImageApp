import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_app/support/config/app_strings.dart';
import 'package:image_app/support/config/app_theme.dart';
import 'package:image_app/ui/main_page.dart';

class Startup extends StatelessWidget {
  const Startup({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        translations: AppString(),
        locale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,

        title: 'appName'.tr,

        /// Initial Routing
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => const MainPage(),
          )
        ],

        /// Theme
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

        //Routing
        // onGenerateRoute: Application.router!.generator,
      ),
    );
  }
}
