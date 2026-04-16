import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/styling/app_fonts.dart';

class AppStyles {
  static TextStyle heading24BoldStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.headingTextColor,
  );

  static TextStyle body16RegularStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.blackColor,
  );

  static TextStyle body16MediumStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  );

  static TextStyle label15MediumMutedStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryColor,
  );

  static TextStyle label16SemiBoldOnPrimaryStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );

  static TextStyle primaryHeadLinesStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );

  static TextStyle subtitlesStyles = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryColor,
  );

  static TextStyle black16w500Style = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  );

  static TextStyle grey12MediumStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.greyColor,
  );

  static TextStyle black15BoldStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle black18BoldStyle = TextStyle(
    fontFamily: AppFonts.mainFontName,
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}
