import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_assets.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/widgets/primary_button_widget.dart';
import 'package:tranqulity/features/onboarding/widgets/onboarding_page_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<OnboardingPageData> _pages = [
    OnboardingPageData(
      imagePath: AppAssets.onBoarding1,
      title: 'Feel Free',
      description:
          "because I'm the friendly chatbot here to assist you with anything you need.",
    ),
    OnboardingPageData(
      imagePath: AppAssets.onBoarding2,
      title: 'Ask For Anything',
      description:
          "I'm your friendly neighborhood chatbot ready to assist you with any questions or concerns.",
    ),
    OnboardingPageData(
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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompactHeight = constraints.maxHeight < 760;
            final horizontalPadding = constraints.maxWidth < 360 ? 16.w : 24.w;
            final ctaWidth = (constraints.maxWidth - (horizontalPadding * 2))
                .clamp(160.0, 260.0)
                .toDouble();

            return Column(
              children: [
                Expanded(
                  flex: isCompactHeight ? 7 : 8,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    itemCount: _pages.length,
                    itemBuilder: (_, i) =>
                        OnboardingPageWidget(data: _pages[i]),
                  ),
                ),
                Expanded(
                  flex: isCompactHeight ? 3 : 2,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        0,
                        horizontalPadding,
                        24.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                                      : AppColors.tranquilityColor.withValues(
                                          alpha: 0.3,
                                        ),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 24.h),
                          if (_currentPage < _pages.length - 1)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: _skip,
                                  child: Text(
                                    'skip',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.tranquilityColor
                                          .withValues(alpha: 0.6),
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                                GestureDetector(
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
                                ),
                              ],
                            )
                          else
                            Center(
                              child: AppPrimaryButton(
                                buttonText: 'Get Started',
                                buttonColor: AppColors.tranquilityColor,
                                onPress: _next,
                                width: ctaWidth,
                                height: 56.h,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
