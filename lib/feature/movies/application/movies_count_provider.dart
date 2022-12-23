import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

/// The provider that has the value of the total count of the list items
///
/// The [PaginatedResponse] class contains information about the total number of
/// pages and the total results in all pages along with a list of the
/// provided type
///

final moviesCountProvider = Provider<AsyncValue<int>>((ref) {
  return ref.watch(paginatedMoviesProvider(0)).whenData(
        (PaginatedResponse<MovieModel> pageData) => pageData.totalResults,
      );
});
