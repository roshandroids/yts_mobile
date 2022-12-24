import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdaptiveBackBtn extends StatelessWidget {
  const AdaptiveBackBtn({
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => context.pop(),
      child: Container(
        padding: EdgeInsets.zero,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // color: Theme.of(context).backgroundColor,
        ),
        child: const Icon(
          Icons.chevron_left,
          size: 30,
        ),
      ),
    );
  }
}
