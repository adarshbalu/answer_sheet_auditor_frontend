import 'dart:io';

import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/delete_sheet.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/pick_image.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/pick_text.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/upload_image.dart';
import 'package:answer_sheet_auditor/domain/usecases/storage/upload_text.dart';
import 'package:flutter/material.dart';

enum UploadStatus { ERROR, NONE, UPLOADING, UPLOADED }
enum SheetStatus { EMPTY, LOADED }
enum FileStatus { ERROR, NONE, SUCCESS, LOADING }

class StorageProvider extends ChangeNotifier {
  StorageProvider(this.uploadImageFileToStorage, this.pickTextFile,
      this.pickImageFile, this.uploadTextToStorage, this.deleteAnswerSheet);
  final PickTextFile pickTextFile;
  final PickImageFile pickImageFile;
  final UploadImageToStorage uploadImageFileToStorage;
  final UploadTextToStorage uploadTextToStorage;
  final DeleteAnswerSheet deleteAnswerSheet;
  UploadStatus _uploadStatus, _keyUploadStatus;

  UploadStatus get keyUploadStatus => _keyUploadStatus;
  FileStatus _imageFileStatus, _textFileStatus;

  FileStatus get textFileStatus => _textFileStatus;

  FileStatus get imageFileStatus => _imageFileStatus;
  SheetStatus _sheetStatus;
  SheetStatus get sheetStatus => _sheetStatus;
  final List<AnswerSheet> _answerSheets = [];
  String _pickedFileName;

  String get pickedFileName => _pickedFileName;

  List<AnswerSheet> get answerSheets => _answerSheets;
  String _answerKeyURL;
  String _examName;

  String get examName => _examName;

  String get answerKeyURL => _answerKeyURL;

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

  Future<void> uploadImageFile(String name, String uid) async {
    _uploadStatus = UploadStatus.UPLOADING;
    notifyListeners();
    final failureOrUpdate = await uploadImageFileToStorage(
        Params(file: pickedFile, name: name, uid: uid, examName: _examName));
    failureOrUpdate.fold((failure) {
      _uploadStatus = UploadStatus.ERROR;
      notifyListeners();
      Future.delayed(const Duration(seconds: 2), () {
        _uploadStatus = UploadStatus.NONE;
        notifyListeners();
      });
    }, (answerSheet) {
      _answerSheets.add(answerSheet);
      _uploadStatus = UploadStatus.UPLOADED;
      _sheetStatus = SheetStatus.LOADED;
      _imageFileStatus = FileStatus.NONE;
      notifyListeners();
      Future.delayed(const Duration(seconds: 2), () {
        _uploadStatus = UploadStatus.NONE;
        notifyListeners();
      });
    });
  }

  Future<void> uploadTextFile(String name, String uid) async {
    _keyUploadStatus = UploadStatus.UPLOADING;
    notifyListeners();
    final failureOrUpdate = await uploadTextToStorage(
        Params(file: pickedFile, name: name, uid: uid));
    failureOrUpdate.fold((failure) {
      _keyUploadStatus = UploadStatus.ERROR;
      notifyListeners();
      Future.delayed(const Duration(seconds: 2), () {
        _keyUploadStatus = UploadStatus.NONE;
        notifyListeners();
      });
    }, (downloadURL) {
      _examName = name;
      _answerKeyURL = downloadURL;
      _keyUploadStatus = UploadStatus.UPLOADED;
      _sheetStatus = SheetStatus.LOADED;
      notifyListeners();
    });
  }

  void resetUploadStatus() {
    _uploadStatus = UploadStatus.NONE;
    _imageFileStatus = FileStatus.NONE;
    notifyListeners();
  }

  void resetSheetStatus() {
    _imageFileStatus = FileStatus.NONE;
  }

  Future<void> removeAnswerSheet(String id, String uid) async {
    AnswerSheet answerSheet;
    // ignore: avoid_function_literals_in_foreach_calls
    _answerSheets.forEach((element) {
      if (element.id == id) {
        answerSheet = element;
      }
    });

    await deleteAnswerSheet(
        Params(name: answerSheet.name, examName: examName, uid: uid));
    _answerSheets.removeWhere((element) => element.id == id);
    if (_answerSheets.isEmpty) {
      _sheetStatus = SheetStatus.EMPTY;
    }
    notifyListeners();
  }
}
