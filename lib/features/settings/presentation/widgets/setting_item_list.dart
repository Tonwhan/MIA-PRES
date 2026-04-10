import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pillpal/config/theme/colors_theme.dart';

class SettingItemList extends StatelessWidget {
  final String title;
  final String? svgIcon;
  final Widget route;

  const SettingItemList({
    super.key,
    required this.title,
    this.svgIcon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        },
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.white.withValues(alpha: 0.1),
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 16),
          child: Row(
            children: [
              if (svgIcon != null) ...[
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.backgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(child: SvgPicture.asset(svgIcon!)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white54,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
