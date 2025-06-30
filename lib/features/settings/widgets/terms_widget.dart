import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secret_calc/core/confing/theme/app_colors.dart';

class TermsWidget extends StatelessWidget {
  const TermsWidget({required this.data, super.key});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.white,
            fontSize: 14.sp,
          ),
        ),
        Icon(Icons.arrow_forward_ios, color: AppColors.white, size: 15.sp),
      ],
    );
  }
}
