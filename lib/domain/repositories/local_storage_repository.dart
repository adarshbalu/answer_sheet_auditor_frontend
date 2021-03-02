import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class LocalStorageRepository {
  Future<Either<Failure, String>> getStringFromStorage(String key);
  Future<Either<Failure, void>> saveStringToStorage(String key, String data);
  Future<Either<Failure, int>> getIntFromStorage(String key);
}
