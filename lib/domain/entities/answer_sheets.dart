import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AnswerSheet extends Equatable {
  const AnswerSheet(
      {@required this.url, @required this.name, @required this.id});
  final String url;
  final String name;
  final String id;
  @override
  List<Object> get props => <Object>[url, name, id];
}
