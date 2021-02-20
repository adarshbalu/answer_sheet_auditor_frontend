class ServerException implements Exception {}

class AuthException implements Exception {
  AuthException({this.message = 'Some unknown error occurred'});
  final String message;
}
