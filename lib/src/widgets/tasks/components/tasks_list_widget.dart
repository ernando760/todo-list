// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_list/src/shared/model/task_model.dart';

class TasksList extends StatelessWidget {
  const TasksList(
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
                          onChanged: (isSelected) => onSelectedTask(
                              isSelected: isSelected, id: task.id!)),
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      onTap: () => navigateToTaskPage(id: task.id!),
                      onLongPress: () => onDeleteTask(id: task.id!),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
