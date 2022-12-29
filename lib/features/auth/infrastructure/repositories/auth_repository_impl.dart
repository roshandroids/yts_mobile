import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/features/auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.firebaseAuth, this.storageService);

  final FirebaseAuth firebaseAuth;
  final StorageService storageService;

  GoogleSignIn get _googleSignIn => GoogleSignIn(scopes: <String>['email']);
  FacebookAuth get _facebookLogin => FacebookAuth.instance;

  @override
  Future<Either<UserModel, Failure>> loginWithCreds({
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await storageService.set('authType', 'email');
      return Left(
        UserModel(
          email: response.user!.email!,
          userId: response.user!.uid,
          emailVerified: response.user!.emailVerified,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return Right(
        Failure(e.getMessageFromErrorCode, FailureType.authentication),
      );
    } catch (e) {
      return Right(Failure.fromException(e));
    }
  }

  @override
  Future<Either<UserModel, Failure>> signupWithCreds({
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Left(
        UserModel(
          email: response.user!.email!,
          userId: response.user!.uid,
          emailVerified: response.user!.emailVerified,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return Right(
        Failure(e.getMessageFromErrorCode, FailureType.authentication),
      );
    } catch (e) {
      return Right(Failure.fromException(e));
    }
  }

  @override
  Future<Either<UserModel, Failure>> loginWithSocialAuth({
    required SocialAuthType socialAuthType,
  }) async {
    try {
      if (socialAuthType == SocialAuthType.google) {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        final response = await firebaseAuth.signInWithCredential(credential);
        await storageService.set('authType', socialAuthType.name);
        return Left(
          UserModel(
            email: response.user!.email!,
            userId: response.user!.uid,
            emailVerified: response.user!.emailVerified,
          ),
        );
      } else {
        final facebookUser = await _facebookLogin
            .login(permissions: ['public_profile', 'email']);
        final facebookAuthCredential =
            FacebookAuthProvider.credential(facebookUser.accessToken!.token);
        final response =
            await firebaseAuth.signInWithCredential(facebookAuthCredential);
        return Left(
          UserModel(
            email: response.user!.email!,
            userId: response.user!.uid,
            emailVerified: response.user!.emailVerified,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      await _logoutSocialAuth(socialAuthType);
      return Right(
        Failure(e.getMessageFromErrorCode, FailureType.authentication),
      );
    } catch (e) {
      await _logoutSocialAuth(socialAuthType);
      return Right(Failure.fromException(e));
    }
  }

  Future<void> _logoutSocialAuth(SocialAuthType authType) async {
    if (authType == SocialAuthType.google) {
      await _googleSignIn.signOut();
      return;
    } else {
      await _facebookLogin.logOut();
      return;
    }
  }

  @override
  Future<Either<bool, Failure>> logout() async {
    try {
      final authType = storageService.get('authType');
      if (authType != null) {
        switch (authType) {
          case 'email':
            await firebaseAuth.signOut();
            break;
          case 'facebook':
            await _facebookLogin.logOut();
            break;
          case 'google':
            await _googleSignIn.signOut();
            break;
        }
        return const Left(true);
      }
      return Right(Failure("Couldn't logout", FailureType.exception));
    } catch (e) {
      return Right(Failure.fromException(e));
    }
  }
}
