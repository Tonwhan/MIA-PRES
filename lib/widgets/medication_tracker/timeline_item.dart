import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pillpal/widgets/medication_tracker/medication_tracker.dart';

// TODO: Trigger node change on medication completion system
Widget timeLineStepItem(TimelineData data) {
  final Color themeColor = data.isActive ? Colors.orange : Colors.grey.shade500;

  return Expanded(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          data.svgPath,
          width: 28,
          height: 28,
          colorFilter: ColorFilter.mode(themeColor, BlendMode.srcIn),
        ),
        const SizedBox(height: 10),
        Text(
          data.time,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: themeColor,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: themeColor,
            border: Border.all(color: Colors.white, width: 4), // ขอบขาวตัดเส้น
            boxShadow: [
              if (data.isActive)
                BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
