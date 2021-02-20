import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/core/utils/input_converter.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/login_with_email.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/sign_out.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/sign_up_with_email.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum AuthStatus { UNAUTHENTICATED, AUTHENTICATED, LOADING }
enum UserStatus { AVAILABLE, ERROR, LOADING }

class AuthProvider extends ChangeNotifier with EquatableMixin {
  AuthProvider(
      {@required this.loginUser,
      @required this.signupUser,
      @required this.signoutUser,
      @required this.inputConverter,
      @required this.firebaseAuth})
      : assert(loginUser != null),
        assert(signupUser != null),
        assert(signoutUser != null),
        assert(firebaseAuth != null),
        assert(inputConverter != null);
  final LoginUser loginUser;
  final SignupUser signupUser;

  final SignoutUser signoutUser;
  final InputConverter inputConverter;
  final FirebaseAuth firebaseAuth;

  @override
  List<Object> get props => [];

  AuthStatus _status;
  User _firebaseUser;
  String _errorMessage;
  UserStatus _userStatus;
  User userModel;
  User _user;
  User get user => _user;

  ///Get authentication status.
  ///
  /// UNAUTHENTICATED - when user is not authenticated
  /// AUTHENTICATING - authentication is in progress
  /// AUTHENTICATED - user is authenticated
  AuthStatus get status => _status;
  UserStatus get userStatus => _userStatus;
  User get firebaseUser => _firebaseUser;

  String get error => _errorMessage;

  Stream<User> streamFirebaseUser() {
    return firebaseAuth.authStateChanges();
  }

  void signupUserWithEmail(String email, String password) {
    _status = AuthStatus.LOADING;
    notifyListeners();

    final failureOrEmail = inputConverter.stringToEmail(email);
    failureOrEmail.fold(
      (inputFailure) {
        _firebaseUser = null;
        _status = AuthStatus.UNAUTHENTICATED;
        _errorMessage = _mapFailureToMessage(inputFailure);
        notifyListeners();
      },
      (validEmail) async {
        final failureOrUser =
            await signupUser(Params(email: validEmail, password: password));
        failureOrUser.fold(
          (failure) {
            _firebaseUser = null;
            _status = AuthStatus.UNAUTHENTICATED;
            _errorMessage = _mapFailureToMessage(failure);
            notifyListeners();
          },
          (user) async {
            _status = AuthStatus.AUTHENTICATED;
            _firebaseUser = user;
            _user = user;
            notifyListeners();
          },
        );
      },
    );
  }

  Future<void> loginUserWithEmail(String email, String password) async {
    _status = AuthStatus.LOADING;
    notifyListeners();

    final failureOrUser =
        await loginUser(Params(email: email, password: password));
    failureOrUser.fold(
      (failure) {
        _firebaseUser = null;
        _status = AuthStatus.UNAUTHENTICATED;
        _errorMessage = _mapFailureToMessage(failure);
        notifyListeners();
      },
      (user) async {
        _firebaseUser = user;
        _status = AuthStatus.AUTHENTICATED;
        notifyListeners();
      },
    );
  }

  Future<void> signOutUser() async {
    _status = AuthStatus.LOADING;
    notifyListeners();

    final failureOrSuccess = await signoutUser(NoParams());
    failureOrSuccess.fold(
      (failure) {
        _firebaseUser = null;
        _status = AuthStatus.UNAUTHENTICATED;
        _errorMessage = _mapFailureToMessage(failure);
        notifyListeners();
      },
      (_) {
        _firebaseUser = null;
        _status = AuthStatus.UNAUTHENTICATED;
        notifyListeners();
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Some server error occurred';
    } else if (failure is AuthFailure) {
      return failure.message;
    } else if (failure is InvalidInputFailure) {
      return 'Invalid input. Please enter correct input.';
    } else {
      return 'Unexpected error.';
    }
  }
}
