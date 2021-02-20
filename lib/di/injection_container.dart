import 'package:answer_sheet_auditor/core/utils/input_converter.dart';
import 'package:answer_sheet_auditor/data/datasources/user_auth_remote_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/user_auth_remote_datasource_impl.dart';
import 'package:answer_sheet_auditor/data/repositories_impl/user_auth_repository_impl.dart';
import 'package:answer_sheet_auditor/domain/repositories/user_auth_repository.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/login_with_email.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/sign_out.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/sign_up_with_email.dart';
import 'package:answer_sheet_auditor/presentation/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> init() async {
  await Firebase.initializeApp();

  //provider
  locator.registerFactory(
    () => AuthProvider(
      firebaseAuth: locator(),
      loginUser: locator(),
      signupUser: locator(),
      signoutUser: locator(),
      inputConverter: locator(),
    ),
  );
  //usecases

  _initAuthUsecases();

  //repository

  locator.registerLazySingleton<UserAuthRepository>(
      () => UserAuthRepositoryImpl(locator()));

  //data sources

  locator.registerLazySingleton<UserAuthRemoteDataSource>(
      () => UserAuthRemoteDataSourceImpl(locator()));

  //core

  locator.registerLazySingleton(() => InputConverter());

  //external
  locator.registerLazySingleton(() => FirebaseAuth.instance);
}

void _initAuthUsecases() {
  locator.registerLazySingleton(() => LoginUser(locator()));
  locator.registerLazySingleton(() => SignupUser(locator()));
  locator.registerLazySingleton(() => SignoutUser(locator()));
}
