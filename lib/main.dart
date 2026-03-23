import 'package:flutter/material.dart';
import 'package:pillpal/core/services/auth/auth_gate.dart';
import 'package:pillpal/features/onboarding/presentation/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Supabase Initialize
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  final client = Supabase.instance.client;
  debugPrint("Supabase Connected");
  (client.auth.currentSession);

  //Check Onboarding Screen Status
  final prefs = await SharedPreferences.getInstance();
  final bool showOnboarding = prefs.getBool('showOnboarding') ?? true;

  runApp(MainApp(showOnboarding: showOnboarding));
}

class MainApp extends StatelessWidget {
  final bool showOnboarding;
  const MainApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIA_PRES',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,

      //Conditional routing: Show Onbording for new users, otherwise go to main screen
      home: showOnboarding ? const OnboardingPage() : const AuthGate(),
    );
  }
}
