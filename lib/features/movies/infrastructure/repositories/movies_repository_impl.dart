import 'package:dartz/dartz.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/features/movies/movies.dart';

/// Http implementation of [MoviesRepositoryImpl]
class MoviesRepositoryImpl implements MoviesRepository {
  /// Creates a new instance of [MoviesRepositoryImpl]
  MoviesRepositoryImpl(this.httpService);

  /// Http service used to access an Http client and make calls
  final HttpService httpService;

  @override
  Future<Either<PaginatedResponse<MovieModel>, Failure>> fetchLatestMovies({
    required int page,
    required int limit,
    required bool forceRefresh,
  }) async {
    final responseData = await httpService.get(
      Endpoints.latestMoviesEndpoint,
      forceRefresh: forceRefresh,
      queryParameters: <String, dynamic>{
        'page': page,
        'limit': limit,
      },
    );
    return responseData.fold(
      (success) {
        try {
          final parsedResponse = PaginatedResponse.fromJson(
            success['data'] as Map<String, dynamic>,
            results: List<MovieModel>.from(
              ((success['data'] as Map<String, dynamic>)['movies']
                      as List<dynamic>)
                  .map((e) => MovieModel.fromJson(e as Map<String, dynamic>)),
            ),
          );

          return Left(parsedResponse);
        } catch (e) {
          return Right(Failure.fromException(e));
        }
      },
      Right.new,
    );
  }

  @override
  Future<Either<MovieModel, Failure>> fetchMovieDetails(
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
    return responseData.fold(
      (success) {
        try {
          final parsedData = MovieModel.fromJson(
            (success['data'] as Map<String, dynamic>)['movie']
                as Map<String, dynamic>,
          );
          return Left(parsedData);
        } catch (e) {
          return Right(Failure.fromException(e));
        }
      },
      Right.new,
    );
  }

  @override
  Future<Either<PaginatedResponse<MovieModel>, Failure>> fetchSuggestedMovies(
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
    return responseData.fold(
      (success) {
        try {
          final responseJson = success['data'] as Map<String, dynamic>;
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

          return Left(parsedResponse);
        } catch (e) {
          return Right(Failure.fromException(e));
        }
      },
      Right.new,
    );
  }
}
