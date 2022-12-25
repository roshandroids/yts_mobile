import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// CustomShimmer widget with simple fade animation
class CustomShimmer extends StatelessWidget {
  /// Creates a new instance of [CustomShimmer]
  const CustomShimmer({
    super.key,
    this.width,
    this.height,
  });

  /// CustomShimmer area width
  final double? width;

  /// CustomShimmer area height
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryContainer,
      highlightColor: Theme.of(context).colorScheme.tertiaryContainer,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).backgroundColor,
        ),
        height: height,
        width: width,
      ),
    );
  }
}
