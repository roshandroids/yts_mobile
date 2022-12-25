import 'package:equatable/equatable.dart';

/// Model representing a paginated TMDB http response
class PaginatedResponse<T> extends Equatable {
  /// Creates new instance of [PaginatedResponse]
  const PaginatedResponse({
    required this.page,
    this.nextPage,
    this.results = const [],
    this.totalResults = 1,
    this.limit = 20,
    this.isEnd = false,
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

  /// Next page number
  final int? nextPage;

  /// List of results of the current page
  final List<T> results;

  /// Total number of results in all pages
  final int totalResults;

  /// Item limit per page
  final int limit;

  final bool isEnd;

  @override
  List<Object?> get props =>
      [page, results, totalResults, limit, nextPage, isEnd];

  @override
  bool get stringify => true;

  PaginatedResponse<T> copyWith({
    int? page,
    int? nextPage,
    List<T>? results,
    int? totalResults,
    int? limit,
    bool? isEnd,
  }) {
    return PaginatedResponse<T>(
      page: page ?? this.page,
      nextPage: nextPage ?? this.nextPage,
      results: results ?? this.results,
      totalResults: totalResults ?? this.totalResults,
      limit: limit ?? this.limit,
      isEnd: isEnd ?? this.isEnd,
    );
  }
}
