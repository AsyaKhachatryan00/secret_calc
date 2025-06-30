import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secret_calc/core/confing/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.data,
    this.onTap,
    this.color,
    this.textColor,
    this.size,
    this.child,
  });

  final String? data;
  final void Function()? onTap;
  final Color? color;
  final Color? textColor;
  final double? size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 46.h,
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: data != null
            ? Text(
                data!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: textColor ?? AppColors.white,
                  fontSize: size ?? 16.sp,
                ),
              )
            : child,
      ),
    );
  }
}
