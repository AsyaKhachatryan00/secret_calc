import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:secret_calc/core/confing/constants/storage_keys.dart';
import 'package:secret_calc/core/confing/theme/app_colors.dart';
import 'package:secret_calc/core/route/routes.dart';
import 'package:secret_calc/core/utils/shared_prefs.dart';
import 'package:secret_calc/core/widgets/custom_button.dart';
import 'package:secret_calc/features/settings/widgets/custom_swich.dart';
import 'package:secret_calc/features/settings/widgets/terms_widget.dart';
import '../../service_locator.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _prefs = locator<SharedPrefs>();
  RxBool _isNotsOn = true.obs;
  RxBool _isPremium = false.obs;

  @override
  void initState() {
    super.initState();

    _isNotsOn = _prefs.getBool(StorageKeys.isNotificationsOn).obs;
    _isPremium = _prefs.getBool(StorageKeys.isPremium).obs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: Text(
          'Settings',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(color: AppColors.white),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              CustomSwitch(
                value: _isNotsOn.value,
                onChanged: (value) async {
                  await locator<SharedPrefs>().setBool(
                    StorageKeys.isNotificationsOn,
                    value,
                  );
                  _isNotsOn.value = value;
                },
              ),

              SizedBox(height: 14.h),
              Container(
                height: 86.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColors.primary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TermsWidget(data: "Privacy policy"),
                    TermsWidget(data: "Terms of Use"),
                  ],
                ),
              ),

              SizedBox(height: 15.h),
              CustomButton(
                data: _isPremium.value ? 'Thank You!' : 'Way to Support us!',
                onTap: () =>
                    !_isPremium.value ? Get.toNamed(RouteLink.premium) : null,
                color: AppColors.white,
                textColor: AppColors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
