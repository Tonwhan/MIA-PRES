import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:pillpal/core/services/auth/auth_gate.dart';
import 'package:pillpal/features/onboarding/presentation/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Supabase Initialize
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final String supabaseUrl = dotenv.env['SUPABASE_URL']!;
  final String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );

  final appLinks = AppLinks();
  final initialUri = await appLinks.getInitialLink();

  if (initialUri != null) {
    debugPrint('Initial deep link: $initialUri');

    await Supabase.instance.client.auth.getSessionFromUrl(initialUri);
  }

  appLinks.uriLinkStream.listen((uri) async {
    debugPrint('Deep link received: $uri');

    final res = await Supabase.instance.client.auth.getSessionFromUrl(uri);

    debugPrint("SESSION AFTER CALLBACK: ${res.session}");
  });

  final client = Supabase.instance.client;
  debugPrint("Supabase Connected");

  debugPrint("Session: ${client.auth.currentSession}");

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

      //Conditional routing: Show Onboarding for new users, otherwise go to main screen
      home: showOnboarding ? const OnboardingScreen() : const AuthGate(),
    );
  }
}