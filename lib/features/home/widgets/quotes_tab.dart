import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/styling/app_colors.dart';

/// Hard-coded inspirational quotes (no backend available).
const List<String> quotes = [
  '" The only way to do great work is to love what you do "',
  '" The secret of getting ahead is getting started "',
  '" In the middle of difficulty lies opportunity "',
  '" It does not matter how slowly you go as long as you do not stop "',
  '" Mental health is not a destination, but a process — it\'s about how you drive "',
  '" You don\'t have to be positive all the time. It\'s perfectly okay to feel sad, angry, annoyed, frustrated or anxious. "',
  '" Happiness can be found even in the darkest of times, if one only remembers to turn on the light "',
];

class QuotesTab extends StatelessWidget {
  const QuotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffD9D9D9), // background from quotes.yaml
      child: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: quotes.length,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, i) => QuoteCard(quote: quotes[i]),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Quote card (white rounded container on grey background)
// ---------------------------------------------------------------------------
class QuoteCard extends StatelessWidget {
  final String quote;

  const QuoteCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.format_quote,
            size: 32.sp,
            color: AppColors.tranquilityColor.withValues(alpha: 0.4),
          ),
          SizedBox(height: 12.h),
          Text(
            quote,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                  color: AppColors.tranquilityColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Tranquility',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.tranquilityColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
