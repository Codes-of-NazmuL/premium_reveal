import 'package:flutter/material.dart';

/// A calm, elegant page transitions builder matching the motion language
/// of [PremiumReveal].
///
/// Combines a gentle fade, subtle bottom-centered micro-scale, and soft vertical slide.
class PremiumPageTransitionsBuilder extends PageTransitionsBuilder {
  const PremiumPageTransitionsBuilder({
    this.curve = Curves.easeOutCubic,
    this.reverseCurve = Curves.easeInCubic,
    this.slideOffset = const Offset(0, 0.025),
  });

  final Curve curve;
  final Curve reverseCurve;
  final Offset slideOffset;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return transition(
      context,
      animation,
      secondaryAnimation,
      child,
      curve: curve,
      reverseCurve: reverseCurve,
      slideOffset: slideOffset,
    );
  }

  /// Direct transition builder method for custom page routes.
  static Widget transition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child, {
    Curve curve = Curves.easeOutCubic,
    Curve reverseCurve = Curves.easeInCubic,
    Offset slideOffset = const Offset(0, 0.025),
  }) {
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations == true;
    if (reduceMotion) return child;

    final entrance = CurvedAnimation(
      parent: animation,
      curve: curve,
      reverseCurve: reverseCurve,
    );
    final exit = CurvedAnimation(
      parent: secondaryAnimation,
      curve: curve,
      reverseCurve: reverseCurve,
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 1.0, end: 0.94).animate(exit),
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.985).animate(exit),
        child: FadeTransition(
          opacity: entrance,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: slideOffset,
              end: Offset.zero,
            ).animate(entrance),
            child: ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: Tween<double>(begin: 0.992, end: 1.0).animate(entrance),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
