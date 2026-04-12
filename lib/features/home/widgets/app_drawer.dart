import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_assets.dart';
import 'package:tranqulity/core/styling/app_colors.dart';

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
                  backgroundImage:
                      const AssetImage(AppAssets.personPlaceholder),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Sara',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '01027545631',
                  style: TextStyle(
                    fontFamily: 'Inter',
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
                  _DrawerItem(
                    svgPath: AppAssets.aboutUs,
                    label: 'About Us',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoutes.aboutUsScreen);
                    },
                  ),
                  _DrawerItem(
                    svgPath: AppAssets.rate,
                    label: 'Rate Our App',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Open app store rating
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Rate Our App – coming soon!')),
                      );
                    },
                  ),
                  _DrawerItem(
                    svgPath: AppAssets.suggestions,
                    label: 'Suggestions',
                    onTap: () {
                      Navigator.pop(context);
                      context.push(AppRoutes.suggestionsScreen);
                    },
                  ),
                  _DrawerItem(
                    svgPath: AppAssets.enableEasyLogin,
                    label: 'Enable Easy Login',
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: biometric/easy login toggle
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Easy Login – toggle coming soon!')),
                      );
                    },
                  ),
                  const Spacer(),
                  // Logout (red)
                  _DrawerItem(
                    svgPath: AppAssets.logOut,
                    label: 'Logout',
                    labelColor: const Color(0xffFF3A3A),
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

// ---------------------------------------------------------------------------
// Drawer item
// ---------------------------------------------------------------------------
class _DrawerItem extends StatelessWidget {
  final String svgPath;
  final String label;
  final Color? labelColor;
  final VoidCallback onTap;

  const _DrawerItem({
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
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
