import 'package:flutter/material.dart';

class LDoubleBounce extends StatefulWidget {
  const LDoubleBounce({
    Key? key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 2000),
    this.controller,
  }) : super(key: key);

  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  _LDoubleBounceState createState() => _LDoubleBounceState();
}

class _LDoubleBounceState extends State<LDoubleBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..addListener(() => setState(() {}))
      ..repeat(reverse: true);
    _animation = Tween(begin: -1.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: List.generate(2, (i) {
          return Transform.scale(
            scale: (1.0 - i - _animation.value.abs()).abs(),
            child: SizedBox.fromSize(
                size: Size.square(widget.size), child: _itemBuilder(i)),
          );
        }),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
          decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (widget.color ?? Colors.blueGrey).withOpacity(0.6),
        ));
}
