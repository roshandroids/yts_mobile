import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/features/auth/auth.dart';

final authStatusProvider = ChangeNotifierProvider<GoRouterRefreshStream>((ref) {
  return GoRouterRefreshStream(
    ref.read(firebaseAuthProvider).authStateChanges(),
  );
});
final skippedProvider = StateProvider<bool>((ref) {
  return false;
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<User?> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (user) {
        _isLoggedIn = user != null;
        notifyListeners();
      },
    );
  }

  late final StreamSubscription<User?> _subscription;
  bool _isLoggedIn = false;
  bool get loggedInStatus => _isLoggedIn;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
