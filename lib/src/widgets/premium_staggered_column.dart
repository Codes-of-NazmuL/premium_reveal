import 'package:flutter/material.dart';
import 'premium_reveal.dart';

/// A [Column] that automatically wraps each child in a [PremiumReveal]
/// with an incrementing [order] index.
///
/// Blank spacing elements like [Spacer], [Flexible], or empty [SizedBox]
/// are rendered without animation delays so spacing remains immediate.
class PremiumStaggeredColumn extends StatelessWidget {
  const PremiumStaggeredColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.startOrder = 0,
    this.offset = const Offset(0, 0.045),
    this.duration = const Duration(milliseconds: 440),
    this.delayPerOrder = const Duration(milliseconds: 45),
    this.curve = Curves.easeOutCubic,
    this.waitForRoute = true,
  });

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;

  /// Starting stagger index for the first child.
  final int startOrder;

  /// Starting slide offset for child reveals.
  final Offset offset;

  /// Duration of each reveal transition.
  final Duration duration;

  /// Delay duration between each staggered item.
  final Duration delayPerOrder;

  /// Animation curve.
  final Curve curve;

  /// Whether reveals wait for the current route transition to complete.
  final bool waitForRoute;

  @override
  Widget build(BuildContext context) {
    var order = startOrder;
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      children: children.map((child) {
        if (child is Flexible ||
            child is Spacer ||
            (child is SizedBox && child.child == null)) {
          return child;
        }
        return PremiumReveal(
          order: order++,
          offset: offset,
          duration: duration,
          delayPerOrder: delayPerOrder,
          curve: curve,
          waitForRoute: waitForRoute,
          child: child,
        );
      }).toList(),
    );
  }
}
