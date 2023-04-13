import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/tasks_controller.dart';
import '../pages/task_page.dart';

class TasksListChecked extends StatefulWidget {
  const TasksListChecked({super.key});

  @override
  State<TasksListChecked> createState() => _TasksListCheckedState();
}

class _TasksListCheckedState extends State<TasksListChecked> {
  final heightList = 500.0;
  _deleteTask({required int? id}) {
    final taskController = context.read<TasksController>();
    const snackBar = SnackBar(content: Text("task deleted"));
    if (id != null) {
      taskController.removeTaskChecked(id: id);
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

  @override
  Widget build(BuildContext context) {
    final tasksController = context.watch<TasksController>();
    return AnimatedBuilder(
      animation: tasksController,
      builder: (context, child) => Padding(
        padding:
            const EdgeInsets.only(bottom: 10, top: 8.0, left: 8.0, right: 8.0),
        child: SizedBox(
          height: heightList,
          child: ListView.builder(
            itemCount: tasksController.tasksChecked.length,
            itemBuilder: (context, index) {
              final task = tasksController.tasksChecked[index];
              if (tasksController.tasksChecked.isEmpty) {
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
                          tasksController.isSelected(value, task.id!)),
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
      ),
    );
  }
}
