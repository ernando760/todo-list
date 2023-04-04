// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/widgets/tasks/controllers/tasks_controller.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    super.key,
  });

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TasksController>(context);
    return SizedBox(
      height: 400,
      child: ListView.builder(
        itemCount: taskController.tasks.length,
        itemBuilder: (context, index) {
          final task = taskController.tasks[index];
          print(taskController.tasks);
          if (taskController.tasks.isEmpty) {
            const Center(
              child: Text("task is empty"),
            );
          }
          return ListTile(
            trailing: Checkbox(
                value: task.isSelected,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      task.setSelected = value;
                      print(value);
                    });
                  }
                }),
            title: Text(task.title),
            subtitle: Text(task.description),
            onTap: () {
              print(task);
            },
          );
        },
      ),
    );
  }
}
