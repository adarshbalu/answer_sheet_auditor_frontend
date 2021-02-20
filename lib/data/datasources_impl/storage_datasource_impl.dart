import 'dart:io';

import 'package:answer_sheet_auditor/core/error/exceptions.dart';
import 'package:answer_sheet_auditor/data/datasources/storage_datasource.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class StorageRemoteDataSourceImpl extends StorageRemoteDataSource {
  StorageRemoteDataSourceImpl(this.firebaseStorage);
  final FirebaseStorage firebaseStorage;

  @override
  Future<String> uploadFile(File file) async {
    try {
      final Uuid uuid = Uuid();
      final DateFormat dateFormat = DateFormat.yMMMMd();
      final String folderName = dateFormat.format(DateTime.now());
      final Reference reference = firebaseStorage
          .ref()
          .child('answer_sheet_uploads/$folderName/${uuid.v4()}');
      final UploadTask uploadTask = reference.putFile(file);
      final TaskSnapshot storageTaskSnapshot = uploadTask.snapshot;
      return storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) async {
        return downloadUrl;
      }, onError: (err) {
        throw UploadException(message: err.toString());
      });
    } catch (e) {
      throw UploadException(message: e.toString());
    }
  }
}
