import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/auth/auth.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutePaths.splashRoute.path,
    routes: [
      GoRoute(
        path: RoutePaths.splashRoute.path,
        name: RoutePaths.splashRoute.routeName,
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
        redirect: (_, __) => RoutePaths.latestMovies.path,
      ),
      GoRoute(
        path: RoutePaths.latestMovies.path,
        name: RoutePaths.latestMovies.routeName,
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: const LatestMoviesPage(),
        ),
        routes: [
          GoRoute(
            path: RoutePaths.movieDetail.path,
            name: RoutePaths.movieDetail.routeName,
            pageBuilder: (context, state) => FadeTransitionPage(
              key: state.pageKey,
              child: const MovieDetail(),
            ),
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      return null;
    },
    debugLogDiagnostics: kDebugMode,
  );
});

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (c, animation, a2, child) => FadeTransition(
            opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
            child: child,
          ),
        );
}
