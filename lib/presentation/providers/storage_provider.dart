import 'dart:io';

import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/upload_file.dart';
import 'package:flutter/material.dart';

enum UploadStatus { ERROR, NONE, UPLOADING, UPLOADED }

class StorageProvider extends ChangeNotifier {
  StorageProvider(this.uploadFileToStorage);
  final UploadFileToStorage uploadFileToStorage;
  UploadStatus _uploadStatus;
  final List<String> _urls = [];

  List<String> get urls => _urls;

  UploadStatus get uploadStatus => _uploadStatus;

  Future<void> uploadFile(File file) async {
    _uploadStatus = UploadStatus.UPLOADING;
    notifyListeners();
    final failureOrUpdate = await uploadFileToStorage(Params(file: file));
    failureOrUpdate.fold((failure) {
      _uploadStatus = UploadStatus.ERROR;
      notifyListeners();
    }, (url) {
      _urls.add(url);
      _uploadStatus = UploadStatus.UPLOADED;
      notifyListeners();
    });
  }
}
