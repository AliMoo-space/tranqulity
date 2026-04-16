import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/styling/app_styles.dart';

class AuthSocialLoginButton extends StatelessWidget {
  final String label;
  final Color color;
  final String iconPath;
  final VoidCallback onTap;

  const AuthSocialLoginButton({
    super.key,
    required this.label,
    required this.color,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 331.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24.w,
              height: 24.h,
              colorFilter: const ColorFilter.mode(
                AppColors.whiteColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: AppStyles.body16MediumStyle.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
  });
  final Color color;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 382.w,
        height: 70.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 6,
              offset: Offset(1, 2),
            ),
          ],
          color: color,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              height: 70.h,
              width: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.white,
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 28.w,
                  height: 28.w,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
