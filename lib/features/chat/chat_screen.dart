import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/styling/app_colors.dart';

// ---------------------------------------------------------------------------
// Chat message model
// ---------------------------------------------------------------------------
class ChatMessage {
  final String text;
  final bool isUser;

  const ChatMessage({required this.text, required this.isUser});
}

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
    const ChatMessage(
      text: 'Hello How are you?',
      isUser: true,
    ),
    const ChatMessage(
      text:
          "Hello! I'm just a computer program, so I don't have feelings in the same way humans do, but I'm here and ready to assist you. How can I help you today?",
      isUser: false,
    ),
    const ChatMessage(
      text: 'I feel upset',
      isUser: true,
    ),
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
          _messages.add(const ChatMessage(
            text:
                'Thank you for sharing that with me. I\'m here for you. Could you tell me more about what\'s going on?',
            isUser: false,
          ));
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
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
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
              itemBuilder: (_, i) => _MessageBubble(message: _messages[i]),
            ),
          ),

          // ── Input row ───────────────────────────────────────────────
          Container(
            color: Colors.white,
            padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 56.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffF7F8F9),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: const Color(0xffE8ECF4)),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'write your message',
                        hintStyle: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16.sp,
                          color: const Color(0xff8391A1),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
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

// ---------------------------------------------------------------------------
// Message bubble
// ---------------------------------------------------------------------------
class _MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            // TODO: replace with actual asset: assets/images/robot.png
            CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.tranquilityColor,
              child: Icon(Icons.smart_toy,
                  color: Colors.white, size: 18.sp),
            ),
            SizedBox(width: 8.w),
          ],
          Container(
            constraints: BoxConstraints(maxWidth: 280.w),
            margin: EdgeInsets.only(bottom: 12.h),
            padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isUser
                  ? AppColors.tranquilityColor
                  : const Color(0xffADADAD),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          if (isUser) SizedBox(width: 8.w),
        ],
      ),
    );
  }
}
