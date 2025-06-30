import 'package:flutter/material.dart';
import 'text_styles.dart';
import 'app_colors.dart';

final class AppTheme {
  AppTheme._();

  static ThemeData get standart {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.white),
        color: AppColors.mainBgColor,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      scaffoldBackgroundColor: AppColors.mainBgColor,
      textTheme: _textTheme,
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.transparent),
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      headlineLarge: AppTextStyle.headlineTextStyle,
      displayMedium: AppTextStyle.mediumTextStyle,
      titleSmall: AppTextStyle.smallTextStyle,
    );
  }
}
