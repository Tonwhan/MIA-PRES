import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/features/settings/presentation/pages/privacy_page.dart';
import 'package:pillpal/features/settings/presentation/pages/settings_page.dart';
import 'package:pillpal/features/settings/presentation/pages/terms_page.dart';
import 'package:pillpal/features/settings/presentation/widgets/contact_center_bar.dart';
import 'package:pillpal/widgets/more_page_header.dart';
import 'package:pillpal/features/settings/presentation/widgets/setting_item_list.dart';

class Morepage extends StatelessWidget {
  const Morepage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkBackground =
        ThemeData.estimateBrightnessForColor(AppColors.backgroundColor) ==
        Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: isDarkBackground
            ? Brightness.dark
            : Brightness.light,
        statusBarIconBrightness: isDarkBackground
            ? Brightness.dark
            : Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(),
                  SizedBox(height: 24),
                  SettingItemList(
                    svgIcon: 'assets/vectors/setting.svg',
                    title: 'Settings',
                    route: SettingsPage(),
                  ),
                  Divider(height: 24),
                  SettingItemList(
                    svgIcon: 'assets/vectors/paper.svg',
                    title: 'Terms & Conditions',
                    route: Termspage(),
                  ),
                  Divider(height: 24),
                  SettingItemList(
                    svgIcon: 'assets/vectors/eye.svg',
                    title: 'Privacy Policy',
                    route: PrivacyPolicyPage(),
                  ),
                  SizedBox(height: 24),
                  ContactCenterBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
