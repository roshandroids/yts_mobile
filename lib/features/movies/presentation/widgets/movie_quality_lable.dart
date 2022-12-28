import 'package:flutter/material.dart';

class MovieQualityLabel extends StatelessWidget {
  const MovieQualityLabel({super.key, required this.quality});
  final String quality;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3, left: 1),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        color: Theme.of(context).dividerColor,
      ),
      child: Text(
        quality,
        style: Theme.of(context)
            .textTheme
            .button
            ?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
