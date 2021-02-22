import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/data/datasources/local_datasouce.dart';
import 'package:answer_sheet_auditor/domain/repositories/local_storage_repository.dart';
import 'package:dartz/dartz.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  LocalStorageRepositoryImpl(this.localDataSource);
  final LocalDataSource localDataSource;

  @override
  @override
  Either<Failure, String> getStringFromStorage(String key) {
    try {
      final String result = localDataSource.getString(key);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getIntFromStorage(String key) async {
    try {
      await localDataSource.reloadData();
      final result = await localDataSource.getInt(key);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveStringToStorage(
      String key, String data) async {
    try {
      await localDataSource.saveString(key, data);
      return Right(await localDataSource.reloadData());
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
