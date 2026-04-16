import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_assets.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/styling/app_styles.dart';
import 'package:tranqulity/features/home/widgets/home_drawer_item.dart';

/// App Drawer (maps to drawer.yaml) – shows user info header and menu items.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 344.w,
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // ── Header (teal background) ─────────────────────────────────
          Container(
            width: double.infinity,
            color: AppColors.tranquilityColor,
            padding: EdgeInsets.symmetric(vertical: 32.h),
            child: Column(
              children: [
                // Profile image
                CircleAvatar(
                  radius: 56.r,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  backgroundImage: const AssetImage(
                    AppAssets.personPlaceholder,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Sara',
                  style: AppStyles.black18BoldStyle.copyWith(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '01027545631',
                  style: AppStyles.grey12MediumStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // ── Menu items ───────────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  HomeDrawerItem(
                    svgPath: AppAssets.aboutUs,
                    label: 'About Us',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoutes.aboutUsScreen);
                    },
                  ),
                  HomeDrawerItem(
                    svgPath: AppAssets.rate,
                    label: 'Rate Our App',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Open app store rating
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Rate Our App – coming soon!'),
                        ),
                      );
                    },
                  ),
                  HomeDrawerItem(
                    svgPath: AppAssets.suggestions,
                    label: 'Suggestions',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoutes.suggestionsScreen);
                    },
                  ),
                  HomeDrawerItem(
                    svgPath: AppAssets.enableEasyLogin,
                    label: 'Enable Easy Login',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: biometric/easy login toggle
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Easy Login – toggle coming soon!'),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  // Logout (red)
                  HomeDrawerItem(
                    svgPath: AppAssets.logOut,
                    label: 'Logout',
                    labelColor: AppColors.dangerColor,
                    onTap: () {
                      Navigator.pop(context);
                      context.go(AppRoutes.loginScreen);
                    },
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
