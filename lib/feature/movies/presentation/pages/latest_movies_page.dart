import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

class LatestMoviesPage extends ConsumerWidget {
  const LatestMoviesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollControllerProvider = ref.watch(moviesScrollControllerProvider);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () => scrollControllerProvider.animateTo(
              scrollControllerProvider.position.minScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            child: Image.asset(AppAssets.appLogo),
          ),
        ),
      ),
      body: const LatestMoviesList(),
    );
  }
}
