import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CaregiverHeader extends StatefulWidget {
  final String imgUrl;
  final String name;

  const CaregiverHeader({super.key, required this.imgUrl, required this.name});

  @override
  State<CaregiverHeader> createState() => _CaregiverHeaderState();
}

class _CaregiverHeaderState extends State<CaregiverHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.imgUrl),
                  backgroundColor: Color(0xFFDADADA),
                ),
                SizedBox(width: 8),
                Text(widget.name, overflow: TextOverflow.ellipsis),
                Spacer(),
                //TODO: Navigate to chat meassage system.
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF3D4F42),
                    ),
                    padding: EdgeInsets.all(6),
                    child: SvgPicture.asset('assets/vectors/chat.svg'),
                  ),
                ),

                SizedBox(width: 12),

                //TODO: Navigate to Phone and video Call system using Agora SDK as RTC platform.
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF85CC16),
                    ),
                    padding: EdgeInsets.all(6),
                    child: SvgPicture.asset('assets/vectors/call.svg'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
