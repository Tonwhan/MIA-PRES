import 'package:flutter/material.dart';

class NoAnimationRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  NoAnimationRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: Duration.zero,
    reverseTransitionDuration: Duration.zero,
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}