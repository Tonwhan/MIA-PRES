import 'package:flutter/material.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/features/settings/presentation/widgets/setting_item_list.dart';
import 'package:pillpal/features/user/personal_info_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text('Settings'),
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 24),
              SettingItemList(
                title: 'Personal Info',
                svgIcon: 'assets/vectors/user.svg',
                route: PersonalInfopage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
