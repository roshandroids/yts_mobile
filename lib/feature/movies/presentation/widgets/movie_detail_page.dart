import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
    final suggestedMoviesAsync = ref.watch(suggestedMoviesProvider(movieId));
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            leading: const AdaptiveBackBtn(),
            pinned: true,
            flexibleSpace: Hero(
              tag: 'movie_${movieId}_cover_image',
              transitionOnUserGestures: true,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedNetworkImage(
                    imageUrl: imgCoverUrl!,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                movieAsync.when(
                  data: (MovieModel movie) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          Text(
                            '${movie.year}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          Text(
                            movie.genres.getGenresString,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Available in :'.hardcoded,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              ),
                              const SizedBox(width: 5),
                              Wrap(
                                children: movie.torrents
                                    .map(
                                      (e) => MovieQualityLabel(
                                        quality: e.quality,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite_outline_rounded,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    const Spacer(),
                                    Text(
                                      movie.likeCount.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    ),
                                    const Spacer(),
                                    const SizedBox(width: 10)
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppAssets.imdbLogo),
                                    const Spacer(),
                                    Text(
                                      '${movie.rating} ⭐️',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Summary :'.hardcoded,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                          ),
                          Text(
                            movie.descriptionFull,
                            maxLines: 50,
                            textAlign: TextAlign.justify,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: size.height / 5,
                            child: suggestedMoviesAsync.when(
                              data: (PaginatedResponse<MovieModel> data) {
                                return ListView.builder(
                                  itemExtent: size.width / 2,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    final currentMovieFromIndex = ref
                                        .watch(suggestedMoviesProvider(index))
                                        .whenData((pageData) {
                                      return pageData.results[index];
                                    });
                                    return ProviderScope(
                                      overrides: [
                                        currentMovieItemProvider
                                            .overrideWithValue(
                                          currentMovieFromIndex,
                                        )
                                      ],
                                      child: const GridMovieItem(),
                                    );
                                  },
                                );
                              },
                              error: (error, stackTrace) {
                                log('Error fetching movie details');
                                log(error.toString());
                                return const SizedBox.shrink();
                              },
                              loading: () => ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) => CustomShimmer(
                                  width: size.width / 3,
                                  height: 100,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  error: (Object error, StackTrace? stackTrace) {
                    log('Error fetching movie details');
                    log(error.toString());
                    return const ErrorView();
                  },
                  loading: () => CustomShimmer(
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension GetGenresString on List<String> {
  String get getGenresString => join(' / ');
}
