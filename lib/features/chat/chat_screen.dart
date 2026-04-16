import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/styling/app_styles.dart';
import 'package:tranqulity/features/chat/models/chat_message.dart';
import 'package:tranqulity/features/chat/widgets/chat_message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String chatTitle;

  const ChatScreen({super.key, required this.chatTitle});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    const ChatMessage(text: 'Hello How are you?', isUser: true),
    const ChatMessage(
      text:
          "Hello! I'm just a computer program, so I don't have feelings in the same way humans do, but I'm here and ready to assist you. How can I help you today?",
      isUser: false,
    ),
    const ChatMessage(text: 'I feel upset', isUser: true),
    const ChatMessage(
      text:
          "I'm sorry to hear that you're feeling upset. If you'd like, you can share what's on your mind, and I'm here to listen and offer support or guidance if you need it. Remember, it's okay to feel upset sometimes, and it's important to take care of yourself.",
      isUser: false,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _messageController.clear();
    });
    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
    // TODO: Send message to AI backend and append response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add(
            const ChatMessage(
              text:
                  'Thank you for sharing that with me. I\'m here for you. Could you tell me more about what\'s going on?',
              isUser: false,
            ),
          );
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── Header bar ─────────────────────────────────────────────
          Container(
            width: double.infinity,
            height: 60.h,
            color: AppColors.tranquilityColor,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    // TODO: replace with actual asset: assets/icons/epback.svg
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.chatTitle,
                    style: AppStyles.body16MediumStyle.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    // TODO: replace with actual asset: assets/icons/menu.svg
                    color: Colors.white,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
          ),

          // ── Messages list ───────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              itemCount: _messages.length,
              itemBuilder: (_, i) => ChatMessageBubble(message: _messages[i]),
            ),
          ),

          // ── Input row ───────────────────────────────────────────────
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'write your message',
                        hintStyle: AppStyles.label15MediumMutedStyle.copyWith(
                          fontSize: 16.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 56.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: AppColors.tranquilityColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.send,
                      // TODO: replace with actual asset: assets/icons/send_message.svg
                      color: Colors.white,
                      size: 22.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
