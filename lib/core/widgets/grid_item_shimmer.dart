import 'package:flutter/material.dart';
import 'package:yts_mobile/core/core.dart';

/// Widget used for a list shimmer effect
class ListItemShimmer extends StatelessWidget {
  /// Creates a new instance of [ListItemShimmer]
  const ListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      height: 15,
      width: MediaQuery.of(context).size.width * 0.4,
    );
  }
}
