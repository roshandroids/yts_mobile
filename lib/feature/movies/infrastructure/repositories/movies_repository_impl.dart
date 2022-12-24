import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

/// Http implementation of [MoviesRepositoryImpl]
class MoviesRepositoryImpl implements MoviesRepository {
  /// Creates a new instance of [MoviesRepositoryImpl]
  MoviesRepositoryImpl(this.httpService);

  /// Http service used to access an Http client and make calls
  final HttpService httpService;

  @override
  Future<PaginatedResponse<MovieModel>> getLatestMovies({
    int page = 1,
    int limit = 20,
    bool forceRefresh = false,
  }) async {
    final responseData = await httpService.get(
      Endpoints.latestMoviesEndpoint,
      forceRefresh: forceRefresh,
      queryParameters: <String, dynamic>{
        'page': page,
        'limit': limit,
      },
    );

    final parsedResponse = PaginatedResponse.fromJson(
      responseData['data'] as Map<String, dynamic>,
      results: List<MovieModel>.from(
        ((responseData['data'] as Map<String, dynamic>)['movies']
                as List<dynamic>)
            .map((e) => MovieModel.fromJson(e as Map<String, dynamic>)),
      ),
    );

    return parsedResponse;
  }

  // @override
  // Future<MovieModel> getMovieDetails(
  //   String movieId, {
  //   bool withImages = false,
  //   bool withCast = false,
  //   bool forceRefresh = false,
  // }) async {
  //   final responseData = await httpService.get(
  //     Endpoints.latestMoviesEndpoint,
  //     forceRefresh: forceRefresh,
  //     queryParameters: <String, dynamic>{
  //       'movie_id': movieId,
  //       'with_images': withImages,
  //       'with_cast': withCast,
  //     },
  //   );
  // }
}
