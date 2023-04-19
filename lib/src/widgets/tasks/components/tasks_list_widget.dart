// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/widgets/tasks/components/task_list_tile_custom_widget.dart';

class TasksListWidget extends StatelessWidget {
  const TasksListWidget(
      {super.key,
      required this.tasks,
      required this.title,
      required this.onDeleteTask,
      required this.onSelectedTask,
      required this.navigateToTaskPage});
  final String title;
  final List<TaskModel> tasks;
  final void Function({required int id}) onDeleteTask;
  final void Function({required int id}) navigateToTaskPage;
  final void Function({required bool? isSelected, required int id})
      onSelectedTask;
  final heightList = 500.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 10, top: 8.0, left: 8.0, right: 8.0),
      child: SizedBox(
        height: heightList,
        child: tasks.isEmpty
            ? Center(child: Text("$title is empty"))
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskListTileCustomWidget(
                      id: task.id!,
                      title: task.title,
                      description: task.description,
                      selected: task.isSelected,
                      onChangeSelected: onSelectedTask,
                      onDelete: onDeleteTask,
                      navigateTo: navigateToTaskPage);
                },
              ),
      ),
    );
  }
}
