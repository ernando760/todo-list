// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/widgets/tasks/controllers/tasks_controller.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  late final TasksController _taskController;
  @override
  void initState() {
    _taskController = context.read<TasksController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _taskController.tasks,
      builder: (context, tasks, child) => SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            if (tasks.isEmpty) {
              const Center(
                child: Text("task is empty"),
              );
            }
            return ListTile(
              trailing: Checkbox(
                  value: task.isSelected,
                  onChanged: (value) {
                    setState(() {
                      task.setSelected = !value!;
                    });
                  }),
              title: Text(task.title),
              subtitle: Text(task.description),
              onTap: () {
                print(task);
              },
            );
          },
        ),
      ),
    );
  }
}
