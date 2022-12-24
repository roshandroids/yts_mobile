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

  @override
  Future<MovieModel> getMovieDetails(
    int movieId, {
    bool withImages = false,
    bool withCast = false,
    bool forceRefresh = false,
  }) async {
    final responseData = await httpService.get(
      Endpoints.movieDetailsEndpoint,
      forceRefresh: forceRefresh,
      queryParameters: <String, dynamic>{
        'movie_id': movieId,
        'with_images': withImages,
        'with_cast': withCast,
      },
    );
    return MovieModel.fromJson(
      (responseData['data'] as Map<String, dynamic>)['movie']
          as Map<String, dynamic>,
    );
  }

  @override
  Future<PaginatedResponse<MovieModel>> getSuggestedMovies(
    int movieId, {
    bool forceRefresh = false,
  }) async {
    final responseData = await httpService.get(
      Endpoints.suggestedMoviesEndpoint,
      forceRefresh: forceRefresh,
      queryParameters: <String, dynamic>{
        'movie_id': movieId,
      },
    );
    final responseJson = responseData['data'] as Map<String, dynamic>;
    final additionalParams = <String, dynamic>{
      'page_number': 0,
      'limit': 20,
    };
    responseJson.addAll(additionalParams);
    final parsedResponse = PaginatedResponse.fromJson(
      responseJson,
      results: List<MovieModel>.from(
        (responseJson['movies'] as List<dynamic>)
            .map((e) => MovieModel.fromJson(e as Map<String, dynamic>)),
      ),
    );

    return parsedResponse;
  }
}
