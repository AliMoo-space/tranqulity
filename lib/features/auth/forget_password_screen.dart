import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_assets.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/widgets/custom_text_field.dart';
import 'package:tranqulity/core/widgets/primary_button_widget.dart';
import 'package:tranqulity/core/widgets/spacing_widgets.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // TODO: Call OTP / reset API
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _isLoading = false);
          context.push(
            AppRoutes.otpScreen,
            extra: _emailController.text.trim(),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Back button ────────────────────────────────────────────
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
                AppAssets.forgotPasswordImage,
                width: double.infinity,
                // height: 255.h,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightSpace(32),

                    Text(
                      'Forget Your Password',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),

                    HeightSpace(24),

                    CustomTextField(
                      hintText: 'Email',
                      controller: _emailController,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Email is required';
                        if (!v.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),

                    HeightSpace(32),

                    Center(
                      child: AppPrimaryButton(
                        buttonText: 'Forget Password',
                        buttonColor: AppColors.tranquilityColor,
                        isLoading: _isLoading,
                        onPress: _submit,
                      ),
                    ),

                    HeightSpace(32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
