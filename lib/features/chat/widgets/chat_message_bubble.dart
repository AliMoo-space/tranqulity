import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/styling/app_styles.dart';
import 'package:tranqulity/features/chat/models/chat_message.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.tranquilityColor,
              child: Icon(
                Icons.smart_toy,
                color: AppColors.whiteColor,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 8.w),
          ],
          Container(
            constraints: BoxConstraints(maxWidth: 280.w),
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isUser
                  ? AppColors.tranquilityColor
                  : AppColors.mutedTextColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              message.text,
              style: AppStyles.body16RegularStyle.copyWith(
                fontSize: 15.sp,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          if (isUser) SizedBox(width: 8.w),
        ],
      ),
    );
  }
}
