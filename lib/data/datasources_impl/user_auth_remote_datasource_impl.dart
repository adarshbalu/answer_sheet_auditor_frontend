import 'package:answer_sheet_auditor/core/error/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/error/exceptions.dart' as exc;
import '../datasources/user_auth_remote_datasource.dart';

class UserAuthRemoteDataSourceImpl implements UserAuthRemoteDataSource {
  UserAuthRemoteDataSourceImpl(this.auth);
  final FirebaseAuth auth;

  @override
  Future<User> signUpWithEmail(String email, String password) async {
    try {
      final signedUpUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return signedUpUser?.user;
    } catch (error) {
      switch (error.code.toString()) {
        case 'ERROR_WEAK_PASSWORD':
          throw exc.AuthException(message: ErrorMessages.WEAK_PASSWORD);
          break;

        case 'ERROR_INVALID_EMAIL':
          throw exc.AuthException(message: ErrorMessages.INVALID_EMAIL);
          break;

        case 'ERROR_EMAIL_ALREADY_IN_USE':
          throw exc.AuthException(message: ErrorMessages.EMAIL_ALREADY_IN_USE);
          break;

        default:
          throw exc.AuthException();
      }
    }
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return user.user;
    } catch (error) {
      switch (error.code.toString()) {
        case 'ERROR_INVALID_EMAIL':
          throw exc.AuthException(message: ErrorMessages.INVALID_EMAIL);
          break;

        case 'ERROR_WRONG_PASSWORD':
          throw exc.AuthException(message: ErrorMessages.WRONG_PASSWORD);
          break;

        case 'ERROR_USER_NOT_FOUND':
          throw exc.AuthException(message: ErrorMessages.NO_USERS_FOUND);
          break;

        case 'ERROR_USER_DISABLED':
          throw exc.AuthException(message: ErrorMessages.USER_DISABLED);
          break;

        case 'ERROR_TOO_MANY_REQUESTS':
          throw exc.AuthException(message: ErrorMessages.TOO_MANY_REQUESTS);
          break;

        case 'ERROR_OPERATION_NOT_ALLOWED':
          throw exc.AuthException(message: ErrorMessages.OPERATION_NOT_ALLOWED);
          break;

        default:
          throw exc.AuthException();
      }
    }
  }

  @override
  Future<void> signOut() {
    return auth.signOut();
  }

  @override
  Future<User> getCurrentUser() async {
    return auth.currentUser;
  }
}
