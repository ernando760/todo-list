// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_list/src/shared/model/task_model.dart';

import '../components/tasks_list.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({
    super.key,
    required this.tasks,
    required this.title,
  });
  final String title;
  final List<TaskModel> tasks;

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: TasksList(
        tasks: widget.tasks,
      )),
    );
  }
}
