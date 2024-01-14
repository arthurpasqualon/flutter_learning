import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:learn_app/model/profile_model.dart';
import 'package:learn_app/model/task_model.dart';
import 'package:learn_app/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var docsDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(docsDir.path);
  Hive.registerAdapter(ProfileModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  runApp(const MyApp());
}
