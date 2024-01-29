import 'package:flutter/material.dart';

class StyledDismissible extends StatelessWidget {
  const StyledDismissible({super.key, this.confirmDismiss, this.onDismissed,
    required this.child});
  final Future<bool?> Function(DismissDirection)? confirmDismiss;
  final void Function(DismissDirection)? onDismissed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart, // Enable swipe from right to left
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red, // Background color for delete action
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: confirmDismiss,
      onDismissed: onDismissed,
      child: child,
    );
  }
}
