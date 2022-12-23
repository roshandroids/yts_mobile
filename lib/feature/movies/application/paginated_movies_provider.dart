import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

/// FutureProvider that fetches random photos
final paginatedMoviesProvider =
    FutureProvider.family<PaginatedResponse<MovieModel>, int>(
  (ref, int pageIndex) async {
    final photosRepository = ref.watch(photoRepositoryProvider);
    return photosRepository.getPhotos(page: pageIndex + 1);
  },
);
