import 'package:flutter/material.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/core/animations/swipe_up_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shimmer/shimmer.dart';

class UserProfile extends StatefulWidget {
  final Widget? pageroute;

  const UserProfile({super.key, this.pageroute});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? _avatarUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _setupAuthListener();
    _loadUserAvatar();
  }

  void _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (mounted) {
        _loadUserAvatar();
      }
    });
  }

  Future<void> _loadUserAvatar() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    final user = Supabase.instance.client.auth.currentUser;
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() {
        _avatarUrl = user?.userMetadata?['avatar_url'];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildSkeleton();
    }
    return Container(
      padding: const EdgeInsets.all(2.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFFA5FF1F), Color(0xFF111B15)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.backgroundColor,
        ),
        child: GestureDetector(
          onTap: () {
            if (widget.pageroute != null) {
              Navigator.push(
                context,
                SwipeUpPageRoute(page: widget.pageroute!),
              );
            }
          },
          child: CircleAvatar(
            backgroundColor: Colors.white10,
            radius: 24,
            backgroundImage: _avatarUrl != null
                ? NetworkImage(_avatarUrl!)
                : null,
            child: _avatarUrl == null
                ? const Icon(Icons.person, color: Colors.white54, size: 28)
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.white10,
      highlightColor: Colors.white24,
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}
