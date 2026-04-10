import 'package:flutter/material.dart';
import 'package:pillpal/features/authentication/sign_in/sign_in.dart';
import 'package:pillpal/widgets/navbar/bottom_navigation_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        final session = Supabase.instance.client.auth.currentSession;

        if (session != null) {
          return const BottomNavbar();
        } else {
          return const SignInpage();
        }
      },
    );
  }
}
