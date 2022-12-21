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
    return MaterialApp.router(
      title: 'Yts App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      routerDelegate: goRouter.routerDelegate,
    );
  }
}
