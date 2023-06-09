import 'package:flutter/material.dart';
import 'package:todo_list/src/widgets/tasks/pages/tasks_dashboard_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "todo list",
      home: TasksDashboardPage(),
    );
  }
}
