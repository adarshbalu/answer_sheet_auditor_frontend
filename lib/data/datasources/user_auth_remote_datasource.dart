import 'package:firebase_auth/firebase_auth.dart';

abstract class UserAuthRemoteDataSource {
  /// Signs up user with given [email] and [password]
  /// and returns his UID.
  ///
  /// Returns [AuthException] in case of errors.
  Future<User> signUpWithEmailOnFirebase(String email, String password);

  /// Signs in user with given [email] and [password]
  /// and returns his UID.
  ///
  /// Throws [AuthException] for all error codes.
  Future<User> signInWithEmailOnFirebase(String email, String password);

  /// Signs out the user.
  Future<void> signOut();

  Future<String> signUpUser(
    String email,
    String password,
    String uid,
  );
  Future<String> signInUser(
    String email,
    String password,
  );

  /// Gets current signed in user.
  Future<User> getCurrentUser();
}
