import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_assets.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/widgets/custom_text_field.dart';
import 'package:tranqulity/core/widgets/primary_button_widget.dart';
import 'package:tranqulity/core/widgets/spacing_widgets.dart';

/// Profile tab – renders the edit-profile UI inline (matches edit_profile.yaml).
class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Sara');
  final _emailController =
      TextEditingController(text: 'amramer522@gmail.com');
  final _ageController = TextEditingController(text: '22');
  String? _selectedGender = 'Female';
  bool _isLoading = false;

  static const List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
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

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // TODO: Call update-profile API
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile saved successfully'),
              backgroundColor: Color(0xff284243),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 16.h),

            // ── Profile image ─────────────────────────────────────────
            GestureDetector(
              onTap: _showImagePicker,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 80.r,
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

            // ── Fields ────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeightSpace(20),

                  // Name
                  CustomTextField(
                    hintText: 'Username',
                    controller: _nameController,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Name is required' : null,
                  ),

                  HeightSpace(16),

                  // Email
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

                  // Age & Gender row
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Age',
                          controller: _ageController,
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Required' : null,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedGender,
                          hint: Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: const Color(0xff8391A1),
                            ),
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 18.h),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(
                                  color: Color(0xffE8ECF4), width: 1),
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
                                    child: Text(g,
                                        style: TextStyle(fontSize: 14.sp)),
                                  ))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _selectedGender = v),
                        ),
                      ),
                    ],
                  ),

                  HeightSpace(16),

                  // Change Password link
                  GestureDetector(
                    onTap: () =>
                        context.push(AppRoutes.changePasswordScreen),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change Password',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          // TODO: replace with actual asset: assets/icons/iconsaxlinearedit.svg
                          size: 20.sp,
                          color: AppColors.tranquilityColor,
                        ),
                      ],
                    ),
                  ),

                  HeightSpace(24),

                  // Save button
                  Center(
                    child: PrimrayButtonWidget(
                      buttonText: 'Save',
                      buttonColor: AppColors.tranquilityColor,
                      isLoading: _isLoading,
                      onPress: _save,
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
// Image picker bottom sheet (UI only)
// ---------------------------------------------------------------------------
class _ChooseImageSheet extends StatelessWidget {
  const _ChooseImageSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            child:
                Icon(icon, size: 42.sp, color: AppColors.tranquilityColor),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
