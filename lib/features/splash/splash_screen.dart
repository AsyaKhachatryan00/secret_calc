import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secret_calc/core/confing/constants/app_assets.dart';
import 'package:secret_calc/core/confing/constants/storage_keys.dart';
import 'package:secret_calc/core/confing/theme/app_colors.dart';
import 'package:secret_calc/core/route/routes.dart';
import 'package:secret_calc/core/utils/shared_prefs.dart';
import 'package:secret_calc/core/widgets/custom_button.dart';
import 'package:secret_calc/core/widgets/dialog_screen.dart';
import 'package:secret_calc/service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  RxBool startAnimations = false.obs;
  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_opacityController)..addListener(updateUi);

    Future.delayed(const Duration(milliseconds: 500), () {
      startAnimations.value = true;
      _opacityController.forward();
    });

    _opacityController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(microseconds: 3000), () async {
          final isNotificationsOn = locator<SharedPrefs>().getBool(
            StorageKeys.isNotificationsOn,
          );
          if (!isNotificationsOn) {
            openNotDialog();
          }
        });
      }
    });
  }

  updateUi() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _opacityAnimation.removeListener(updateUi);
    _opacityController.dispose();
  }

  void openNotDialog() {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => DialogScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: 1 - _opacityAnimation.value,
            duration: Duration(milliseconds: 500),
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(AppImages.splashIcn),
            ),
          ),
          AnimatedOpacity(
            opacity: _opacityController.value,
            duration: Duration(milliseconds: 1000),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.splashLogo),
                  alignment: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'SecretCalc:',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.white,
                      fontSize: 32,
                      height: 0.5,
                    ),
                  ),
                  Stack(
                    children: [
                      Text(
                        'CheatPad',
                        style: GoogleFonts.rubik(
                          fontSize: 64.sp,
                          fontWeight: FontWeight.w700,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.white,
                        ),
                      ),
                      Text(
                        'CheatPad',
                        style: GoogleFonts.rubik(
                          fontSize: 64.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.mainBgColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 250.h),

                  CustomButton(
                    data: 'Continue',
                    onTap: () => Get.offAllNamed(RouteLink.main),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Privacy Policy',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        'Terms of Use',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 14.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 52.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
