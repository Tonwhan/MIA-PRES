import 'package:flutter/material.dart';
import 'package:pillpal/config/theme/colors_theme.dart';

class Termspage extends StatelessWidget {
  const Termspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
      ),
    );
  }
}
