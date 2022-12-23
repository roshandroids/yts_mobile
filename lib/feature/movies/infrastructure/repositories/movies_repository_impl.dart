import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

/// Http implementation of [PhotoRepositoryImpl]
class PhotoRepositoryImpl implements PhotoRepository {
  /// Creates a new instance of [PhotoRepositoryImpl]
  PhotoRepositoryImpl(this.httpService);

  /// Http service used to access an Http client and make calls
  final HttpService httpService;

  @override
  String get path => '/list_movies.json';

  @override
  Future<PaginatedResponse<MovieModel>> getPhotos({
    int page = 1,
    int limit = 20,
    bool forceRefresh = false,
  }) async {
    final responseData = await httpService.get(
      path,
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
}
