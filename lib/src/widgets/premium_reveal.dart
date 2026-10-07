import 'dart:async';
import 'package:flutter/material.dart';

/// A calm, staggered reveal animation widget that gracefully fades, slides, and
/// scales its [child] into view.
class PremiumReveal extends StatefulWidget {
  const PremiumReveal({
    super.key,
    required this.child,
    this.order = 0,
    this.offset = const Offset(0, 0.045),
    this.duration = const Duration(milliseconds: 440),
    this.delayPerOrder = const Duration(milliseconds: 45),
    this.initialScale = 0.985,
    this.curve = Curves.easeOutCubic,
    this.waitForRoute = true,
  });

  /// The widget to animate into view.
  final Widget child;

  /// Stagger sequence index. Higher numbers animate later.
  final int order;

  /// Starting offset translation for the slide transition.
  final Offset offset;

  /// Duration of the entrance animation.
  final Duration duration;

  /// Delay duration added per [order] unit.
  final Duration delayPerOrder;

  /// Starting scale value (e.g. 0.985 for a subtle micro-expansion).
  final double initialScale;

  /// The animation curve to use.
  final Curve curve;

  /// When true, waits for the current [ModalRoute] transition to finish
  /// before initiating the staggered reveal.
  final bool waitForRoute;

  @override
  State<PremiumReveal> createState() => _PremiumRevealState();
}

class _PremiumRevealState extends State<PremiumReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;
  Timer? _delay;
  Animation<double>? _routeAnimation;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    final curved = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
    _scale = Tween<double>(begin: widget.initialScale, end: 1.0).animate(curved);
    _slide = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(curved);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _delay?.cancel();
      _routeAnimation?.removeStatusListener(_handleRouteStatus);
      _controller.value = 1.0;
      return;
    }
    if (_started) return;
    _started = true;

    if (!widget.waitForRoute) {
      _scheduleReveal();
      return;
    }

    _routeAnimation = ModalRoute.of(context)?.animation;
    if (_routeAnimation == null ||
        _routeAnimation!.status == AnimationStatus.completed) {
      _scheduleReveal();
    } else {
      _routeAnimation!.addStatusListener(_handleRouteStatus);
    }
  }

  void _handleRouteStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _routeAnimation?.removeStatusListener(_handleRouteStatus);
    _scheduleReveal();
  }

  void _scheduleReveal() {
    final delayDuration = widget.delayPerOrder * widget.order;
    if (delayDuration == Duration.zero) {
      if (mounted) _controller.forward();
    } else {
      _delay = Timer(delayDuration, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _delay?.cancel();
    _routeAnimation?.removeStatusListener(_handleRouteStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(scale: _scale, child: widget.child),
      ),
    );
  }
}

/// Convenient extension method on [Widget] to apply [PremiumReveal].
extension PremiumRevealExtension on Widget {
  /// Wraps this widget in a [PremiumReveal] staggered entrance animation.
  Widget reveal({
    int order = 0,
    Offset offset = const Offset(0, 0.045),
    Duration duration = const Duration(milliseconds: 440),
    Duration delayPerOrder = const Duration(milliseconds: 45),
    double initialScale = 0.985,
    Curve curve = Curves.easeOutCubic,
    bool waitForRoute = true,
  }) =>
      PremiumReveal(
        order: order,
        offset: offset,
        duration: duration,
        delayPerOrder: delayPerOrder,
        initialScale: initialScale,
        curve: curve,
        waitForRoute: waitForRoute,
        child: this,
      );
}
