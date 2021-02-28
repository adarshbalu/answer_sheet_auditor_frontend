import 'dart:io';

import 'package:answer_sheet_auditor/core/error/exceptions.dart';
import 'package:answer_sheet_auditor/data/datasources/ml_kit_datasource.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class MLKitDataSourceImpl extends MLKitDataSource {
  MLKitDataSourceImpl(this.textRecognizer);
  final TextRecognizer textRecognizer;

  @override
  Future<FirebaseVisionImage> getVisionImageFromFile(File file) async {
    try {
      final FirebaseVisionImage visionImage =
          FirebaseVisionImage.fromFile(file);
      if (visionImage != null) {
        return visionImage;
      } else {
        throw VisionImageException();
      }
    } catch (e) {
      throw VisionImageException();
    }
  }
}
