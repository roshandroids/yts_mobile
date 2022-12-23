import 'package:flutter/material.dart';

class EntranceFader extends StatefulWidget {
  const EntranceFader({
    super.key,
    this.child,
    this.delay = const Duration(milliseconds: 300),
    this.duration = const Duration(milliseconds: 600),
    this.offset = const Offset(0, 30),
  });
  final Widget? child;
  final Duration delay;
  final Duration duration;
  final Offset offset;

  @override
  EntranceFaderState createState() {
    return EntranceFaderState();
  }
}

class EntranceFaderState extends State<EntranceFader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<num> _dxAnimation;
  late Animation<num> _dyAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _dxAnimation = Tween(begin: widget.offset.dx, end: 0).animate(_controller);
    _dyAnimation = Tween(begin: widget.offset.dy, end: 0).animate(_controller);
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Opacity(
          opacity: _controller.value,
          child: Transform.translate(
            offset: Offset(
              _dxAnimation.value.toDouble(),
              _dyAnimation.value.toDouble(),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
