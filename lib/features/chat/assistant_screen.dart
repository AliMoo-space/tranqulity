import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/widgets/custom_text_field.dart';
import 'package:tranqulity/core/widgets/primary_button_widget.dart';
import 'package:tranqulity/core/widgets/spacing_widgets.dart';

/// Assistant / Create-new-chat screen (maps to assistent.yaml).
class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _startChat() {
    final title =
        _titleController.text.trim().isEmpty ? 'New Chat' : _titleController.text.trim();
    context.pushReplacement(AppRoutes.chatScreen, extra: title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── Back button ──────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  // TODO: replace with actual asset: assets/icons/epback.svg
                  color: AppColors.tranquilityColor,
                  size: 22.sp,
                ),
              ),
            ),
          ),

          // ── Teal chatbot area ────────────────────────────────────────
          Container(
            width: double.infinity,
            color: AppColors.tranquilityColor,
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Column(
              children: [
                // Chatbot icon placeholder
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                  child: Icon(
                    Icons.smart_toy_outlined,
                    // TODO: replace with actual asset: assets/icons/teenyiconschatbot-outline.svg
                    size: 72.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeightSpace(32),

                    Text(
                      'Hey!',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.tranquilityColor,
                      ),
                    ),

                    HeightSpace(8),

                    Text(
                      "I'am your Personal Assistant",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.tranquilityColor,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    HeightSpace(32),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Make New Chat',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.tranquilityColor,
                        ),
                      ),
                    ),

                    HeightSpace(12),

                    CustomTextField(
                      hintText: 'Enter The Title Of Chat',
                      controller: _titleController,
                    ),

                    HeightSpace(24),

                    Center(
                      child: AppPrimaryButton(
                        buttonText: 'Start Chat',
                        buttonColor: AppColors.tranquilityColor,
                        bordersRadius: 16,
                        onPress: _startChat,
                      ),
                    ),

                    HeightSpace(32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
