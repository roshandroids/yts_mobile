import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

class LatestMoviesGridView extends ConsumerStatefulWidget {
  const LatestMoviesGridView({super.key});

  @override
  ConsumerState<LatestMoviesGridView> createState() =>
      _LatestMoviesGridViewState();
}

class _LatestMoviesGridViewState extends ConsumerState<LatestMoviesGridView> {
  late final RefreshController _refreshController;
  @override
  void initState() {
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(latestMoviesController.notifier).fetchLatestMovies();
    });
    super.initState();
  }

  void onRefresh() {
    _refreshController.requestRefresh();
    ref
        .read(latestMoviesController.notifier)
        .fetchLatestMovies(forceRefresh: true);
    _refreshController.refreshCompleted();
  }

  void onLoading(int page) {
    _refreshController.requestLoading();
    ref.read(latestMoviesController.notifier).fetchLatestMovies(page: page);
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final latestMoviesState = ref.watch(latestMoviesController);
    final scrollController = ref.watch(moviesScrollControllerProvider);
    return latestMoviesState.map(
      initial: (_) => const ListItemShimmer(),
      loading: (_) => const ListItemShimmer(),
      success: (success) {
        final data = success.data as PaginatedResponse<MovieModel>;
        return SmartRefresher(
          controller: _refreshController,
          onRefresh: onRefresh,
          onLoading: () => onLoading(data.page + 1),
          enablePullUp: data.results.isNotEmpty,
          child: GridView.builder(
            itemCount: data.results.length,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 8,
              childAspectRatio: 6 / 9,
            ),
            itemBuilder: (context, index) {
              final currentItemData = data.results[index];
              return ProviderScope(
                overrides: [
                  currentMovieItemProvider.overrideWithValue(currentItemData)
                ],
                child: const GridMovieItem(),
              );
            },
          ),
        );
      },
      error: (_) => const ErrorView(),
    );
  }
}
