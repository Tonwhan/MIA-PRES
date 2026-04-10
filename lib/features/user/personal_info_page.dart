import 'package:flutter/material.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/features/settings/presentation/widgets/setting_item_list.dart';
import 'package:pillpal/features/user/profile_manage.dart';
import 'package:pillpal/widgets/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PersonalInfopage extends StatefulWidget {
  final String? username;
  const PersonalInfopage({super.key, this.username});

  @override
  State<PersonalInfopage> createState() => _PersonalInfopageState();
}

class _PersonalInfopageState extends State<PersonalInfopage> {
  String _displayName = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() {
    final user = Supabase.instance.client.auth.currentUser;
    setState(() {
      _displayName =
          user?.userMetadata?['full_name'] ?? widget.username ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
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
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.backgroundColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: UserProfile()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        _displayName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 8,
              ),
              child: Column(
                children: [
                  SettingItemList(
                    title: 'Profile and Username',
                    route: ProfileManage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
