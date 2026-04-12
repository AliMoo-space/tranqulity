import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_assets.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/widgets/primary_button_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<_OnboardingData> _pages = [
    _OnboardingData(
      imagePath: AppAssets.onBoarding1,
      title: 'Feel Free',
      description:
          "because I'm the friendly chatbot here to assist you with anything you need.",
    ),
    _OnboardingData(
      imagePath: AppAssets.onBoarding2,
      title: 'Ask For Anything',
      description:
          "I'm your friendly neighborhood chatbot ready to assist you with any questions or concerns.",
    ),
    _OnboardingData(
      imagePath: AppAssets.onBoarding3,
      title: 'Your Secret is Safe',
      description: 'Our platform prioritizes your privacy and security.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _skip() => context.go(AppRoutes.loginScreen);

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(AppRoutes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemCount: _pages.length,
              itemBuilder: (_, i) => _OnboardingPage(data: _pages[i]),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 32.h),
            child: Column(
              children: [
                // Dot indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_pages.length, (i) {
                    final active = _currentPage == i;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: active ? 24.w : 10.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: active
                            ? AppColors.tranquilityColor
                            : AppColors.tranquilityColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentPage < _pages.length - 1)
                      TextButton(
                        onPressed: _skip,
                        child: Text(
                          'skip',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.tranquilityColor.withValues(alpha: 0.6),
                            fontFamily: 'Inter',
                          ),
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    _currentPage < _pages.length - 1
                        ? GestureDetector(
                            onTap: _next,
                            child: Container(
                              width: 60.w,
                              height: 60.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.tranquilityColor,
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          )
                        : PrimrayButtonWidget(
                            buttonText: 'Get Started',
                            buttonColor: AppColors.tranquilityColor,
                            onPress: _next,
                            width: 200.w,
                            height: 56.h,
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------
class _OnboardingData {
  final String imagePath;
  final String title;
  final String description;

  const _OnboardingData({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

// ---------------------------------------------------------------------------
// Single page
// ---------------------------------------------------------------------------
class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(
                data.imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 28.h),
          Text(
            data.title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            data.description,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
