import 'package:yts_mobile/core/core.dart';

/// [RoutePaths] list of all routes
class RoutePaths {
  static final AppRouteModel splashRoute =
      AppRouteModel(routeName: 'splashPage', path: '/splashPage');
  static final AppRouteModel latestMovies =
      AppRouteModel(routeName: 'latest', path: '/latest');
  static final AppRouteModel movieDetail =
      AppRouteModel(routeName: 'details', path: ':id');
  static final AppRouteModel errorRoute =
      AppRouteModel(routeName: 'error', path: '/error');
}
