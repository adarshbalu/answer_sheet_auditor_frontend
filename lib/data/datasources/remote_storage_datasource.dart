import 'dart:io';

import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';

abstract class RemoteStorageDataSource {
  Future<AnswerSheet> uploadAnswerSheet(
      File file, String name, String uid, String examName);
  Future<String> uploadAnswerkey(File file, String name, String uid);
}
