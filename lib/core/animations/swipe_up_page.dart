import 'package:flutter/material.dart';

class SwipeUpPageRoute extends PageRouteBuilder {
  final Widget page;

  SwipeUpPageRoute({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          var secondaryTween = Tween(
            begin: Offset.zero,
            end: const Offset(0.0, -0.2),
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: secondaryAnimation.drive(secondaryTween),
            child: SlideTransition(
              position: animation.drive(tween),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
      );
}
