import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

final latestMoviesController = StateNotifierProvider.autoDispose<
    MoviesController<PaginatedResponse<MovieModel>>, BaseState<dynamic>>(
  _moviesController,
);

final movieDetailsController = StateNotifierProvider.autoDispose<
    MoviesController<PaginatedResponse<MovieModel>>, BaseState<dynamic>>(
  _moviesController,
);
final suggestedMoviesController = StateNotifierProvider.autoDispose<
    MoviesController<PaginatedResponse<MovieModel>>, BaseState<dynamic>>(
  _moviesController,
);

MoviesController<T> _moviesController<T>(Ref ref) {
  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);
  return MoviesController<T>(ref);
}

class MoviesController<T> extends StateNotifier<BaseState<dynamic>> {
  ///
  MoviesController(this.ref, {this.cancelToken})
      : super(const BaseState<void>.initial());

  final CancelToken? cancelToken;

  final Ref ref;

  MoviesRepository get _moviesRepository => ref.read(moviesRepositoryProvider);

  /// [fetchLatestMovies] fetch latest movies based on filter query params
  Future<void> fetchLatestMovies({
    int page = 1,
    bool forceRefresh = false,
    int limit = 20,
  }) async {
    state = const BaseState<void>.loading();
    final response = await _moviesRepository.fetchLatestMovies(
      forceRefresh: forceRefresh,
      limit: limit,
      page: page,
    );
    state = response.fold(
      (success) {
        final previousData = ref.read(latestMoviesProvider);
        final newData = [...previousData, ...success.results];
        ref.read(latestMoviesProvider.notifier).state = newData;
        return BaseState<PaginatedResponse<MovieModel>>.success(
          data: success.copyWith(results: newData),
        );
      },
      BaseState.error,
    );
  }

  /// [fetchMovieDetails] fetch movie details based on [movieId]
  Future<void> fetchMovieDetails(
    int movieId, {
    bool withImages = false,
    bool withCast = false,
    bool forceRefresh = false,
  }) async {
    state = const BaseState<void>.loading();
    final response = await _moviesRepository.fetchMovieDetails(
      movieId,
      forceRefresh: forceRefresh,
      withCast: withCast,
      withImages: withImages,
    );
    state = response.fold(
      (success) {
        ref
            .read(suggestedMoviesController.notifier)
            .fetchSuggestedMovies(movieId);
        return BaseState<MovieModel>.success(data: success);
      },
      BaseState.error,
    );
  }

  /// [fetchSuggestedMovies] fetch suggested movies based on selected [movieId]
  Future<void> fetchSuggestedMovies(
    int movieId, {
    bool forceRefresh = false,
  }) async {
    state = const BaseState<void>.loading();
    final response = await _moviesRepository.fetchSuggestedMovies(
      movieId,
      forceRefresh: forceRefresh,
    );
    state = response.fold(
      (success) =>
          BaseState<PaginatedResponse<MovieModel>>.success(data: success),
      BaseState.error,
    );
  }
}
