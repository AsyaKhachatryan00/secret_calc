import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:secret_calc/core/confing/constants/storage_keys.dart';
import 'package:secret_calc/core/confing/theme/app_colors.dart';
import 'package:secret_calc/core/utils/shared_prefs.dart';
import 'package:secret_calc/service_locator.dart';

class DialogScreen extends StatelessWidget {
  const DialogScreen({this.title, this.content, this.onTap, super.key});
  final String? title;
  final String? content;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: CupertinoAlertDialog(
        title: Text(
          title ??
              "“SecretCalc: CheatPad” Would Like to Send You Notifications",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          content ??
              "Notifications can include alerts, sounds, and icons. You can customize them in Settings.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: false,
            onPressed: () async {
              if (title != null) {
                onTap?.call();
              } else {
                await locator<SharedPrefs>().setBool(
                  StorageKeys.isNotificationsOn,
                  false,
                );
                Get.back();
              }
            },
            child: Text(
              title != null ? 'Yes' : "Don't allow",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: title != null ? AppColors.red : AppColors.blue,
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              if (title == null) {
                await locator<SharedPrefs>().setBool(
                  StorageKeys.isNotificationsOn,
                  true,
                );
                Get.back();
              } else {
                Get.back();
              }
            },
            child: Text(
              title != null ? 'No' : "OK",
              style: TextStyle(color: AppColors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
