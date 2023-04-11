// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/widgets/tasks/controllers/tasks_controller.dart';
import 'package:todo_list/src/widgets/tasks/pages/task_page.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    super.key,
  });

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  late final TasksController _tasksController;
  final heightList = 600.0;
  _deleteTask({required int? id}) {
    final taskController = context.read<TasksController>();
    if (id != null) {
      taskController.removeTask(id: id);
      Navigator.pop(context);
    }
  }

  _showDeleteTask({required int? id}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Do you want to remove the task?"),
          content: Row(
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("cancel")),
              ElevatedButton(
                  onPressed: () => _deleteTask(id: id),
                  child: const Text("remove")),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _tasksController = context.read<TasksController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tasksController.getAllTask();
    });
    super.initState();
  }

  @override
  void dispose() {
    _tasksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _tasksController,
      builder: (context, child) => SizedBox(
        height: heightList,
        child: ListView.builder(
          itemCount: _tasksController.tasks.length,
          itemBuilder: (context, index) {
            final task = _tasksController.tasks[index];
            if (_tasksController.tasks.isEmpty) {
              return const Center(
                child: Text("task is empty"),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, bottom: 6.0, top: 8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2),
                    borderRadius: BorderRadius.circular(20)),
                tileColor: Colors.white24,
                leading: Checkbox(
                    value: task.isSelected,
                    onChanged: (value) =>
                        _tasksController.isSelected(value, task.id!)),
                title: Text(task.title),
                subtitle: Text(task.description),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskPage(id: task.id),
                      ));
                },
                onLongPress: () => _showDeleteTask(id: task.id),
              ),
            );
          },
        ),
      ),
    );
  }
}
