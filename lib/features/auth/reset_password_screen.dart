import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_assets.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/widgets/custom_text_field.dart';
import 'package:tranqulity/core/widgets/primary_button_widget.dart';
import 'package:tranqulity/core/widgets/spacing_widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _confirm() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // TODO: Call reset-password API
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _isLoading = false);
          // Navigate back to login after success
          context.go(AppRoutes.loginScreen);
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
              // ── Back button ──────────────────────────────────────────
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
                      'Create New Password',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),

                    HeightSpace(8),

                    Text(
                      'create your new password to log in !',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),

                    HeightSpace(32),

                    CustomTextField(
                      hintText: 'Password',
                      controller: _passwordController,
                      isPassword: true,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Password is required';
                        }
                        if (v.length < 6) return 'At least 6 characters';
                        return null;
                      },
                    ),

                    HeightSpace(16),

                    CustomTextField(
                      hintText: 'Confirm Password',
                      controller: _confirmController,
                      isPassword: true,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (v != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    HeightSpace(32),

                    Center(
                      child: AppPrimaryButton(
                        buttonText: 'Confirm',
                        buttonColor: AppColors.tranquilityColor,
                        isLoading: _isLoading,
                        onPress: _confirm,
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
