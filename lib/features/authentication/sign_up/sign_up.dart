import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pillpal/config/constants/text_style.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/core/services/auth/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //get auth service
  final authService = AuthService();

  bool _isloading = false;

  //text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    //Clean up controller to release mem when the widget is removed
    //prevents memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  //sign up button pressed
  void signUp() async {
    //prepare data

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    //client-side validation
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // check that password match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords don't match")));
      return;
    }

    setState(() => _isloading = true);

    //attempt sign up
    try {
      await authService.signUpWithEmailPassword(email, password);

      //if sign up success back to sign in page
      if (mounted) {
        Navigator.pop(context);
      }
    }
    //catch any errors
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        titleTextStyle: AppTextDark.subtitle0,
        backgroundColor: AppColors.backgrondColor1,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
      ),
      backgroundColor: AppColors.backgrondColor1,
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
              SizedBox(height: 16),

              //confirm password
              Text('Confirm password', style: TextStyle(color: Colors.white)),
              CupertinoTextField(
                cursorColor: Colors.black,
                controller: _confirmPasswordController,
                placeholder: 'Confirm password',
                obscureText: true,
                padding: const EdgeInsets.all(12),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                // Prevent multiple concurrent authentication requests (Button Debouncing).
                onPressed: _isloading ? null : signUp,

                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.primary.withValues(
                    alpha: 0.5,
                  ),
                  disabledForegroundColor: Colors.white.withValues(alpha: 0.7),
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
                    : const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
