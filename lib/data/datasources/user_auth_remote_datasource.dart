import 'package:firebase_auth/firebase_auth.dart';

abstract class UserAuthRemoteDataSource {
  /// Signs up user with given [email] and [password]
  /// and returns his UID.
  ///
  /// Returns [AuthException] in case of errors.
  Future<User> signUpWithEmail(String email, String password);

  /// Signs in user with given [email] and [password]
  /// and returns his UID.
  ///
  /// Throws [AuthException] for all error codes.
  Future<User> signInWithEmail(String email, String password);

  /// Signs out the user.
  Future<void> signOut();

  /// Gets current signed in user.
  Future<User> getCurrentUser();
}
