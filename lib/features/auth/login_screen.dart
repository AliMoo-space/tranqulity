import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_assets.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/widgets/custom_text_field.dart';
import 'package:tranqulity/core/widgets/primary_button_widget.dart';
import 'package:tranqulity/core/widgets/spacing_widgets.dart';

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
              // ── Header / branding area ─────────────────────────────────
              Container(
                width: double.infinity,
                height: 200.h,
                color: AppColors.tranquilityColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tranquility',
                      style: TextStyle(
                        fontFamily: 'Mystery Quest',
                        fontSize: 42.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightSpace(28),

                    Text(
                      'Welcome To',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Tranquility',
                      style: TextStyle(
                        fontFamily: 'Mystery Quest',
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.tranquilityColor,
                      ),
                    ),

                    HeightSpace(24),

                    // ── Email field ───────────────────────────────────────
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

                    // ── Password field ────────────────────────────────────
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

                    // ── Forget password ───────────────────────────────────
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () =>
                            context.push(AppRoutes.forgetPasswordScreen),
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.tranquilityColor,
                          ),
                        ),
                      ),
                    ),

                    HeightSpace(24),

                    // ── Log In button ─────────────────────────────────────
                    Center(
                      child: PrimrayButtonWidget(
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
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
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
                        Expanded(
                            child: Divider(color: Colors.grey.shade300)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        Expanded(
                            child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),

                    HeightSpace(16),

                    // ── Google login ──────────────────────────────────────
                    _SocialLoginButton(
                      label: 'Login With Google',
                      color: const Color(0xff35B542),
                      iconPath: AppAssets.google,
                      onTap: () {
                        // TODO: implement Google login
                      },
                    ),

                    HeightSpace(12),

                    // ── Facebook login ────────────────────────────────────
                    _SocialLoginButton(
                      label: 'Login With Facebook',
                      color: const Color(0xff518EF8),
                      iconPath: AppAssets.facebook,
                      onTap: () {
                        // TODO: implement Facebook login
                      },
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

// ---------------------------------------------------------------------------
// Helper widget
// ---------------------------------------------------------------------------
class _SocialLoginButton extends StatelessWidget {
  final String label;
  final Color color;
  final String iconPath;
  final VoidCallback onTap;

  const _SocialLoginButton({
    required this.label,
    required this.color,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 331.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24.w,
              height: 24.h,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
