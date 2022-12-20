import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Main App Widget
class YtsApp extends ConsumerWidget {
  /// Creates new instance of [YtsApp]
  const YtsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      title: 'Yts App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      home: Scaffold(),
    );
  }
}
