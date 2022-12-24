import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

class MovieDetailPage extends ConsumerWidget {
  const MovieDetailPage({
    required this.movieId,
    this.imgCoverUrl,
    super.key,
  });
  final int movieId;
  final String? imgCoverUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(movieDetailsProvider(movieId));
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            backgroundColor: Colors.transparent,
            leading: const AdaptiveBackBtn(),
            pinned: true,
            flexibleSpace: Hero(
              tag: 'movie_${movieId}_cover_image',
              transitionOnUserGestures: true,
              child: AppCachedNetworkImage(
                imageUrl: imgCoverUrl!,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                movieAsync.when(
                  data: (MovieModel movie) {
                    return Center(
                      child: Text(movie.title),
                    );
                  },
                  error: (Object error, StackTrace? stackTrace) {
                    log('Error fetching movie details');
                    log(error.toString());
                    return const ErrorView();
                  },
                  loading: Shimmer.new,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  MovieDetailPage copyWith({
    int? movieId,
  }) {
    return MovieDetailPage(
      movieId: movieId ?? this.movieId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'movieId': movieId,
    };
  }
}
