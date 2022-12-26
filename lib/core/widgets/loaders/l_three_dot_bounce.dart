import 'package:flutter/material.dart';

import 'package:yts_mobile/core/widgets/loaders/tweens/delayed_tween.dart';

class LThreeDotBounce extends StatefulWidget {
  const LThreeDotBounce({
    super.key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1400),
    this.controller,
    this.padding,
  });

  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;
  final EdgeInsetsGeometry? padding;

  @override
  State<LThreeDotBounce> createState() => _LThreeDotBounceState();
}

class _LThreeDotBounceState extends State<LThreeDotBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: SizedBox.fromSize(
          size: Size(widget.size * 2, widget.size),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (i) {
              return Flexible(
                child: ScaleTransition(
                  scale: DelayTween(begin: 0, end: 1, delay: i * .2)
                      .animate(_controller),
                  child: SizedBox.fromSize(
                    size: Size.square(widget.size * 0.5),
                    child: _itemBuilder(i),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
          decoration: BoxDecoration(
            color: widget.color ?? Colors.blueGrey[700],
            shape: BoxShape.circle,
          ),
        );
}
