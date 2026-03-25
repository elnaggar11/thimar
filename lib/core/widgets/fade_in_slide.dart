import 'package:flutter/material.dart';

enum FadeSlideDirection { ttb, btt, ltr, rtl }

// Enum to define slide directions

class FadeInSlide extends StatefulWidget {
  const FadeInSlide({
    required this.child,
    required this.duration,
    super.key,
    this.curve = Curves.easeInOutBack,
    this.fadeOffset = 5,
    this.direction = FadeSlideDirection.ttb,
  });

  final Widget child;

  final double duration;

  final double fadeOffset;

  final Curve curve;

  final FadeSlideDirection direction;

  @override
  State<FadeInSlide> createState() => _FadeInSlideState();
}

class _FadeInSlideState extends State<FadeInSlide>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> opacityAnimation;
  late Animation<double> inAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with the provided duration
    animationController = AnimationController(
      duration: Duration(milliseconds: (1000 * widget.duration).toInt()),
      vsync: this,
    );

    // Animation for sliding: from -fadeOffset to 0
    inAnimation = Tween<double>(begin: -widget.fadeOffset, end: 0).animate(
      CurvedAnimation(parent: animationController, curve: widget.curve),
    );

    // Animation for fading: from invisible to fully visible
    opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);

    // Start the animation
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        // Determine the direction and calculate the offset
        final offset = switch (widget.direction) {
          FadeSlideDirection.ltr => Offset(
            inAnimation.value,
            0,
          ), // Left to right
          FadeSlideDirection.rtl => Offset(
            size.width - inAnimation.value,
            0,
          ), // Right to left
          FadeSlideDirection.ttb => Offset(
            0,
            inAnimation.value,
          ), // Top to bottom
          FadeSlideDirection.btt => Offset(
            0,
            -inAnimation.value,
          ), // Bottom to top
        };

        // Apply slide and fade animations
        return Transform.translate(
          offset: offset,
          child: Opacity(opacity: opacityAnimation.value, child: child),
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    animationController
        .dispose(); // Dispose of the controller to free resources
    super.dispose();
  }
}
