// ignore_for_file: avoid_print, library_prefixes

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart' as provider;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/app_widget.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/providers/app_provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

Future<void> initHive() async {
  final applicationDocumentDir =
      await pathProvider.getApplicationDocumentsDirectory();
  print("path: ${applicationDocumentDir.path}");

  await Hive.initFlutter(applicationDocumentDir.path);

  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  await Hive.openBox<TaskModel>("tasks");
  await Hive.openBox<TaskModel>("tasks complete");
}

Future<void> initSupabase() async {
  const PROJECT_URL = String.fromEnvironment("PROJECT_URL");
  const ANON_KEY = String.fromEnvironment("ANON_KEY");

  await Supabase.initialize(url: PROJECT_URL, anonKey: ANON_KEY);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  provider.Provider.debugCheckInvalidValueType = null;
  await initHive();
  runApp(provider.MultiProvider(
    providers: AppProvider.providers,
    child: const AppWidget(),
  ));
}
