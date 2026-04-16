import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/styling/app_styles.dart';

class HomeNavItem extends StatelessWidget {
  final String assetPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const HomeNavItem({
    super.key,
    required this.assetPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetPath,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              isActive ? AppColors.whiteColor : Colors.white54,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppStyles.grey12MediumStyle.copyWith(
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
              color: isActive ? AppColors.whiteColor : Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
