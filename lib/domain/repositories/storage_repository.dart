import 'dart:io';

import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class StorageRepository {
  Future<Either<Failure, String>> uploadFileToStorage(File file);
}
