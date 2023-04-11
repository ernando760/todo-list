// ignore_for_file: avoid_print, library_prefixes

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app_widget.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/providers/app_provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  final applicationDocumentDir =
      await pathProvider.getApplicationDocumentsDirectory();
  print("path: ${applicationDocumentDir.path}");

  await Hive.initFlutter(applicationDocumentDir.path);

  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  await Hive.openBox<TaskModel>("tasks");
  runApp(MultiProvider(
    providers: AppProvider.providers,
    child: const AppWidget(),
  ));
}
