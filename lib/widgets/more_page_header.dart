import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pillpal/core/services/auth/auth_service.dart';
import 'package:pillpal/widgets/user_profile.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const UserProfile(),
          const Spacer(),
          Image.asset(
            'assets/docs/image/mia.png',
            width: 56,
            height: 56,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              showAdaptiveDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: CupertinoColors.activeBlue),
                      ),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                        logout();
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              );
            },
            child: SvgPicture.asset(
              'assets/vectors/logout.svg',
              width: 26,
              height: 26,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
