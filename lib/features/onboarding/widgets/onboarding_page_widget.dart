import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPageData {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPageData({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPageData data;

  const OnboardingPageWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(
            data.imagePath,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 28.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
            ],
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
