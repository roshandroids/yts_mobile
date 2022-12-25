import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/feature/movies/infrastructure/infrastructure.dart';

final latestMoviesProvider = StateProvider<List<MovieModel>>((ref) {
  return <MovieModel>[];
});
