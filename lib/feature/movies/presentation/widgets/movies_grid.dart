import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';
import 'package:yts_mobile/feature/movies/presentation/widgets/movie_item.dart';

class MoviesList extends ConsumerWidget {
  const MoviesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomPhotosCount = ref.watch(moviesCountProvider);
    final scrollController = ref.watch(moviesScrollControllerProvider);
    return randomPhotosCount.when(
      loading: ListItemShimmer.new,
      data: (int count) {
        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          controller: scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final currentPhotoFromIndex = ref
                .watch(paginatedMoviesProvider(index ~/ 20))
                .whenData((pageData) {
              return pageData.results[index % 20];
            });
            return ProviderScope(
              overrides: [
                currentMovieItemProvider
                    .overrideWithValue(currentPhotoFromIndex)
              ],
              child: const MovieItem(),
            );
          },
        );
      },
      error: (Object error, StackTrace? stackTrace) {
        log('Error fetching random photos');
        log(error.toString());
        log(stackTrace.toString());
        return const ErrorView();
      },
    );
  }
}
