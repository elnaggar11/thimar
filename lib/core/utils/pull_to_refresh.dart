import 'package:flutter/material.dart';

class PullToRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const PullToRefresh({
    required this.onRefresh,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      RefreshIndicator(onRefresh: onRefresh, child: child);
}
