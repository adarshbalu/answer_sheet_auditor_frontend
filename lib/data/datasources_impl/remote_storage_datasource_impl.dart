import 'dart:io';

import 'package:answer_sheet_auditor/core/error/exceptions.dart';
import 'package:answer_sheet_auditor/data/datasources/remote_storage_datasource.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class RemoteStorageDataSourceImpl extends RemoteStorageDataSource {
  RemoteStorageDataSourceImpl(this.firebaseStorage);
  final FirebaseStorage firebaseStorage;

  @override
  Future<AnswerSheet> uploadAnswerSheet(
      File file, String name, String uid) async {
    try {
      final SettableMetadata metadata = SettableMetadata(
        // cacheControl: 'max-age=60',
        customMetadata: <String, String>{
          'name': name,
        },
      );
      final Uuid uuid = Uuid();
      final String folderName = uid;
      final String id = uuid.v4();
      final Reference reference =
          firebaseStorage.ref().child('answer_sheet_uploads/$folderName/$id');
      final UploadTask uploadTask = reference.putFile(file, metadata);
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
  Future<String> uploadAnswerkey(File file, String name, String uid) async {
    try {
      final File fileToUpload = File(file.path);
      final Uuid uuid = Uuid();
      final String id = uuid.v4();
      final SettableMetadata metadata = SettableMetadata(
        // cacheControl: 'max-age=60',
        customMetadata: <String, String>{'name': name, 'id': id},
      );

      final String folderName = uid;

      final Reference reference = firebaseStorage
          .ref('/answer_key')
          .child(folderName)
          .child('$name.txt');
      String downloadUrl;
      final UploadTask uploadTask = reference.putFile(fileToUpload, metadata);
      await uploadTask.whenComplete(() async {
        downloadUrl = await reference.getDownloadURL();
      });
      uploadTask.onError((error, stackTrace) {
        throw UploadException(message: error.toString());
      });

      return downloadUrl;
    } catch (e) {
      throw UploadException(message: e.toString());
    }
  }
}
