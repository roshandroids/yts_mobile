import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

class MovieItem extends ConsumerWidget {
  const MovieItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(currentMovieItemProvider);

    return Container(
      child: movieAsync.when(
        data: (MovieModel movie) {
          return AppCachedNetworkImage(
            imageUrl: movie.mediumCoverImage,
            fit: BoxFit.cover,
          );
        },
        error: (Object error, StackTrace? stackTrace) {
          log('Error fetching current popular person');
          log(error.toString());
          return const ErrorView();
        },
        loading: () => const ListItemShimmer(),
      ),
    );
  }
}
