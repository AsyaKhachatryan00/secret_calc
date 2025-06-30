import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:secret_calc/core/confing/theme/app_colors.dart';
import 'package:secret_calc/core/route/app_navigations.dart';
import 'package:secret_calc/core/route/routes.dart';
import 'package:secret_calc/features/main/controller/main_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final MainController _controller;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<MainController>()) {
      _controller = Get.find<MainController>();
    } else {
      _controller = Get.put(MainController());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      bottomNavigationBar: InkWell(
        onTap: () => _controller.onTapOpenCalc(),
        child: Container(
          alignment: Alignment.topCenter,
          width: double.infinity,
          height: 69.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          child: Icon(
            Icons.keyboard_arrow_up_outlined,
            color: AppColors.white,
            size: 40,
          ),
        ),
      ),
      body: SafeArea(
        child: Navigator(
          key: AppRoute().nested,
          initialRoute: RouteLink.home,
          onGenerateRoute: AppRoute().generateNestedRoute,
        ),
      ),
    );
  }
}
