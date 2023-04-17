// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/widgets/tasks/controllers/tasks_controller.dart';
import 'package:todo_list/src/widgets/tasks/pages/task_page.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key, required this.tasks});
  final List<TaskModel> tasks;
  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  final heightList = 500.0;
  _deleteTask({required int? id}) {
    final taskController = context.read<TasksController>();
    const snackBar = SnackBar(content: Text("task deleted"));
    if (id != null) {
      taskController.removeTask(id: id);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  _isSelected(bool value, int index) {
    final taskContoller = context.read<TasksController>();
    taskContoller.isSelected(value, index);
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 10, top: 8.0, left: 8.0, right: 8.0),
      child: SizedBox(
        height: heightList,
        child: ListView.builder(
          itemCount: widget.tasks.length,
          itemBuilder: (context, index) {
            final task = widget.tasks[index];
            if (widget.tasks.isEmpty) {
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
                    onChanged: (isSelected) =>
                        _isSelected(isSelected!, task.id!)),
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
