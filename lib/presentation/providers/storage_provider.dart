import 'dart:io';
import 'dart:math';

import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/upload_file.dart';
import 'package:flutter/material.dart';

enum UploadStatus { ERROR, NONE, UPLOADING, UPLOADED }
enum Status { NONE, LOADED }

class StorageProvider extends ChangeNotifier {
  StorageProvider(this.uploadFileToStorage);
  final UploadFileToStorage uploadFileToStorage;
  UploadStatus _uploadStatus;
  Status _status;
  Status get status => _status;
  final List<AnswerSheet> _answerSheets = [];

  List<AnswerSheet> get urls => _answerSheets;

  UploadStatus get uploadStatus => _uploadStatus;

  Future<void> uploadFile(File file, String name) async {
    _uploadStatus = UploadStatus.UPLOADING;
    notifyListeners();
    final failureOrUpdate =
        await uploadFileToStorage(Params(file: file, name: name));
    failureOrUpdate.fold((failure) {
      _uploadStatus = UploadStatus.ERROR;
      notifyListeners();
    }, (answerSheet) {
      _answerSheets.add(answerSheet);
      _uploadStatus = UploadStatus.UPLOADED;
      _status = Status.LOADED;
      notifyListeners();
    });
  }

  void removeAnswerSheet(String id) {
    _answerSheets.removeWhere((element) => element.id == id);
    if (_answerSheets.isEmpty) {
      _status = Status.NONE;
    }
    notifyListeners();
  }

  void addNewSheet() {
    _answerSheets.add(AnswerSheet(
        url: 'asdasd',
        name: 'asdasd',
        id: 'asd+${Random().nextInt(100).toString()}'));
    _status = Status.LOADED;
    notifyListeners();
  }
}
