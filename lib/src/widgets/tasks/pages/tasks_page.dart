import 'package:flutter/material.dart';
import 'package:todo_list/src/widgets/tasks/components/form_task.dart';

import '../components/tasks_list.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  Future<void> _showFormTask() async {
    return showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("add task"),
        content: FormTask(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: Column(
        children: const [
          TasksList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFormTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
