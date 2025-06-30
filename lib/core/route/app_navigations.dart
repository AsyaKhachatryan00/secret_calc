import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secret_calc/app_service.dart';
import 'package:secret_calc/core/route/routes.dart';
import 'package:secret_calc/core/utils/shared_prefs.dart';
import 'package:secret_calc/features/main/main_screen.dart';
import 'package:secret_calc/features/notes/new_note_screen.dart';
import 'package:secret_calc/features/notes/notes_list.dart';
import 'package:secret_calc/features/premium/premium_screen.dart';
import 'package:secret_calc/features/settings/settings_screen.dart';
import 'package:secret_calc/features/splash/splash_screen.dart';
import 'package:secret_calc/models/editing_model.dart';
import 'package:secret_calc/service_locator.dart';

class AppRoute {
  static final AppRoute _singltone = AppRoute._internal();

  factory AppRoute() => _singltone;

  AppRoute._internal();
  final main = Get.nestedKey(0);
  final nested = Get.nestedKey(1);

  Bindings? initialBinding() {
    return BindingsBuilder(() {
      Get.put<AppService>(AppService(prefs: locator<SharedPrefs>()));
    });
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLink.splash:
        return pageRouteBuilder(page: const SplashScreen());

      case RouteLink.main:
        return pageRouteBuilder(page: const MainScreen());

      case RouteLink.settings:
        return pageRouteBuilder(page: SettingsScreen());

      case RouteLink.premium:
        return pageRouteBuilder(page: PremiumScreen());

      default:
        return pageRouteBuilder(
          page: Scaffold(body: Container(color: Colors.red)),
        );
    }
  }

  GetPageRoute pageRouteBuilder({
    required Widget page,
    RouteSettings? settings,
  }) => GetPageRoute(
    transitionDuration: Duration.zero,
    page: () => page,
    settings: settings,
  );

  Route? generateNestedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLink.note:
        final data = settings.arguments as EditingModel;

        return pageRouteBuilder(page: NewNoteScreen(model: data));

      case RouteLink.home:
        return pageRouteBuilder(page: NotesList());
    }
    return null;
  }
}
