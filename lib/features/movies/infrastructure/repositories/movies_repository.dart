import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/features/movies/movies.dart';

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
  Future<Either<PaginatedResponse<MovieModel>, Failure>> fetchLatestMovies({
    required int page,
    required int limit,
    required bool forceRefresh,
  });

  Future<Either<MovieModel, Failure>> fetchMovieDetails(
    int movieId, {
    bool withImages,
    bool withCast,
    bool forceRefresh,
  });

  Future<Either<PaginatedResponse<MovieModel>, Failure>> fetchSuggestedMovies(
    int movieId, {
    bool forceRefresh = false,
  });
}
