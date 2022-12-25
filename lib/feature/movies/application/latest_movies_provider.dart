import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/infrastructure/infrastructure.dart';

final latestMoviesProvider =
    StateProvider<PaginatedResponse<MovieModel>>((ref) {
  return const PaginatedResponse(page: 0, results: <MovieModel>[]);
});
