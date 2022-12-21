/// App level configuration variables
class AppConfigs {
  /// The max allowed age duration for the http cache
  static const Duration maxCacheAge = Duration(minutes: 30);

  /// Key used in dio options to indicate whether
  /// cache should be force refreshed
  static const String dioCacheForceRefreshKey = 'dio_cache_force_refresh_key';

  /// Base API URL of The YTS Movies API
  ///
  /// See: https://yts.mx/api
  static const String apiBaseUrl = 'https://yts.mx/api/v2';
}
