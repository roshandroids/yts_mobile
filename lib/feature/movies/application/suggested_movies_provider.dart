import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

/// Future provider that fetches suggested movies
/// from the movie's id
///
final suggestedMoviesProvider =
    FutureProvider.autoDispose.family<PaginatedResponse<MovieModel>, int>(
  (ref, movieId) async {
    final movieRepository = ref.watch(moviesRepositoryProvider);

    return movieRepository.getSuggestedMovies(
      movieId,
      forceRefresh: true,
    );
  },
);
