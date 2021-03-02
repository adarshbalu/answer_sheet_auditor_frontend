import 'dart:io';

import 'package:answer_sheet_auditor/core/error/exceptions.dart';
import 'package:answer_sheet_auditor/data/datasources/remote_storage_datasource.dart';
import 'package:answer_sheet_auditor/domain/entities/answer_sheets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class RemoteStorageDataSourceImpl extends RemoteStorageDataSource {
  RemoteStorageDataSourceImpl(this.firebaseStorage);
  final FirebaseStorage firebaseStorage;

  @override
  Future<AnswerSheet> uploadAnswerSheet(
      File file, String name, String uid, String examName) async {
    try {
      final File fileToUpload = File(file.path);
      final Uuid uuid = Uuid();
      final String id = uuid.v4();
      final DateFormat dateFormat = DateFormat.yMMMMd();
      final String timeStamp = dateFormat.format(DateTime.now());

      final String fileName = fileToUpload.path.split('/').last;
      final String extension = path.extension(file.path).toString();
      final SettableMetadata metadata = SettableMetadata(
        // cacheControl: 'max-age=60',
        customMetadata: <String, String>{
          'name': name,
          'id': id,
          'uid': uid,
          'fileName': fileName,
          'examName': examName,
          'timeStamp': timeStamp
        },
      );

      final String folderName = uid;
      final Reference reference = firebaseStorage
          .ref('/answer_sheet_uploads')
          .child(folderName)
          .child(examName)
          .child(name)
          .child('$id$extension');
      AnswerSheet answerSheet;
      final UploadTask uploadTask = reference.putFile(fileToUpload, metadata);
      await uploadTask.whenComplete(() async {
        final String downloadUrl = await reference.getDownloadURL();
        answerSheet = AnswerSheet(url: downloadUrl, name: name, id: id);
      });
      uploadTask.onError((error, stackTrace) {
        throw UploadException(message: error.toString());
      });

      return answerSheet;
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
      final DateFormat dateFormat = DateFormat.yMMMMd();
      final String timeStamp = dateFormat.format(DateTime.now());
      final String fileName = fileToUpload.path.split('/').last;

      final String extension = path.extension(file.path).toString();
      final SettableMetadata metadata = SettableMetadata(
        // cacheControl: 'max-age=60',
        customMetadata: <String, String>{
          'name': name,
          'id': id,
          'uid': uid,
          'fileName': fileName,
          'timeStamp': timeStamp
        },
      );

      final String folderName = uid;

      final Reference reference = firebaseStorage
          .ref('/answer_key_uploads')
          .child(folderName)
          .child(name)
          .child('$id$extension');
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

  @override
  Future<void> deleteAnswerSheet(
      String examName, String studentID, String uid) async {
    try {
      final Reference reference = firebaseStorage
          .ref('/answer_sheet_uploads')
          .child(uid)
          .child(examName)
          .child(studentID);
      return await reference.delete();
    } catch (e) {
      throw ServerException();
    }
  }
}
