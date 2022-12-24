import 'package:flutter/material.dart';

class AdaptiveBackBtn extends StatelessWidget {
  const AdaptiveBackBtn({
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.chevron_left,
        size: 30,
      ),
      onPressed: onPressed ?? () => Navigator.pop(context),
    );
  }
}
