import 'package:answer_sheet_auditor/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  Either<Failure, String> stringToEmail(String str) {
    if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(str.trim())) {
      return Left(InvalidInputFailure());
    }
    return Right(str.trim());
  }
}
