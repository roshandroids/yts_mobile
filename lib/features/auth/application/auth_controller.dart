import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/features/auth/auth.dart';

final loginControllerProvider = StateNotifierProvider.autoDispose<
    AuthController<UserModel>, BaseState<dynamic>>(
  _authController,
);
final signupControllerProvider = StateNotifierProvider.autoDispose<
    AuthController<UserModel>, BaseState<dynamic>>(
  _authController,
);
final socialLoginControllerProvider = StateNotifierProvider.autoDispose<
    AuthController<UserModel>, BaseState<dynamic>>(
  _authController,
);
final logoutControllerProvider = StateNotifierProvider.autoDispose<
    AuthController<UserModel>, BaseState<dynamic>>(
  _authController,
);
AuthController<T> _authController<T>(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController<T>(ref, authRepository);
}

class AuthController<T> extends StateNotifier<BaseState<dynamic>> {
  ///
  AuthController(this.ref, this.authRepository)
      : super(const BaseState<void>.initial());

  final Ref ref;

  final AuthRepository authRepository;

  /// [loginWithCreds] login user with [email] and [password]
  Future<void> loginWithCreds({
    required String email,
    required String password,
  }) async {
    state = const BaseState<void>.loading();
    final response =
        await authRepository.loginWithCreds(email: email, password: password);
    state = response.fold(
      (success) => BaseState<UserModel>.success(data: success),
      BaseState.error,
    );
  }

  /// [signupWithCreds] signup user with [email] and [password]
  Future<void> signupWithCreds({
    required String email,
    required String password,
  }) async {
    state = const BaseState<void>.loading();
    final response =
        await authRepository.signupWithCreds(email: email, password: password);
    state = response.fold(
      (success) => BaseState<UserModel>.success(data: success),
      BaseState.error,
    );
  }

  /// [loginWithSocialAuth] login user with google account
  Future<void> loginWithSocialAuth({
    required SocialAuthType socialAuthType,
  }) async {
    state = const BaseState<void>.loading();
    final response = await authRepository.loginWithSocialAuth(
      socialAuthType: socialAuthType,
    );
    state = response.fold(
      (success) => BaseState<UserModel>.success(data: success),
      BaseState.error,
    );
  }

  /// [logout] logout user from the app
  Future<void> logout() async {
    state = const BaseState<void>.loading();
    await authRepository.logout().then(
          (value) => ref.read(storageServiceProvider).remove('SocialAuthType'),
        );
  }
}
