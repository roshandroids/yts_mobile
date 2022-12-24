import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

/// Future provider that fetches a movie detail
/// from the movie's id
///
final movieDetailsProvider = FutureProvider.autoDispose.family<MovieModel, int>(
  (ref, movieId) async {
    final movieRepository = ref.watch(moviesRepositoryProvider);

    return movieRepository.getMovieDetails(
      movieId,
      forceRefresh: true,
    );
  },
);
