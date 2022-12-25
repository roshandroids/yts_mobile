import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';

/// Main App Widget
class YtsApp extends ConsumerWidget {
  /// Creates new instance of [YtsApp]
  const YtsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final themeData = ref.watch(themeProvider);
    return MaterialApp.router(
      title: 'Yts Movies App',
      debugShowCheckedModeBanner: false,
      themeMode: themeData.getCurrentThemeMode,
      theme: themeData.getLightThemeData,
      darkTheme: themeData.getDarkThemeData,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      routerDelegate: goRouter.routerDelegate,
    );
  }
}
