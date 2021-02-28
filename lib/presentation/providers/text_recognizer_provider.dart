import 'package:answer_sheet_auditor/domain/usecases/text_recognition/get_vision_image_from_file.dart';
import 'package:answer_sheet_auditor/domain/usecases/text_recognition/get_vision_text_from_vision_image.dart';
import 'package:flutter/cupertino.dart';

class TextRecognizerProvider extends ChangeNotifier {
  TextRecognizerProvider(
      this.getVisionImageFromFile, this.getVisionTextFromVisionImage);
  final GetVisionImageFromFile getVisionImageFromFile;
  final GetVisionTextFromVisionImage getVisionTextFromVisionImage;
}
