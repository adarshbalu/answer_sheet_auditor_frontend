import 'package:answer_sheet_auditor/core/utils/input_converter.dart';
import 'package:answer_sheet_auditor/core/utils/network_status.dart';
import 'package:answer_sheet_auditor/data/datasources/file_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources/storage_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources/user_auth_remote_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/file_datasouce_impl.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/storage_datasource_impl.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/user_auth_remote_datasource_impl.dart';
import 'package:answer_sheet_auditor/data/repositories_impl/storage_repository_impl.dart';
import 'package:answer_sheet_auditor/data/repositories_impl/user_auth_repository_impl.dart';
import 'package:answer_sheet_auditor/domain/repositories/storage_repository.dart';
import 'package:answer_sheet_auditor/domain/repositories/user_auth_repository.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/login_with_email.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/sign_out.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/sign_up_with_email.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/pick_image.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/pick_text.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/upload_image.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/upload_text.dart';
import 'package:answer_sheet_auditor/presentation/providers/auth_provider.dart';
import 'package:answer_sheet_auditor/presentation/providers/storage_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  locator.registerFactory(
    () => StorageProvider(locator(), locator(), locator(), locator()),
  );

  //usecases

  _initAuthUsecases();
  _initStorageUseCases();

  //repository

  locator.registerLazySingleton<UserAuthRepository>(
      () => UserAuthRepositoryImpl(locator()));

  locator.registerLazySingleton<StorageRepository>(
      () => StorageRepositoryImpl(locator(), locator()));

  //data sources

  locator.registerLazySingleton<UserAuthRemoteDataSource>(
      () => UserAuthRemoteDataSourceImpl(locator()));

  locator.registerLazySingleton<FileDataSource>(() => FileDataSouceImpl());

  locator.registerLazySingleton<StorageRemoteDataSource>(
      () => StorageRemoteDataSourceImpl(locator()));

  //core

  locator.registerLazySingleton(() => InputConverter());
  locator.registerLazySingleton(() => NetworkStatusService(locator()));

  //external
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => Connectivity());
  locator.registerLazySingleton(() => FirebaseStorage.instance);
}

void _initAuthUsecases() {
  locator.registerLazySingleton(() => LoginUser(locator()));
  locator.registerLazySingleton(() => SignupUser(locator()));
  locator.registerLazySingleton(() => SignoutUser(locator()));
}

void _initStorageUseCases() {
  locator.registerLazySingleton(() => UploadImageToStorage(locator()));
  locator.registerLazySingleton(() => PickImageFile(locator()));
  locator.registerLazySingleton(() => PickTextFile(locator()));
  locator.registerLazySingleton(() => UploadTextToStorage(locator()));
}
