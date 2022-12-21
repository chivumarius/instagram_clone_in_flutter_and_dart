import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  // ♦ Properties:
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;

  // ♦ Constructor:
  const LikeAnimation({
    Key? key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
    this.smallLike = false,
  }) : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  // ♦ Controller :
  late AnimationController controller;

  // ♦ Scale:
  late Animation<double> scale;

  // ♦ The "initState()" Method:
  @override
  void initState() {
    super.initState();

    // ♦ Setting the "Controller"
    //   → for "Animation Duration":
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    );

    // ♦ Animation Scale:
    scale = Tween<double>(
      begin: 1,
      end: 1.2,
    ).animate(controller);
  }

  // ♦ The "didUpdateWidget()" Method
  //   → Called when a "Current Widget"
  //   → is "Replaced" by "Another Widget":
  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ♦ Checking:
    if (widget.isAnimating != oldWidget.isAnimating) {
      // ♦ Calling the Function
      startAnimation();
    }
  }

  // ♦ The "startAnimation()" Function:
  startAnimation() async {
    // ♦ Checking:
    if (widget.isAnimating || widget.smallLike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(
        const Duration(milliseconds: 200),
      );

      // ♦ Checking:
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  // ♦ The "dispose()" Method:
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
