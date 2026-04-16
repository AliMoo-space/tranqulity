import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/styling/app_styles.dart';

class HomeDrawerItem extends StatelessWidget {
  final String svgPath;
  final String label;
  final Color? labelColor;
  final VoidCallback onTap;

  const HomeDrawerItem({
    super.key,
    required this.svgPath,
    required this.label,
    this.labelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = labelColor ?? Colors.black87;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.tranquilityColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPath,
              width: 22.w,
              height: 22.h,
              colorFilter: ColorFilter.mode(
                labelColor ?? AppColors.tranquilityColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: AppStyles.body16MediumStyle.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
