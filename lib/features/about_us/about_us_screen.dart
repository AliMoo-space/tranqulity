import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/styling/app_colors.dart';

/// About Us screen – maps to about_us.yaml in generated/.
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top row ──────────────────────────────────────────────
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      // TODO: replace with actual asset: assets/icons/epback.svg
                      color: AppColors.tranquilityColor,
                      size: 22.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'About Us',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff101010),
                    ),
                  ),
                ],
              ),
            ),

            // ── App logo / image ──────────────────────────────────────
            Center(
              child: Container(
                width: 200.w,
                height: 200.h,
                decoration: BoxDecoration(
                  color: AppColors.tranquilityColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.spa_outlined,
                  // TODO: replace with actual asset: assets/images/about_us_logo
                  size: 80.sp,
                  color: AppColors.tranquilityColor,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // ── Tagline ───────────────────────────────────────────────
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Welcome to Tranquility\nwhere relaxation meets innovation.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // ── Description paragraphs ────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  _Paragraph(
                    text:
                        'Welcome to Tranquility – your personal assistant in the digital world. '
                        'At Tranquility, we believe that everyone deserves a moment of peace and calm '
                        'amidst the chaos of everyday life. Our mission is to provide a sanctuary where '
                        'you can unwind, destress, and find solace through meaningful conversations '
                        'with our AI chatbot.',
                  ),
                  _Paragraph(
                    text:
                        "In today's fast-paced world, it's easy to feel overwhelmed and anxious. "
                        "That's why we've created Tranquility – to offer you a refuge where you can "
                        'freely express yourself without fear of judgment or interruption. Whether '
                        "you're seeking advice, a listening ear, or simply some company, our AI chatbot "
                        'is here to support you every step of the way.',
                  ),
                  _Paragraph(
                    text:
                        "Our team is passionate about mental well-being and technology, and we're "
                        'dedicated to harnessing the power of AI to promote relaxation and mindfulness. '
                        'With Tranquility, you can embark on a journey of self-discovery, self-care, '
                        'and self-improvement, all from the comfort of your smartphone.',
                  ),
                  _Paragraph(
                    text:
                        'So why wait? Take a deep breath, download Tranquility, and let our AI '
                        'chatbot guide you on your path to inner peace and tranquility. Together, we '
                        'can create a brighter, calmer future – one conversation at a time.',
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Helper
// ---------------------------------------------------------------------------
class _Paragraph extends StatelessWidget {
  final String text;

  const _Paragraph({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
          height: 1.6,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
