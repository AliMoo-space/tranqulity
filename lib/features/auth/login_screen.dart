import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_assets.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/styling/app_styles.dart';
import 'package:tranqulity/core/widgets/custom_text_field.dart';
import 'package:tranqulity/core/widgets/primary_button_widget.dart';
import 'package:tranqulity/core/widgets/spacing_widgets.dart';
import 'package:tranqulity/features/auth/widgets/auth_social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // TODO: Connect to auth backend
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _isLoading = false);
          context.go(AppRoutes.mainScreen);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeightSpace(52),
              Image.asset(
                AppAssets.loginImage,
                width: double.infinity,
                height: 180.h,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightSpace(28),

                    Text(
                      'Welcome To',
                      style: AppStyles.body16MediumStyle.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      'Tranquility',
                      style: TextStyle(
                        fontFamily: 'Mystery Quest',
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.tranquilityColor,
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
                    HeightSpace(16),
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

                    HeightSpace(8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () =>
                            context.push(AppRoutes.forgetPasswordScreen),
                        child: Text(
                          'Forget Password?',
                          style: AppStyles.body16MediumStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.tranquilityColor,
                          ),
                        ),
                      ),
                    ),

                    HeightSpace(24),

                    // ── Log In button ─────────────────────────────────────
                    Center(
                      child: AppPrimaryButton(
                        buttonText: 'Log In',
                        buttonColor: AppColors.tranquilityColor,
                        isLoading: _isLoading,
                        onPress: _submit,
                      ),
                    ),

                    HeightSpace(20),

                    // ── Sign up link ──────────────────────────────────────
                    Center(
                      child: GestureDetector(
                        onTap: () => context.push(AppRoutes.registerScreen),
                        child: RichText(
                          text: TextSpan(
                            style: AppStyles.body16RegularStyle,
                            children: [
                              const TextSpan(text: "Don't have an account ?  "),
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                  color: AppColors.tranquilityColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    HeightSpace(32),

                    // ── Divider ───────────────────────────────────────────
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'Or continue with',
                            style: AppStyles.grey12MediumStyle.copyWith(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),

                    HeightSpace(16),

                    // ── Google login ──────────────────────────────────────
                    // AuthSocialLoginButton(
                    //   label: 'Login With Google',
                    //   color: const Color(0xff35B542),
                    //   iconPath: AppAssets.google,
                    //   onTap: () {
                    //     // TODO: implement Google login
                    //   },
                    // ),
                    SocialButton(
                      color: const Color(0xff35B542),
                      icon: AppAssets.google,
                      text: 'Login With Google',
                    ),
                    HeightSpace(12),

                    // ── Facebook login ────────────────────────────────────
                    SocialButton(
                      color: const Color(0xff1877F2),
                      icon: AppAssets.facebook,
                      text: 'Login With Facebook',
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
