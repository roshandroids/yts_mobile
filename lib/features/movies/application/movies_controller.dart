import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/features/movies/movies.dart';

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
  return MoviesController<T>(ref)..fetchLatestMovies(page: 1);
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
    required int page,
    bool forceRefresh = true,
    int limit = 20,
  }) async {
    if (page == 1) {
      state = const BaseState<void>.loading();
    }
    final response = await _moviesRepository.fetchLatestMovies(
      forceRefresh: forceRefresh,
      limit: limit,
      page: page,
    );

    state = response.fold(
      (success) {
        final previousData = ref.read(latestMoviesProvider);

        ref.read(latestMoviesProvider.notifier).state =
            ref.read(latestMoviesProvider).copyWith(
                  limit: success.limit,
                  page: success.page,
                  nextPage: success.page + 1,
                  totalResults: success.totalResults,
                  results: [...previousData.results, ...success.results]
                      .unique((element) => element.id),
                  isEnd: success.page * success.limit == success.totalResults,
                );
        return BaseState<PaginatedResponse<MovieModel>>.success(data: success);
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
