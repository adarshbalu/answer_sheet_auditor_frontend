import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => <Object>[];
}

class ServerFailure extends Failure {
  @override
  List<Object> get props => <Object>[];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => <Object>[];
}

class InvalidInputFailure extends Failure {
  @override
  List<Object> get props => <Object>[];
}

class UploadFailure extends Failure {
  @override
  List<Object> get props => <Object>[];
}

class VisionImageFailure extends Failure {
  @override
  List<Object> get props => <Object>[];
}

class VisionTextFailure extends Failure {
  @override
  List<Object> get props => <Object>[];
}

class FilePickerFailure extends Failure {
  @override
  List<Object> get props => <Object>[];
}

class AuthFailure extends Failure {
  AuthFailure({this.message = 'Something went wrong'});
  final String message;

  @override
  List<Object> get props => super.props..addAll(<Object>[message]);
}
