import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  User({
    @required this.id,
    @required this.userName,
    @required this.email,
  })  : assert(id != null),
        assert(userName != null && userName.isNotEmpty),
        assert(email != null && email.isNotEmpty);
  final String id;
  final String userName;

  final String email;

  @override
  List<Object> get props => <Object>[
        id,
        email,
        userName,
      ];
}
