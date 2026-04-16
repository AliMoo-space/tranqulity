import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tranqulity/core/routing/app_routes.dart';
import 'package:tranqulity/core/styling/app_assets.dart';
import 'package:tranqulity/core/styling/app_colors.dart';
import 'package:tranqulity/core/styling/app_styles.dart';
import 'package:tranqulity/features/home/widgets/app_drawer.dart';
import 'package:tranqulity/features/home/widgets/chats_tab.dart';
import 'package:tranqulity/features/home/widgets/home_nav_item.dart';
import 'package:tranqulity/features/home/widgets/profile_tab.dart';
import 'package:tranqulity/features/home/widgets/quotes_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<String> _titles = ['Chats', 'Quotes', 'Profile'];

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      // ── App bar row ────────────────────────────────────────────────────
      appBar: _buildAppBar(),
      // ── Tabs ───────────────────────────────────────────────────────────
      body: IndexedStack(
        index: _currentIndex,
        children: const [ChatsTab(), QuotesTab(), ProfileTab()],
      ),
      // ── Bottom navigation ──────────────────────────────────────────────
      bottomNavigationBar: _buildBottomNav(),
      // ── FAB (chatbot assistant) ────────────────────────────────────────
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(64.h),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        child: Row(
          children: [
            GestureDetector(
              onTap: _openDrawer,
              child: Icon(Icons.menu, size: 26.sp, color: Colors.black87),
            ),
            SizedBox(width: 16.w),
            Text(_titles[_currentIndex], style: AppStyles.heading24BoldStyle),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: AppColors.tranquilityColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(0.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HomeNavItem(
            assetPath: AppAssets.chats,
            label: 'Chats',
            isActive: _currentIndex == 0,
            onTap: () => setState(() => _currentIndex = 0),
          ),
          HomeNavItem(
            assetPath: AppAssets.quotes,
            label: 'Quotes',
            isActive: _currentIndex == 1,
            onTap: () => setState(() => _currentIndex = 1),
          ),
          HomeNavItem(
            assetPath: AppAssets.profile,
            label: 'Profile',
            isActive: _currentIndex == 2,
            onTap: () => setState(() => _currentIndex = 2),
          ),
        ],
      ),
    );
  }

  Widget _buildFab() {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.assistantScreen),
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: AppColors.tranquilityColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.tranquilityColor.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.chat_bubble_outline,
          // TODO: replace with actual asset: assets/icons/teenyiconschatbot-outline.svg
          color: Colors.white,
          size: 28.sp,
        ),
      ),
    );
  }
}
