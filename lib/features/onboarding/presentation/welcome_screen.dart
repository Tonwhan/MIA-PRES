import 'package:flutter/material.dart';
import 'package:mia_pres/screens/home.dart';
import 'package:mia_pres/widgets/button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomGradientButton(
                      label: 'Continue',
                      icon: Icons.arrow_forward_ios,
                      iconPosition: IconPosition.right,
                      pageRoute: Home(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
