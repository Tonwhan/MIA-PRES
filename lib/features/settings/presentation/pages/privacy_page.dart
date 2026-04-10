import 'package:flutter/material.dart';
import 'package:pillpal/config/theme/colors_theme.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        toolbarHeight: 40,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(child: Column(children: [])),
    );
  }
}
