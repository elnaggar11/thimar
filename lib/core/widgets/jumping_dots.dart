import 'package:doctorin/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JumpingDots extends StatefulWidget {
  const JumpingDots({super.key});

  @override
  State<JumpingDots> createState() => _JumpingDotsState();
}

class _JumpingDotsState extends State<JumpingDots>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _animations = List.generate(3, (index) {
      final double begin = index * 0.33;
      final double end = (index + 1) * 0.33;

      return TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 0,
            end: -10.r,
          ).chain(CurveTween(curve: Curves.easeOut)),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: -10.r,
            end: 0,
          ).chain(CurveTween(curve: Curves.easeIn)),
          weight: 50,
        ),
      ]).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(begin, end, curve: Curves.linear),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(_animations[0]),
        _buildDot(_animations[1]),
        _buildDot(_animations[2]),
      ],
    ).withPadding(start: 5.w);
  }

  Widget _buildDot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: child,
        );
      },
      child: Container(
        width: 4.r,
        height: 4.r,
        margin: EdgeInsets.symmetric(horizontal: 2.r),
        decoration: BoxDecoration(
          color: context.primaryColorLight.withValues(alpha: 0.7),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
