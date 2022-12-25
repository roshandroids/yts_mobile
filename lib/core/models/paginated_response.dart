import 'package:equatable/equatable.dart';

/// Model representing a paginated TMDB http response
class PaginatedResponse<T> extends Equatable {
  /// Creates new instance of [PaginatedResponse]
  const PaginatedResponse({
    this.page = 1,
    this.results = const [],
    this.totalResults = 1,
    this.limit = 20,
  });

  /// Creates new instance of [PaginatedResponse] parsed from raw dara
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json, {
    List<T>? results,
  }) {
    return PaginatedResponse<T>(
      page: json['page_number'] as int,
      results: results ?? <T>[],
      totalResults: json['movie_count'] as int,
      limit: json['limit'] as int,
    );
  }

  /// Page number
  final int page;

  /// List of results of the current page
  final List<T> results;

  /// Total number of results in all pages
  final int totalResults;

  /// Item limit per page
  final int limit;

  @override
  List<Object?> get props => [page, results, totalResults, limit];

  @override
  bool get stringify => true;

  PaginatedResponse<T> copyWith({
    int? page,
    List<T>? results,
    int? totalResults,
    int? limit,
  }) {
    return PaginatedResponse<T>(
      page: page ?? this.page,
      results: results ?? this.results,
      totalResults: totalResults ?? this.totalResults,
      limit: limit ?? this.limit,
    );
  }
}
