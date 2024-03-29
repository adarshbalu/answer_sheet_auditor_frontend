import 'dart:io';

import 'package:answer_sheet_auditor/core/error/exceptions.dart';
import 'package:answer_sheet_auditor/data/datasources/file_datasource.dart';
import 'package:file_picker/file_picker.dart';

class FileDataSourceImpl extends FileDataSource {
  @override
  Future<File> getImageFromStorage() async {
    try {
      final FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
        ],
      );
      if (result != null) {
        final File file = File(result.files.single.path);
        return file;
      } else {
        throw FilePickerException();
      }
    } catch (e) {
      throw FilePickerException();
    }
  }

  @override
  Future<File> getTextFromStorage() async {
    try {
      final FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'json',
        ],
      );
      if (result != null) {
        final File file = File(result.files.single.path);
        return file;
      } else {
        throw FilePickerException();
      }
    } catch (e) {
      throw FilePickerException();
    }
  }
}
