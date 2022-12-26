import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/auth/auth.dart';
import 'package:yts_mobile/feature/movies/movies.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authProvider);
  final key = GlobalKey<NavigatorState>();

  return GoRouter(
    initialLocation: RoutePaths.splashRoute.path,
    navigatorKey: key,
    routes: [
      GoRoute(
        path: RoutePaths.splashRoute.path,
        name: RoutePaths.splashRoute.routeName,
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
        redirect: (_, __) => RoutePaths.loginRoute.path,
      ),
      GoRoute(
        path: RoutePaths.loginRoute.path,
        name: RoutePaths.loginRoute.routeName,
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.signupRoute.path,
        name: RoutePaths.signupRoute.routeName,
        pageBuilder: (context, state) => FadeTransitionPage(
          key: state.pageKey,
          child: const SignupScreen(),
        ),
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
              child: MovieDetailPage(
                movieId: int.parse(state.params['id']!),
                imgCoverUrl: state.extra as String?,
              ),
            ),
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      return null;

      // return RoutePaths.loginRoute.path;

      // If our async state is loading, don't perform redirects, yet
      // if (authState.isLoading || authState.hasError) return null;

      // // Here we guarantee that hasData == true, i.e. we have a readable value

      // // This has to do with how the FirebaseAuth SDK handles the "log-in" state
      // // Returning `null` means "we are not authorized"
      // final isAuth = authState.valueOrNull != null;

      // final isSplash = state.location == RoutePaths.splashRoute.path;
      // if (isSplash) {
      //   return isAuth
      //       ? RoutePaths.latestMovies.path
      //       : RoutePaths.loginRoute.path;
      // }

      // final isLoggingIn = state.location == RoutePaths.loginRoute.path;
      // if (isLoggingIn) return isAuth ? RoutePaths.latestMovies.path : null;

      // return isAuth ? null : RoutePaths.splashRoute.path;
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
