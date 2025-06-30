import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:secret_calc/core/confing/theme/app_colors.dart';
import 'package:secret_calc/features/calculator/controller/clc_controller.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  late final CalculatorController controller;

  final List<List<String>> buttons = [
    ['CE', 'C', '%', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['+/-', '0', ',', '='],
  ];

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<CalculatorController>()) {
      controller = Get.find<CalculatorController>();
    } else {
      controller = Get.put(CalculatorController());
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 753.h,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColors.white,
                size: 40,
              ),
            ),
          ),
          // History & Display
          Expanded(
            child: Obx(() {
              controller.history.length > 3
                  ? controller.history.removeAt(0)
                  : null;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...controller.history.map((entry) {
                    final parts = entry.split('=');

                    if (controller.expression.value.contains(parts.first)) {
                      return SizedBox.shrink();
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            parts[0],
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  color: AppColors.white.withAlpha(75),
                                ),
                          ),
                          Text(
                            parts[1],
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  color: AppColors.white.withAlpha(75),
                                ),
                          ),
                          SizedBox(height: 8.h),
                        ],
                      ),
                    );
                  }),
                  if (controller.expression.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Text(
                        controller.expression.value,
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  if (controller.result.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '= ',
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontSize: 40,
                                ),
                          ),
                          Text(
                            controller.result.value,
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontSize: 48,
                                ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            }),
          ),

          // Buttons
          Column(
            children: buttons.map((row) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: row.map((label) {
                    final isOperator = [
                      '÷',
                      '×',
                      '-',
                      '+',
                      '=',
                    ].contains(label);
                    return _buildButton(
                      label,
                      controller,
                      color: isOperator
                          ? AppColors.jewe
                          : AppColors.mainBgColor,
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildButton(
    String label,
    CalculatorController controller, {
    Color color = AppColors.mainBgColor,
  }) {
    return GestureDetector(
      onTap: () => controller.onButtonPressed(label),
      child: Container(
        width: 70.w,
        height: 70.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              offset: const Offset(3, 3),
              blurRadius: 6.r,
            ),
          ],
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.white,
            fontSize: 24.sp,
          ),
        ),
      ),
    );
  }
}
