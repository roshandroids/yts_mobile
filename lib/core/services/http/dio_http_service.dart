import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:yts_mobile/core/core.dart';

/// Http service implementation using the Dio package
///
/// See https://pub.dev/packages/dio
class DioHttpService implements HttpService {
  /// Creates new instance of [DioHttpService]
  DioHttpService(
    this.storageService, {
    Dio? dioOverride,
    bool enableCaching = true,
  }) {
    dio = dioOverride ?? Dio(baseOptions);
    if (enableCaching) {
      dio.interceptors.add(CacheInterceptor(storageService));
    }
  }

  /// Storage service used for caching http responses
  final StorageService storageService;

  /// The Dio Http client
  late final Dio dio;

  /// The Dio base options
  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  String get baseUrl => AppConfigs.apiBaseUrl;

  @override
  Map<String, String> headers = {
    'accept': 'application/json',
    'content-type': 'application/json',
  };

  @override
  Future<Either<Map<String, dynamic>, Failure>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
    String? customBaseUrl,
    CancelToken? cancelToken,
  }) async {
    try {
      dio.options.extra[AppConfigs.dioCacheForceRefreshKey] = forceRefresh;

      final Response<dynamic> response = await dio.get<Map<String, dynamic>>(
        endpoint,
        queryParameters: queryParameters,
      );
      return Left(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      return Right(e.toFailure);
    } catch (e) {
      return Right(Failure.fromException(e));
    }
  }

  @override
  Future<Either<Map<String, dynamic>, Failure>> post(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Map<String, dynamic>, Failure>> delete(
    String endpoint, {
    CancelToken? cancelToken,
  }) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Map<String, dynamic>, Failure>> put(
    String endpoint, {
    CancelToken? cancelToken,
  }) {
    // TODO: implement put
    throw UnimplementedError();
  }
}
