import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillpal/config/theme/colors_theme.dart';
import 'package:pillpal/core/animations/swipe_up_page.dart';
import 'package:pillpal/core/services/auth/auth_gate.dart';
import 'package:pillpal/features/onboarding/presentation/onboarding_last_page.dart';
import 'package:pillpal/features/onboarding/presentation/onboarding_page_one.dart.dart';
import 'package:pillpal/features/onboarding/presentation/onboarding_page_three.dart';
import 'package:pillpal/features/onboarding/presentation/widget/indicator.dart';
import 'package:pillpal/features/onboarding/presentation/onboarding_page_two.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final int _numPages = 4;

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
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: const [
                OnboardingPageOne(),
                OnboardingPageTwo(),
                OnboardingPageThree(),
                OnboardingLastPage(),
              ],
            ),
            if (_currentPage < 3)
              Positioned(
                top: 70,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) =>
                        OnboardingIndicator(isActive: _currentPage == index),
                  ),
                ),
              ),
            if (_currentPage < 3)
              Positioned(
                top: 48,
                right: 20,
                child: TextButton(
                  onPressed: () => _controller.animateToPage(
                    3,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.fastOutSlowIn,
                  ),
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            Positioned(
              bottom: 110,
              left: 24,
              right: 24,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentPage == 3
                        ? AppColors.primary
                        : AppColors.primary,
                    foregroundColor: _currentPage == 3
                        ? Colors.white
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    if (_currentPage < _numPages - 1) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        SwipeUpPageRoute(page: const AuthGate()),
                      );
                    }
                  },
                  child: Text(
                    _currentPage == _numPages - 1 ? "Get Started" : "Next",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
