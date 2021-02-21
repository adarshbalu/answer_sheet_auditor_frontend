import 'dart:io';

abstract class FileDataSource {
  Future<File> getImageFromStorage();
  Future<File> getTextFromStorage();
}
