// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:yts_mobile/app/app.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/firebase_options.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      setUrlStrategy(PathUrlStrategy());

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // Hive-specific initialization
      await Hive.initFlutter();
      final StorageService initializedStorageService = HiveStorageService();
      await initializedStorageService.init();
      FlutterError.demangleStackTrace = (StackTrace stack) {
        if (stack is stack_trace.Trace) return stack.vmTrace;
        if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
        return stack;
      };
      runApp(
        ProviderScope(
          overrides: [
            storageServiceProvider.overrideWithValue(initializedStorageService),
          ],
          child: const YtsApp(),
        ),
      );
    },
    // ignore: only_throw_errors
    (e, _) => throw e,
  );
}
