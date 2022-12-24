import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

/// Provider to map [MoviesRepository] implementation to
/// [MoviesRepositoryImpl] interface
final moviesRepositoryProvider = Provider<MoviesRepository>(
  (ref) {
    final httpService = ref.watch(httpServiceProvider);

    return MoviesRepositoryImpl(httpService);
  },
);

/// People repository interface
abstract class MoviesRepository {
  /// Request to get a person details endpoint
  Future<PaginatedResponse<MovieModel>> getLatestMovies({
    int page = 1,
    bool forceRefresh = false,
  });

  Future<MovieModel> getMovieDetails(
    int movieId, {
    bool withImages = false,
    bool withCast = false,
    bool forceRefresh = false,
  });
}
