import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final class AppTextStyle {
  AppTextStyle._();

  static TextStyle headlineTextStyle = GoogleFonts.rubik(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle smallTextStyle = GoogleFonts.rubik(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle mediumTextStyle = TextStyle(
    fontFamily: "Sf Pro Text",
    fontWeight: FontWeight.w400,
  );
}
