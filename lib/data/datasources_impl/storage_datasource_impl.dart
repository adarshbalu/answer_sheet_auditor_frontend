import 'dart:io';

import 'package:answer_sheet_auditor/core/error/exceptions.dart';
import 'package:answer_sheet_auditor/data/datasources/storage_datasource.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class StorageRemoteDataSourceImpl extends StorageRemoteDataSource {
  StorageRemoteDataSourceImpl(this.firebaseStorage);
  final FirebaseStorage firebaseStorage;

  @override
  Future<AnswerSheet> uploadAnswerSheet(File file, String name) async {
    try {
      final Uuid uuid = Uuid();
      final DateFormat dateFormat = DateFormat.yMMMMd();
      final String folderName = dateFormat.format(DateTime.now());
      final String id = uuid.v4();
      final Reference reference =
          firebaseStorage.ref().child('answer_sheet_uploads/$folderName/$id');
      final UploadTask uploadTask = reference.putFile(file);
      final TaskSnapshot storageTaskSnapshot = uploadTask.snapshot;
      return storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) async {
        return AnswerSheet(url: downloadUrl, name: name, id: id);
      }, onError: (err) {
        throw UploadException(message: err.toString());
      });
    } catch (e) {
      throw UploadException(message: e.toString());
    }
  }

  @override
  Future<AnswerSheet> uploadAnswerkey(File file, String name) async {
    try {
      final Uuid uuid = Uuid();
      final DateFormat dateFormat = DateFormat.yMMMMd();
      final String folderName = dateFormat.format(DateTime.now());
      final String id = uuid.v4();
      final Reference reference =
          firebaseStorage.ref().child('answer_key_uploads/$folderName/$id');
      final UploadTask uploadTask = reference.putFile(file);
      final TaskSnapshot storageTaskSnapshot = uploadTask.snapshot;
      return storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) async {
        return AnswerSheet(url: downloadUrl, name: name, id: id);
      }, onError: (err) {
        throw UploadException(message: err.toString());
      });
    } catch (e) {
      throw UploadException(message: e.toString());
    }
  }
}
