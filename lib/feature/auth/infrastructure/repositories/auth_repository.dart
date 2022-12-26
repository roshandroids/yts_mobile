import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/feature/auth/auth.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    return AuthRepositoryImpl(firebaseAuth);
  },
);

abstract class AuthRepository {
  ///[loginWithCreds] login user with provided creds
  Future<Either<UserModel, Failure>> loginWithCreds({
    required String email,
    required String password,
  });

  ///[signupWithCreds] register user with provided creds
  Future<Either<UserModel, Failure>> signupWithCreds({
    required String email,
    required String password,
  });
}
