import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

class MovieItem extends ConsumerWidget {
  const MovieItem({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieAsync = ref.watch(currentMovieItemProvider);
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Theme.of(context).backgroundColor,
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
                    child: AppCachedNetworkImage(
                      width: size.width,
                      imageUrl: movie.mediumCoverImage,
                      fit: BoxFit.cover,
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
          log('Error fetching current popular person');
          log(error.toString());
          return const ErrorView();
        },
        loading: () => const ListItemShimmer(),
      ),
    );
  }
}

class MovieQualityLabel extends StatelessWidget {
  const MovieQualityLabel({super.key, required this.quality});
  final String quality;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3, left: 1),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).backgroundColor,
      ),
      child: Text(
        quality,
        style: Theme.of(context)
            .textTheme
            .caption
            ?.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
