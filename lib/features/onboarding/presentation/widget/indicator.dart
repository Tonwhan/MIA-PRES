import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  final bool isActive;

  const OnboardingIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: 8,
      width: isActive ? 28 : 28,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFA5FF1F) : Colors.white24,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
