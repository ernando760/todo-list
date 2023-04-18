// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/widgets/tasks/components/form_update_task.dart';
import 'package:todo_list/src/widgets/tasks/controllers/tasks_controller.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.id}) : assert(id != null);
  final int? id;
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final TasksController _tasksController;
  Future<void> _showFormTask() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update task"),
        content: FormUpdateTask(
          id: widget.id!,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tasksController = Provider.of<TasksController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("init state");
      _tasksController.getTask(id: widget.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: _tasksController,
          builder: (context, child) =>
              Text(_tasksController.task?.title ?? "title"),
        ),
      ),
      body: SizedBox(
        child: AnimatedBuilder(
          animation: _tasksController,
          builder: (context, child) =>
              Text(_tasksController.task?.description ?? "description"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFormTask,
        child: const Icon(Icons.update),
      ),
    );
  }
}
