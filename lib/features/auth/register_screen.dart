import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_assets.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/widgets/custom_text_field.dart';
import 'package:tranqulity/core/widgets/primary_button_widget.dart';
import 'package:tranqulity/core/widgets/spacing_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedGender;
  bool _isLoading = false;

  static const List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => _ChooseImageSheet(),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // TODO: Connect to registration backend
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Top back bar ───────────────────────────────────────────
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.tranquilityColor,
                    size: 22.sp,
                  ),
                ),
              ),

              // ── Profile image picker ───────────────────────────────────
              Center(
                child: GestureDetector(
                  onTap: _showImagePicker,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 76.r,
                        backgroundColor:
                            AppColors.tranquilityColor.withValues(alpha: 0.15),
                        backgroundImage:
                            const AssetImage(AppAssets.personPlaceholder),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: AppColors.tranquilityColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              HeightSpace(24),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    // ── Username ─────────────────────────────────────────
                    CustomTextField(
                      hintText: 'Username',
                      controller: _usernameController,
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Username is required' : null,
                    ),
                    HeightSpace(16),

                    // ── Email ─────────────────────────────────────────────
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

                    // ── Age ───────────────────────────────────────────────
                    CustomTextField(
                      hintText: 'Age',
                      controller: _ageController,
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Age is required' : null,
                    ),
                    HeightSpace(16),

                    // ── Gender ────────────────────────────────────────────
                    DropdownButtonFormField<String>(
                      initialValue: _selectedGender,
                      hint: Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xff8391A1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 18.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Color(0xffE8ECF4), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                              color: AppColors.tranquilityColor, width: 1),
                        ),
                        filled: true,
                        fillColor: const Color(0xffF7F8F9),
                      ),
                      items: _genders
                          .map((g) => DropdownMenuItem(
                                value: g,
                                child: Text(g),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedGender = v),
                      validator: (v) =>
                          v == null ? 'Please select gender' : null,
                    ),
                    HeightSpace(16),

                    // ── Password ──────────────────────────────────────────
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

                    // ── Confirm password ──────────────────────────────────
                    CustomTextField(
                      hintText: 'Confirm password',
                      controller: _confirmPasswordController,
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
                    HeightSpace(24),

                    // ── Sign Up button ────────────────────────────────────
                    PrimrayButtonWidget(
                      buttonText: 'Sign Up',
                      buttonColor: AppColors.tranquilityColor,
                      isLoading: _isLoading,
                      onPress: _submit,
                    ),

                    HeightSpace(16),

                    // ── Login link ────────────────────────────────────────
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(text: 'Already have an account ?  '),
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                color: AppColors.tranquilityColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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

// ---------------------------------------------------------------------------
// Image-source bottom sheet (UI only – add image_picker for real picking)
// ---------------------------------------------------------------------------
class _ChooseImageSheet extends StatelessWidget {
  const _ChooseImageSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pick Image From...',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _PickOption(
                icon: Icons.photo_camera,
                label: 'Camera',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: replace with actual asset: image_picker camera
                },
              ),
              _PickOption(
                icon: Icons.photo_library,
                label: 'Gallery',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: replace with actual asset: image_picker gallery
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

class _PickOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickOption(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 90.w,
            height: 90.h,
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F9),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 42.sp, color: AppColors.tranquilityColor),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
