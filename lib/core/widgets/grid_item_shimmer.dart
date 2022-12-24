import 'package:flutter/material.dart';
import 'package:yts_mobile/core/core.dart';

/// Widget used for a list shimmer effect
class ListItemShimmer extends StatelessWidget {
  /// Creates a new instance of [ListItemShimmer]
  const ListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) => CustomShimmer(
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
