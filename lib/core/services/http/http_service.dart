import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:yts_mobile/core/core.dart';

/// Http Service Interface
abstract class HttpService {
  /// Http base url
  String get baseUrl;

  /// Http headers
  Map<String, String> get headers;

  /// Http get request
  Future<Either<Map<String, dynamic>, Failure>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
    CancelToken? cancelToken,
  });

  /// Http post request
  Future<Either<Map<String, dynamic>, Failure>> post(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });

  /// Http put request
  Future<Either<Map<String, dynamic>, Failure>> put(
    String endpoint, {
    CancelToken? cancelToken,
  });

  /// Http delete request
  Future<Either<Map<String, dynamic>, Failure>> delete(
    String endpoint, {
    CancelToken? cancelToken,
  });
}
