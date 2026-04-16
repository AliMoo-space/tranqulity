import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/widgets/custom_text_field.dart';
import 'package:tranqulity/core/widgets/primary_button_widget.dart';
import 'package:tranqulity/core/widgets/spacing_widgets.dart';

/// Suggestions screen – maps to suggestions.yaml in generated/.
class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({super.key});

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // TODO: Send suggestion to backend
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() => _isLoading = false);
          _subjectController.clear();
          _bodyController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Suggestion sent – thank you!'),
              backgroundColor: Color(0xff284243),
            ),
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
              // ── Header row ───────────────────────────────────────────
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
                      'Suggestions',
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

              // ── Illustration + tagline ───────────────────────────────
              Center(
                child: Column(
                  children: [
                    // TODO: replace with actual asset: assets/images/suggestions_illustration
                    Container(
                      width: 170.w,
                      height: 170.h,
                      decoration: BoxDecoration(
                        color: AppColors.tranquilityColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lightbulb_outline,
                        size: 72.sp,
                        color: AppColors.tranquilityColor,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Tell Us How We Can Help',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    HeightSpace(24),

                    // ── Subject ──────────────────────────────────────
                    CustomTextField(
                      hintText: 'Subject',
                      controller: _subjectController,
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Subject is required' : null,
                    ),

                    HeightSpace(16),

                    // ── Body ─────────────────────────────────────────
                    SizedBox(
                      width: 331.w,
                      child: TextFormField(
                        controller: _bodyController,
                        maxLines: 5,
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Message is required' : null,
                        cursorColor: AppColors.tranquilityColor,
                        decoration: InputDecoration(
                          hintText: 'Write your message here...',
                          hintStyle: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xff8391A1),
                            fontWeight: FontWeight.w500,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 18.h,
                          ),
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: Colors.red, width: 1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: Colors.red, width: 1),
                          ),
                          filled: true,
                          fillColor: const Color(0xffF7F8F9),
                        ),
                      ),
                    ),

                    HeightSpace(32),

                    Center(
                      child: AppPrimaryButton(
                        buttonText: 'Submit Suggestion',
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
