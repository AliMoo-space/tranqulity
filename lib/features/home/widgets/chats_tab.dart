import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_colors.dart';

/// Simple data model for a chat session.
class ChatModel {
  final String id;
  final String title;

  ChatModel({required this.id, required this.title});
}

class ChatsTab extends StatefulWidget {
  const ChatsTab({super.key});

  @override
  State<ChatsTab> createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  // Mock chat list – populated from the chats.yaml examples.
  final List<ChatModel> _chats = [
    ChatModel(id: '1', title: 'About Work'),
    ChatModel(id: '2', title: 'About My Family'),
    ChatModel(id: '3', title: 'My self'),
  ];

  void _deleteChat(String id) {
    setState(() => _chats.removeWhere((c) => c.id == id));
  }

  @override
  Widget build(BuildContext context) {
    if (_chats.isEmpty) {
      return _EmptyChatsState();
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      itemCount: _chats.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, i) {
        final chat = _chats[i];
        return _ChatListItem(
          chat: chat,
          onTap: () => context.push(AppRoutes.chatScreen, extra: chat.title),
          onDelete: () => _deleteChat(chat.id),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Chat list item
// ---------------------------------------------------------------------------
class _ChatListItem extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _ChatListItem({
    required this.chat,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          color: AppColors.tranquilityColor,
          borderRadius: BorderRadius.circular(9.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Expanded(
              child: Text(
                chat.title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete_outline,
                // TODO: replace with actual asset: assets/icons/uiwdelete.svg
                color: Colors.white70,
                size: 22.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty state (maps to empty_chats.yaml)
// ---------------------------------------------------------------------------
class _EmptyChatsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TODO: replace with actual asset: assets/icons/vector_12_8691.svg
          Icon(
            Icons.chat_bubble_outline,
            size: 160.sp,
            color: AppColors.tranquilityColor.withValues(alpha: 0.2),
          ),
          SizedBox(height: 24.h),
          Text(
            "You don't have any Chats yet.",
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
