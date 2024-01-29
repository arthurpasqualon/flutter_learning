import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:learn_app/model/imc_result_model.dart';
import 'package:learn_app/model/profile_model.dart';
import 'package:learn_app/model/task_model.dart';
import 'package:learn_app/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  var docsDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(docsDir.path);
  Hive.registerAdapter(ProfileModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(ImcResultModelAdapter());
  runApp(const MyApp());
}
