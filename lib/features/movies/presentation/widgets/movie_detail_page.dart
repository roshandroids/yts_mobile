import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/features/movies/movies.dart';

class MovieDetailPage extends ConsumerStatefulWidget {
  const MovieDetailPage({
    required this.movieId,
    this.imgCoverUrl,
    super.key,
  });
  final int movieId;
  final String? imgCoverUrl;

  @override
  ConsumerState<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends ConsumerState<MovieDetailPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(movieDetailsController.notifier)
          .fetchMovieDetails(widget.movieId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieDetailState = ref.watch(movieDetailsController);
    final suggestedMoviesState = ref.watch(suggestedMoviesController);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            leading: const AdaptiveBackBtn(),
            pinned: true,
            flexibleSpace: Hero(
              tag: 'movie_${widget.movieId}_cover_image',
              transitionOnUserGestures: true,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedNetworkImage(
                    imageUrl: widget.imgCoverUrl!,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                movieDetailState.maybeMap(
                  initial: (_) => CustomShimmer(
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                  success: (value) {
                    final movie = value.data as MovieModel;
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
                            child: suggestedMoviesState.maybeMap(
                              success: (success) {
                                final movieData = success.data
                                    as PaginatedResponse<MovieModel>;
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Similar movies :'.hardcoded,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: movieData.results.length,
                                        itemBuilder: (context, index) {
                                          final currentMovieFromIndex =
                                              movieData.results[index];
                                          return ProviderScope(
                                            overrides: [
                                              currentMovieItemProvider
                                                  .overrideWithValue(
                                                currentMovieFromIndex,
                                              )
                                            ],
                                            child: const ListMovieItem(),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                              error: (error) => const SizedBox.shrink(),
                              loading: (_) => ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemExtent: size.width / 2,
                                itemBuilder: (context, index) => CustomShimmer(
                                  width: size.width / 3,
                                  height: 100,
                                ),
                              ),
                              orElse: () => const SizedBox.shrink(),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    );
                  },
                  error: (_) => const ErrorView(),
                  loading: (_) => CustomShimmer(
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                  orElse: () => CustomShimmer(
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
