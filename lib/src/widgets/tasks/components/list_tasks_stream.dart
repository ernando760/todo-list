// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo_list/src/widgets/tasks/components/tasks_list_widget.dart';

import '../../../shared/model/task_model.dart';

class ListTasksStream extends StatelessWidget {
  const ListTasksStream({
    Key? key,
    required this.tasksStream,
    required this.isSelected,
    required this.updateTask,
    required this.onSelectedTask,
    required this.onRemoveTask,
  }) : super(key: key);
  final Stream<List<TaskModel>> tasksStream;
  final bool isSelected;
  final void Function({required String id}) updateTask;
  final void Function({required String id, required bool? isSelected})
      onSelectedTask;
  final void Function({required String id}) onRemoveTask;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: tasksStream
          .map((event) =>
              event.where((task) => task.isSelected == isSelected).toList())
          .distinct(),
      builder: (context, snapshot) => !snapshot.hasData
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : TasksListWidget(
              title: "tasks",
              tasks: snapshot.data ?? [],
              onDeleteTask: onRemoveTask,
              onSelectedTask: onSelectedTask,
              updateTask: updateTask,
            ),
    );
  }
}
