import 'package:flutter/material.dart';
import 'package:pillpal/config/theme/colors_theme.dart';

class PersonalInfopage extends StatefulWidget {
  const PersonalInfopage({super.key});

  @override
  State<PersonalInfopage> createState() => _PersonalInfopageState();
}

class _PersonalInfopageState extends State<PersonalInfopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        title: Text(
          'Personal Info',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
