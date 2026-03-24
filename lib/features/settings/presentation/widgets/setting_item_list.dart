import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pillpal/config/theme/colors_theme.dart';

class SettingItemList extends StatelessWidget {
  final String title;
  final String svgIcon;
  final Widget route;
  const SettingItemList({
    super.key,
    required this.title,
    required this.svgIcon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => route));
      },
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(child: SvgPicture.asset(svgIcon)),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
        ],
      ),
    );
  }
}
