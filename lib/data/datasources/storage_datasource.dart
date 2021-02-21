import 'dart:io';

import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';

abstract class StorageRemoteDataSource {
  Future<AnswerSheet> uploadAnswerSheet(File file, String name);
}
