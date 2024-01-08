import 'package:flutter/material.dart';

class Task {
  final String _id = UniqueKey().toString();
  final String _description;
  final bool _isDone;

  Task(this._description, this._isDone);

  String get id => _id;
  String get description => _description;
  bool get isDone => _isDone;
}
