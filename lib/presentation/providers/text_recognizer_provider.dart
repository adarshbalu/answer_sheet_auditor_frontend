import 'package:answer_sheet_auditor/domain/usecases/text_recognition/get_vision_image_from_file.dart';
import 'package:flutter/cupertino.dart';

class TextRecognizerProvider extends ChangeNotifier {
  TextRecognizerProvider(this.getVisionImageFromFile);
  final GetVisionImageFromFile getVisionImageFromFile;
}
