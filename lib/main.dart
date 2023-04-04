import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app_widget.dart';
import 'package:todo_list/src/shared/providers/app_provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: AppProvider.providers,
    child: const AppWidget(),
  ));
}
