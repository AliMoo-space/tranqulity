import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_assets.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/widgets/primary_button_widget.dart';
import 'package:tranqulity/core/widgets/spacing_widgets.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // 4 separate controllers + focus nodes for the OTP boxes
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  bool _isLoading = false;

  // Countdown timer – 90 s  ("01:29" shown in frame_104.yaml)
  static const int _totalSeconds = 30;
  int _secondsLeft = _totalSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = _totalSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  String get _otp =>
      _controllers.map((c) => c.text).join();

  String get _formattedTime {
    final m = _secondsLeft ~/ 60;
    final s = _secondsLeft % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _verify() {
    if (_otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 4-digit code')),
      );
      return;
    }
    setState(() => _isLoading = true);
    // TODO: Verify OTP against backend
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isLoading = false);
        context.push(AppRoutes.resetPasswordScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Back button ──────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.tranquilityColor,
                  size: 22.sp,
                ),
              ),
            ),

           Image.asset(
                AppAssets.otpImage,
                width: double.infinity,
                fit: BoxFit.cover,
               ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeightSpace(32),

                  Text(
                    'Verification',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),

                  HeightSpace(8),

                  Text(
                    'Please enter the code sent on your email.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.tranquilityColor,
                    ),
                  ),

                  if (widget.email.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      widget.email,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                  ],

                  HeightSpace(32),

                  // ── 4-box OTP input ─────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (i) => _OtpBox(
                      controller: _controllers[i],
                      focusNode: _focusNodes[i],
                      onFilled: () {
                        if (i < 3) {
                          _focusNodes[i + 1].requestFocus();
                        } else {
                          _focusNodes[i].unfocus();
                        }
                        setState(() {});
                      },
                      onBackspace: () {
                        if (i > 0) {
                          _controllers[i - 1].clear();
                          _focusNodes[i - 1].requestFocus();
                        }
                        setState(() {});
                      },
                    )),
                  ),

                  HeightSpace(16),

                  // ── Resend row ───────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Didn't receive a code?  ",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff434C6D),
                            ),
                          ),
                          GestureDetector(
                            onTap: _secondsLeft == 0 ? _startTimer : null,
                            child: Text(
                              'Resend',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: _secondsLeft == 0
                                    ? AppColors.tranquilityColor
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        _formattedTime,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff8E8EA9),
                        ),
                      ),
                    ],
                  ),

                  HeightSpace(32),

                  // ── Verify button ────────────────────────────────────────
                  Center(
                    child: AppPrimaryButton(
                      buttonText: 'Verify',
                      buttonColor: AppColors.tranquilityColor,
                      isLoading: _isLoading,
                      onPress: _verify,
                    ),
                  ),

                  HeightSpace(32),
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
// Single OTP digit box
// ---------------------------------------------------------------------------
class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onFilled;
  final VoidCallback onBackspace;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onFilled,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasValue = controller.text.isNotEmpty;
    return Container(
      width: 70.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: const Color(0xffF7F8F9),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: hasValue
              ? AppColors.tranquilityColor
              : const Color(0xffE8ECF4),
          width: 1.5,
        ),
      ),
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              controller.text.isEmpty) {
            onBackspace();
          }
        },
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          maxLength: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          cursorColor: AppColors.tranquilityColor,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.tranquilityColor,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
          onChanged: (v) {
            if (v.isNotEmpty) {
              onFilled();
            }
          },
        ),
      ),
    );
  }
}
