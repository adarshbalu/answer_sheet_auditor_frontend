import 'package:answer_sheet_auditor/domain/entities/user.dart';
import 'package:meta/meta.dart';

class UserModel extends User {
  UserModel({
    @required this.id,
    @required this.userName,
    @required this.email,
  }) : super(
          email: email,
          id: id,
          userName: userName,
        );
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        userName: json['user_name'] as String,
        email: json['email'] as String,
      );

  final String id, userName, email;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'user_name': userName,
    };
  }
}
