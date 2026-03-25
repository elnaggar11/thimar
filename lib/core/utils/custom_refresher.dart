import 'package:flutter/material.dart';

class CustomRefresher extends StatelessWidget {
  final Widget child;

  final Function onRefresh;

  const CustomRefresher({
    required this.child,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) => RefreshIndicator.adaptive(
    onRefresh: () async {
      await Future.delayed(const Duration(milliseconds: 1000));
      onRefresh();
    },

    child: child,
  );
}
