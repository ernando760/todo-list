// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/widgets/tasks/pages/task_page.dart';

import '../components/tasks_list.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({
    super.key,
    required this.tasks,
    required this.title,
    required this.onDeleteTask,
    required this.onSelectedTask,
  });
  final String title;
  final List<TaskModel> tasks;
  final void Function({required int id}) onDeleteTask;
  final void Function({required bool? isSelected, required int id})
      onSelectedTask;

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  _isSelected({required bool? isSelected, required int id}) {
    widget.onSelectedTask(isSelected: isSelected, id: id);
  }

  _deleteTask({required int? id}) {
    const snackBar = SnackBar(content: Text("task deleted"));
    if (id != null) {
      widget.onDeleteTask(id: id);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  _showDeleteTask({required int? id}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Do you want to remove the task?"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () => _deleteTask(id: id),
                  child: const Text("remove")),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("cancel")),
            ],
          ),
        );
      },
    );
  }

  _navigateToTaskPage({required int id}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskPage(id: id),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: TasksList(
        tasks: widget.tasks,
        title: widget.title,
        onDeleteTask: _showDeleteTask,
        onSelectedTask: _isSelected,
        navigateToTaskPage: _navigateToTaskPage,
      )),
    );
  }
}
