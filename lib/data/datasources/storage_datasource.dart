import 'dart:io';

abstract class StorageRemoteDataSource {
  Future<String> uploadFile(File file);
}
