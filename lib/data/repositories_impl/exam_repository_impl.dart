import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:answer_sheet_auditor/core/utils/strings_manager.dart';
import 'package:answer_sheet_auditor/data/datasources/exam_api_datasource.dart';
import 'package:answer_sheet_auditor/data/datasources/local_datasouce.dart';
import 'package:answer_sheet_auditor/domain/entities/exam.dart';
import 'package:answer_sheet_auditor/domain/repositories/exam_repository.dart';
import 'package:dartz/dartz.dart';

class ExamRepositoryImpl extends ExamRepository {
  ExamRepositoryImpl(this.dataSource, this.localDataSource);
  final ExamAPIRemoteDataSource dataSource;
  final LocalDataSource localDataSource;

  @override
  Future<Either<Failure, void>> createExam(Map<String, dynamic> data) async {
    try {
      final String token = localDataSource.getString(StringsManager.JWT_TOKEN);
      final result = await dataSource.createExam(data, token);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Exams>>> listAllExams() async {
    try {
      final String token = localDataSource.getString(StringsManager.JWT_TOKEN);
      final result = await dataSource.getAllExams(token);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
