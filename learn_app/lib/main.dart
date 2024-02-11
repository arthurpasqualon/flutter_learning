import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:learn_app/model/imc_result_model.dart';
import 'package:learn_app/model/profile_model.dart';
import 'package:learn_app/model/task_model.dart';
import 'package:learn_app/my_app.dart';
import 'package:learn_app/repositories/jsonplaceholder_dio.dart';
import 'package:learn_app/repositories/post_comments_repository.dart';
import 'package:learn_app/repositories/posts_repository.dart';
import 'package:learn_app/store/counter_mobx_store.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<CounterMobxStore>(CounterMobxStore());
  getIt.registerSingleton<JsonPlaceholderDio>(JsonPlaceholderDio());
  getIt.registerSingleton<PostsRepository>(
      PostsRepository(getIt<JsonPlaceholderDio>()));
  getIt.registerSingleton<PostCommentsRepository>(
      PostCommentsRepository(getIt<JsonPlaceholderDio>()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupGetIt();
  var docsDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(docsDir.path);
  Hive.registerAdapter(ProfileModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(ImcResultModelAdapter());
  runApp(const MyApp());
}
