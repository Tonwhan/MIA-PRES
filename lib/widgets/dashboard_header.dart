import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pillpal/config/constants/text_style.dart';
import 'package:pillpal/features/dashboard/profile_dashboard.dart';
import 'package:pillpal/widgets/user_profile.dart';
import 'package:pillpal/widgets/user_realtime_header.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  late Future<String> _usernameFuture;

  @override
  void initState() {
    super.initState();
    _usernameFuture = getUsername();
  }

  Future<String> getUsername() async {
    final user = Supabase.instance.client.auth.currentUser;
    final userName = user?.userMetadata?['full_name'] ?? "User";
    await Future.delayed(const Duration(milliseconds: 800));
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          UserProfile(pageroute: ProfileDashboard(),),
          SizedBox(width: 8),
          Expanded(
            child: FutureBuilder<String>(
              future: _usernameFuture,
              builder: (context, snapshot) {
                return UserRealTimeHeader(
                  username: snapshot.data,
                  style: AppTextDark.subtitle1,
                );
              },
            ),
          ),
          SvgPicture.asset("assets/vectors/caregiver.svg"),
        ],
      ),
    );
  }
}
