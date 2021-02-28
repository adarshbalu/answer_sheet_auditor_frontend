import 'dart:io';

import 'package:answer_sheet_auditor/core/usecase/usecase.dart';
import 'package:answer_sheet_auditor/domain/usecases/text_recognition/get_vision_image_from_file.dart';
import 'package:answer_sheet_auditor/domain/usecases/text_recognition/get_vision_text_from_vision_image.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';

class TextRecognizerProvider extends ChangeNotifier {
  TextRecognizerProvider(
      this.getVisionImageFromFile, this.getVisionTextFromVisionImage);
  final GetVisionImageFromFile getVisionImageFromFile;
  final GetVisionTextFromVisionImage getVisionTextFromVisionImage;

  VisionText _visionText;

  VisionText get visionText => _visionText;

  FirebaseVisionImage _firebaseVisionImage;

  FirebaseVisionImage get firebaseVisionImage => _firebaseVisionImage;

  Future<void> getVisionImage(File file) async {
    _visionImageFromFileStatus = VisionImageFromFileStatus.LOADING;
    notifyListeners();
    final failureOrVisionImage =
        await getVisionImageFromFile(Params(file: file));
    failureOrVisionImage.fold((failure) {
      _visionImageFromFileStatus = VisionImageFromFileStatus.ERROR;
      notifyListeners();
    }, (visionImage) {
      _firebaseVisionImage = visionImage;
      _visionImageFromFileStatus = VisionImageFromFileStatus.LOADED;
      notifyListeners();
    });
  }

  Future<void> getVisionText() async {
    _visionTextFromVisionImageStatus = VisionTextFromVisionImageStatus.LOADING;
    notifyListeners();
    final failureOrVisionText = await getVisionTextFromVisionImage(
        Params(visionImage: _firebaseVisionImage));
    failureOrVisionText.fold((failure) {
      _visionTextFromVisionImageStatus = VisionTextFromVisionImageStatus.ERROR;
      notifyListeners();
    }, (extractedText) {
      _visionText = extractedText;
      _visionTextFromVisionImageStatus = VisionTextFromVisionImageStatus.LOADED;
      notifyListeners();
      getTextFromVisionText();
    });
  }

  void getTextFromVisionText() {
    final String text = _visionText.text;
    print(text);
    for (final TextBlock block in _visionText.blocks) {
      // final Rect boundingBox = block.boundingBox;
      // final List<Offset> cornerPoints = block.cornerPoints;
      // final String text = block.text;
      // final List<RecognizedLanguage> languages = block.recognizedLanguages;

      for (final TextLine line in block.lines) {
        for (final TextElement element in line.elements) {
          print(element.text);
        }
      }
    }
  }

  VisionImageFromFileStatus _visionImageFromFileStatus;
  VisionTextFromVisionImageStatus _visionTextFromVisionImageStatus;

  VisionImageFromFileStatus get visionImageFromFileStatus =>
      _visionImageFromFileStatus;

  VisionTextFromVisionImageStatus get visionTextFromVisionImageStatus =>
      _visionTextFromVisionImageStatus;
}

enum VisionImageFromFileStatus { NONE, ERROR, LOADING, LOADED }
enum VisionTextFromVisionImageStatus { NONE, ERROR, LOADING, LOADED }
