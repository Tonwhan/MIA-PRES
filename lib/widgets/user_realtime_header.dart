import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class UserRealTimeHeader extends StatelessWidget {
  final String? username;
  final TextStyle? style;
  final String format;
  const UserRealTimeHeader({
    super.key,
    this.username,
    this.style,
    this.format = 'EEE, MMMM d, yyyy',
  });

  @override
  Widget build(BuildContext context) {
    if (username == null) {
      return _buildSkeleton(context);
    }
    return StreamBuilder<DateTime>(
      stream: Stream.periodic(
        const Duration(seconds: 1),
        (_) => DateTime.now(),
      ),
      initialData: DateTime.now(),
      builder: (context, snapshot) {
        final now = snapshot.data ?? DateTime.now();
        final formattedDate = DateFormat(format).format(now);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              username!,
              style: style?.copyWith(color: Colors.white, fontSize: 18),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(formattedDate, style: style),
          ],
        );
      },
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE0E0E0).withValues(alpha: 0.35),
      highlightColor: const Color(0xFFE0E0E0).withValues(alpha: 0.1),
      period: const Duration(seconds: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 140,
            height: (style?.fontSize ?? 16) * 1.2,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0).withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 180,
            height: (style?.fontSize ?? 14) * 1.2,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0).withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
