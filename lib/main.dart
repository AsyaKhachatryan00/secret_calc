import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:secret_calc/core/confing/theme/app_theme.dart';
import 'package:secret_calc/core/route/app_navigations.dart';
import 'package:secret_calc/service_locator.dart';

import 'core/route/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.standart,
      navigatorKey: AppRoute().main,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteLink.splash,
      onGenerateRoute: AppRoute().generateRoute,
      initialBinding: AppRoute().initialBinding(),
      builder: (context, child) {
        ErrorWidget.builder = (errorDetails) {
          return const Center(
            child: Text(
              "An error occurred. Please try again later",
              style: TextStyle(fontSize: 14),
            ),
          );
        };
        return child ?? SizedBox();
      },
    );
  }
}
