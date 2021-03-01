import 'package:answer_sheet_auditor/core/utils/input_converter.dart';
import 'package:answer_sheet_auditor/core/utils/network_status.dart';
import 'package:answer_sheet_auditor/data/datasources/file_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources/local_datasouce.dart';
import 'package:answer_sheet_auditor/data/datasources/ml_kit_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources/remote_storage_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources/user_auth_remote_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/file_datasouce_impl.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/local_datasource_impl.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/ml_kit_datasource_impl.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/remote_storage_datasource_impl.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/user_auth_remote_datasource_impl.dart';
import 'package:answer_sheet_auditor/data/repositories_impl/local_storage_repository_impl.dart';
import 'package:answer_sheet_auditor/data/repositories_impl/remote_storage_repository_impl.dart';
import 'package:answer_sheet_auditor/data/repositories_impl/text_recognizer_repository_impl.dart';
import 'package:answer_sheet_auditor/data/repositories_impl/user_auth_repository_impl.dart';
import 'package:answer_sheet_auditor/domain/repositories/local_storage_repository.dart';
import 'package:answer_sheet_auditor/domain/repositories/remote_storage_repository.dart';
import 'package:answer_sheet_auditor/domain/repositories/text_recognizer_repository.dart';
import 'package:answer_sheet_auditor/domain/repositories/user_auth_repository.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/login_with_email.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/sign_out.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/sign_up_with_email.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/pick_image.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/pick_text.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/upload_image.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/upload_text.dart';
import 'package:answer_sheet_auditor/domain/usecases/text_recognition/get_vision_image_from_file.dart';
import 'package:answer_sheet_auditor/domain/usecases/text_recognition/get_vision_text_from_vision_image.dart';
import 'package:answer_sheet_auditor/presentation/providers/auth_provider.dart';
import 'package:answer_sheet_auditor/presentation/providers/bottom_nav_provider.dart';
import 'package:answer_sheet_auditor/presentation/providers/storage_provider.dart';
import 'package:answer_sheet_auditor/presentation/providers/text_recognizer_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  locator.registerFactory(
    () => BottomNavProvider(),
  );

  locator.registerFactory(
    () => TextRecognizerProvider(locator(), locator()),
  );

  //usecases

  _initAuthUsecases();
  _initStorageUseCases();
  _initTextRecognitionUseCases();

  //repository

  locator.registerLazySingleton<UserAuthRepository>(
      () => UserAuthRepositoryImpl(locator(), locator()));

  locator.registerLazySingleton<RemoteStorageRepository>(
      () => RemoteStorageRepositoryImpl(locator(), locator()));

  locator.registerLazySingleton<LocalStorageRepository>(
      () => LocalStorageRepositoryImpl(
            locator(),
          ));

  locator.registerLazySingleton<TextRecognizerRepository>(
      () => TextRecognizerRepositoryImpl(locator()));

  //data sources

  locator.registerLazySingleton<UserAuthRemoteDataSource>(
      () => UserAuthRemoteDataSourceImpl(locator(), locator()));

  locator.registerLazySingleton<FileDataSource>(() => FileDataSouceImpl());

  locator.registerLazySingleton<RemoteStorageDataSource>(
      () => RemoteStorageDataSourceImpl(locator()));

  locator.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(
        locator(),
      ));

  locator.registerLazySingleton<MLKitDataSource>(() => MLKitDataSourceImpl(
        locator(),
      ));

  //core

  locator.registerLazySingleton(() => InputConverter());
  locator.registerLazySingleton(() => NetworkStatusService(locator()));

  //external

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => FirebaseVision.instance.textRecognizer());
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => Connectivity());
  locator.registerLazySingleton(() => FirebaseStorage.instance);
  locator.registerLazySingleton(() => DataConnectionChecker());
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

void _initTextRecognitionUseCases() {
  locator.registerLazySingleton(() => GetVisionImageFromFile(locator()));
  locator.registerLazySingleton(() => GetVisionTextFromVisionImage(locator()));
}
