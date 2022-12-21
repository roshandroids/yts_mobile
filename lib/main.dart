import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yts_mobile/app/yts_app.dart';
import 'package:yts_mobile/core/services/storage/hive_storage_service.dart';
import 'package:yts_mobile/core/services/storage/storage_service.dart';
import 'package:yts_mobile/core/services/storage/storage_service_provider.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      // Hive-specific initialization
      await Hive.initFlutter();
      final StorageService initializedStorageService = HiveStorageService();
      await initializedStorageService.init();
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
