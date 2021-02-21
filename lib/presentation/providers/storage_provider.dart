import 'dart:io';
import 'dart:math';

import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/pick_image.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/pick_text.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/upload_image.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/upload_text.dart';
import 'package:flutter/material.dart';

enum UploadStatus { ERROR, NONE, UPLOADING, UPLOADED }
enum Status { NONE, LOADED }
enum FileStatus { ERROR, NONE, SUCCESS, LOADING }

class StorageProvider extends ChangeNotifier {
  StorageProvider(this.uploadImageFileToStorage, this.pickTextFile,
      this.pickImageFile, this.uploadTextToStorage);
  final PickTextFile pickTextFile;
  final PickImageFile pickImageFile;
  final UploadImageToStorage uploadImageFileToStorage;
  final UploadTextToStorage uploadTextToStorage;
  UploadStatus _uploadStatus;
  FileStatus _imageFileStatus, _textFileStatus;

  FileStatus get textFileStatus => _textFileStatus;

  FileStatus get imageFileStatus => _imageFileStatus;
  Status _status;
  Status get status => _status;
  final List<AnswerSheet> _answerSheets = [];
  String _pickedFileName;

  String get pickedFileName => _pickedFileName;

  List<AnswerSheet> get answerSheets => _answerSheets;

  UploadStatus get uploadStatus => _uploadStatus;

  Future<void> pickImage() async {
    _imageFileStatus = FileStatus.LOADING;
    notifyListeners();
    final failureOrPickImage = await pickImageFile(NoParams());
    failureOrPickImage.fold((failure) {
      _imageFileStatus = FileStatus.ERROR;
      notifyListeners();
      Future.delayed(const Duration(seconds: 2), () {
        _imageFileStatus = FileStatus.NONE;
        notifyListeners();
      });
    }, (file) {
      _pickedFile = file;
      _imageFileStatus = FileStatus.SUCCESS;
      _pickedFileName = _pickedFile.path.split('/').last;
      notifyListeners();
    });
  }

  Future<void> pickText() async {
    _textFileStatus = FileStatus.LOADING;
    notifyListeners();
    final failureOrPickImage = await pickTextFile(NoParams());
    failureOrPickImage.fold((failure) {
      _textFileStatus = FileStatus.ERROR;
      notifyListeners();
      Future.delayed(const Duration(seconds: 2), () {
        _textFileStatus = FileStatus.NONE;
        notifyListeners();
      });
    }, (file) {
      _pickedFile = file;
      _textFileStatus = FileStatus.SUCCESS;
      _pickedFileName = _pickedFile.path.split('/').last;
      notifyListeners();
    });
  }

  void pickNewImage() {
    _imageFileStatus = FileStatus.NONE;
    notifyListeners();
  }

  File _pickedFile;

  File get pickedFile => _pickedFile;

  Future<void> uploadImageFile(String name) async {
    _uploadStatus = UploadStatus.UPLOADING;
    notifyListeners();
    final failureOrUpdate =
        await uploadImageFileToStorage(Params(file: pickedFile, name: name));
    failureOrUpdate.fold((failure) {
      _uploadStatus = UploadStatus.ERROR;
      notifyListeners();
      Future.delayed(const Duration(seconds: 2), () {
        _uploadStatus = UploadStatus.NONE;
        notifyListeners();
      });
    }, (answerSheet) {
      // _answerSheets.add(answerSheet);
      _uploadStatus = UploadStatus.UPLOADED;
      _status = Status.LOADED;
      notifyListeners();
    });
  }

  Future<void> uploadTextFile(String name) async {
    _uploadStatus = UploadStatus.UPLOADING;
    notifyListeners();
    final failureOrUpdate =
        await uploadImageFileToStorage(Params(file: pickedFile, name: name));
    failureOrUpdate.fold((failure) {
      _uploadStatus = UploadStatus.ERROR;
      notifyListeners();
      Future.delayed(const Duration(seconds: 2), () {
        _uploadStatus = UploadStatus.NONE;
        notifyListeners();
      });
    }, (answerSheet) {
      // _answerSheets.add(answerSheet);
      _uploadStatus = UploadStatus.UPLOADED;
      _status = Status.LOADED;
      notifyListeners();
    });
  }

  void resetUploadStatus() {
    _uploadStatus = UploadStatus.NONE;
    notifyListeners();
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
