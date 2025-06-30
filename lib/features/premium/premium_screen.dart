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
import 'package:secret_calc/service_locator.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splashLogo),
            alignment: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                Text(
                  'Way to Support Us',
                  style: GoogleFonts.rubik(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w700,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Colors.white,
                  ),
                ),
                Text(
                  'Way to Support Us',
                  style: GoogleFonts.rubik(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainBgColor,
                  ),
                ),
              ],
            ),
            Text(
              'Support the project and help us to be even better for only \$0.49.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: AppColors.white),
            ),
            SizedBox(height: 250.h),

            CustomButton(
              data: 'Support for \$0.49',
              onTap: () async {
                await locator<SharedPrefs>().setBool(
                  StorageKeys.isPremium,
                  true,
                );
                Get.offAllNamed(RouteLink.main);
              },
            ),
            SizedBox(height: 15.h),
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
                  'Restore',
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
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
