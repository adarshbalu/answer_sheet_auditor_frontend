import 'package:answer_sheet_auditor/core/utils/input_converter.dart';
import 'package:answer_sheet_auditor/core/utils/network_status.dart';
import 'package:answer_sheet_auditor/data/datasources/exam_api_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources/file_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources/local_datasouce.dart';
import 'package:answer_sheet_auditor/data/datasources/remote_storage_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources/user_auth_remote_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/exam_api_datasource_impl.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/file_datasouce_impl.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/local_datasource_impl.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/remote_storage_datasource_impl.dart';
import 'package:answer_sheet_auditor/data/datasources_impl/user_auth_remote_datasource_impl.dart';
import 'package:answer_sheet_auditor/data/repositories_impl/exam_repository_impl.dart';
import 'package:answer_sheet_auditor/data/repositories_impl/local_storage_repository_impl.dart';
import 'package:answer_sheet_auditor/data/repositories_impl/remote_storage_repository_impl.dart';
import 'package:answer_sheet_auditor/data/repositories_impl/user_auth_repository_impl.dart';
import 'package:answer_sheet_auditor/domain/repositories/exam_repository.dart';
import 'package:answer_sheet_auditor/domain/repositories/local_storage_repository.dart';
import 'package:answer_sheet_auditor/domain/repositories/remote_storage_repository.dart';
import 'package:answer_sheet_auditor/domain/repositories/user_auth_repository.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/login_with_email.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/sign_out.dart';
import 'package:answer_sheet_auditor/domain/usecases/auth/sign_up_with_email.dart';
import 'package:answer_sheet_auditor/domain/usecases/exams/create_exam.dart';
import 'package:answer_sheet_auditor/domain/usecases/exams/get_all_exams.dart';
import 'package:answer_sheet_auditor/domain/usecases/exams/view_exam_details.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/delete_sheet.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/pick_image.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/pick_text.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/upload_image.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/upload_text.dart';
import 'package:answer_sheet_auditor/presentation/providers/auth_provider.dart';
import 'package:answer_sheet_auditor/presentation/providers/bottom_nav_provider.dart';
import 'package:answer_sheet_auditor/presentation/providers/exam_provider.dart';
import 'package:answer_sheet_auditor/presentation/providers/storage_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
    () =>
        StorageProvider(locator(), locator(), locator(), locator(), locator()),
  );

  locator.registerFactory(
    () => BottomNavProvider(),
  );

  locator.registerFactory(
    () => ExamProvider(locator(), locator(), locator()),
  );

  //usecases

  _initAuthUsecases();
  _initStorageUseCases();
  _initExamUseCases();

  //repository

  locator
      .registerLazySingleton<UserAuthRepository>(() => UserAuthRepositoryImpl(
            locator(),
            locator(),
          ));

  locator.registerLazySingleton<RemoteStorageRepository>(
      () => RemoteStorageRepositoryImpl(
            locator(),
            locator(),
          ));

  locator.registerLazySingleton<LocalStorageRepository>(
      () => LocalStorageRepositoryImpl(
            locator(),
          ));

  locator.registerLazySingleton<ExamRepository>(
      () => ExamRepositoryImpl(locator(), locator()));

  //data sources

  locator.registerLazySingleton<UserAuthRemoteDataSource>(
      () => UserAuthRemoteDataSourceImpl(locator(), locator()));

  locator.registerLazySingleton<FileDataSource>(() => FileDataSourceImpl());

  locator.registerLazySingleton<ExamAPIRemoteDataSource>(
      () => ExamAPIRemoteDataSourceImpl(locator()));

  locator.registerLazySingleton<RemoteStorageDataSource>(
      () => RemoteStorageDataSourceImpl(locator()));

  locator.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(
        locator(),
      ));

  //core

  locator.registerLazySingleton(() => InputConverter());
  locator.registerLazySingleton(() => NetworkStatusService(locator()));

  //external

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
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
  locator.registerLazySingleton(() => DeleteAnswerSheet(locator()));
}

void _initExamUseCases() {
  locator.registerLazySingleton(() => GetAllExams(locator()));
  locator.registerLazySingleton(() => ViewExamDetails(locator()));
  locator.registerLazySingleton(() => CreateExams(locator()));
}
