import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yts_mobile/core/core.dart';
import 'package:yts_mobile/features/auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;
  GoogleSignIn get _googleSignIn => GoogleSignIn(scopes: <String>['email']);

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
      await firebaseAuth.signOut();
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
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final response = await firebaseAuth.signInWithCredential(credential);

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
}
