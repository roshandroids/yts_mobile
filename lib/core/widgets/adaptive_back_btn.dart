import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Widget with a default AppBar leading icon and action
class AdaptiveBackBtn extends StatefulWidget {
  /// Creates a new instance of [AdaptiveBackBtn]
  const AdaptiveBackBtn({super.key});

  @override
  State<AdaptiveBackBtn> createState() => _AdaptiveBackBtnState();
}

class _AdaptiveBackBtnState extends State<AdaptiveBackBtn>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> fadeAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1, curve: Curves.easeInOut),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Center(
        child: ClipOval(
          child: Material(
            color: Theme.of(context).backgroundColor,
            child: InkWell(
              onTap: () => context.pop(),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
