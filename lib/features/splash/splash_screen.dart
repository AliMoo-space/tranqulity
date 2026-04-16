import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(AppRoutes.onboardingScreen);
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              width: 360.w,
              height: 360.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.tranquilityColor.withValues(alpha: 0.08),
              ),
            ),
          ),
          FadeTransition(
            opacity: _fadeAnim,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tranquility',
                  style: TextStyle(
                    // Mystery Quest font – falls back if not installed
                    fontFamily: 'Mystery Quest',
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.tranquilityColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Together Towards Tranquility',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.tranquilityColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
