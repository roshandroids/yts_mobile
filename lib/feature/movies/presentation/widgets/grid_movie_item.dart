import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

class GridMovieItem extends ConsumerWidget {
  const GridMovieItem({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(currentMovieItemProvider);
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: movieAsync.when(
        data: (MovieModel movie) {
          final qualityList = movie.torrents.map((e) => e.quality).toList();
          return InkWell(
            onTap: () {
              context.pushNamed(
                RoutePaths.movieDetail.routeName,
                params: {
                  'id': '${movie.id}',
                },
                extra: movie.largeCoverImage,
              );
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'movie_${movie.id}_cover_image',
                      child: AppCachedNetworkImage(
                        width: size.width,
                        imageUrl: movie.mediumCoverImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                      children: [
                        TextSpan(
                          text: '[${movie.language.toUpperCase()}] ',
                        ),
                        TextSpan(
                          text: movie.titleEnglish,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${movie.year}',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                  Row(
                    children: qualityList
                        .map(
                          (e) => MovieQualityLabel(
                            quality: e,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          );
        },
        error: (Object error, StackTrace? stackTrace) {
          log('Error fetching current movie item');
          log(error.toString());
          return const ErrorView();
        },
        loading: CustomShimmer.new,
      ),
    );
  }
}
