import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/core/services/auth/auth_service.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  //get auth service
  final authService = AuthService();

  //logout button pressed
  void logout() async {
    try {
      await authService.signOut();

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    } catch (e) {
      if (kDebugMode) {
      print('Internal Error Log: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFA5FF1F), Color(0xFF111B15)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.backgroundColor,
            ),
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://i.pinimg.com/736x/59/9a/7e/599a7e32cdfdb0ee99b8086038cc04f8.jpg",
                ),
                backgroundColor: Colors.white,
                radius: 24,
              ),
            ),
          ),
        ),
        Spacer(),

        Image.asset('assets/docs/image/mia.png', width: 56, height: 56),
        Spacer(),
        SizedBox(width: 32),
        Row(
          children: [
            //log out
            GestureDetector(
              onTap: logout,
              child: SvgPicture.asset(
                'assets/vectors/logout.svg',
                width: 26,
                height: 26,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
