import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';

abstract class MLKitDataSource {
  Future<FirebaseVisionImage> getVisionImageFromFile(File file);
  Future<VisionText> getTextFromVisionImage(FirebaseVisionImage visionImage);
  void dispose();
}
