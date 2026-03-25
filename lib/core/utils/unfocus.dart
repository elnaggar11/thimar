import 'package:flutter/material.dart';

class Unfocus extends StatefulWidget {
  final Widget? child;
  const Unfocus({super.key, this.child});

  @override
  State<Unfocus> createState() => _UnfocusState();
}

class _UnfocusState extends State<Unfocus> {
  @override
  Widget build(BuildContext context) => Builder(
    builder: (context) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: widget.child,
    ),
  );
}
