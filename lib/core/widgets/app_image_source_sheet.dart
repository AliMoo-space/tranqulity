import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/styling/app_dimensions.dart';
import 'package:tranqulity/core/styling/app_styles.dart';

class AppImageSourceSheet extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;

  const AppImageSourceSheet({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.xl.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pick Image From...',
            style: AppStyles.black18BoldStyle.copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppDimensions.xl.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AppImageSourceOption(
                icon: Icons.photo_camera,
                label: 'Camera',
                onTap: onCameraTap,
              ),
              _AppImageSourceOption(
                icon: Icons.photo_library,
                label: 'Gallery',
                onTap: onGalleryTap,
              ),
            ],
          ),
          SizedBox(height: AppDimensions.lg.h),
        ],
      ),
    );
  }
}

class _AppImageSourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AppImageSourceOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 90.w,
            height: 90.h,
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: BorderRadius.circular(AppDimensions.cardRadius.r),
            ),
            child: Icon(icon, size: 42.sp, color: AppColors.tranquilityColor),
          ),
          SizedBox(height: AppDimensions.sm.h),
          Text(
            label,
            style: AppStyles.body16MediumStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
