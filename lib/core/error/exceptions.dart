class ServerException implements Exception {}

class AuthException implements Exception {
  AuthException({this.message = 'Some unknown error occurred'});
  final String message;
}

class UploadException implements Exception {
  UploadException({this.message = 'Some unknown error occurred'});
  final String message;
}

class CacheException implements Exception {
  CacheException({this.message = 'Some unknown error occurred'});
  final String message;
}

class VisionImageException implements Exception {
  VisionImageException({this.message = 'Some unknown error occurred'});
  final String message;
}

class FilePickerException implements Exception {
  FilePickerException({this.message = 'Some unknown error occurred'});
  final String message;
}
