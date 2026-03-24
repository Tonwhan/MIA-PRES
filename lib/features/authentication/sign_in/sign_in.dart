import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/core/services/auth/auth_service.dart';
import 'package:pillpal/features/authentication/sign_up/sign_up.dart';

class SignInpage extends StatefulWidget {
  const SignInpage({super.key});

  @override
  State<SignInpage> createState() => _SignInpageState();
}

class _SignInpageState extends State<SignInpage> {
  //get auth service
  final authService = AuthService();

  //text controller
  bool _isloading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    //Clean up controller to release mem when the widget is removed
    //prevents memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //login button pressed
  void login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    //Client-side validation
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fileds')),
      );
      return;
    }

    setState(() => _isloading = true);

    //attemp login
    try {
      await authService.signInWithEmailPassword(email, password);
    }
    //catch any error
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isloading = false);
      }
    }
  }

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
        backgroundColor: AppColors.backgroundColor1,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                //email
                Text('Email', style: TextStyle(color: Colors.white)),
                CupertinoTextField(
                  cursorColor: Colors.black,
                  controller: _emailController,
                  placeholder: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  padding: const EdgeInsets.all(12),
                ),
                SizedBox(height: 16),

                //password
                Text('Password', style: TextStyle(color: Colors.white)),
                CupertinoTextField(
                  cursorColor: Colors.black,
                  controller: _passwordController,
                  placeholder: 'Password',
                  obscureText: true,
                  padding: const EdgeInsets.all(12),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  // Prevent multiple concurrent authentication requests (Button Debouncing).
                  onPressed: _isloading ? null : login,

                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.primary.withValues(
                      alpha: 0.5,
                    ),
                    disabledForegroundColor: Colors.white.withValues(
                      alpha: 0.7,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                  ),
                  child: _isloading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Sign In'),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  ),
                  child: Center(
                    child: Text(
                      "Dont't have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
