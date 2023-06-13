// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo_list/src/widgets/tasks/components/tasks_list_widget.dart';
import 'package:todo_list/src/widgets/tasks/controllers/tasks_controller.dart';

import '../../../shared/model/task_model.dart';
import '../pages/task_page.dart';

class ListTasksStream extends StatefulWidget {
  const ListTasksStream({
    Key? key,
    required this.tasksController,
    required this.isSelected,
  }) : super(key: key);
  final TasksController tasksController;
  final bool isSelected;

  @override
  State<ListTasksStream> createState() => _ListTasksStreamState();
}

class _ListTasksStreamState extends State<ListTasksStream> {
  _updateTask({required String id}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskPage(
            id: id,
            updateTask: widget.tasksController.updateTask,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final Stream<List<TaskModel>> tasksStream =
        widget.tasksController.tasksStream.asBroadcastStream();
    return StreamBuilder(
      stream: tasksStream
          .map((event) => event
              .where((task) => task.isSelected == widget.isSelected)
              .toList())
          .distinct(),
      builder: (context, snapshot) => !snapshot.hasData
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : TasksListWidget(
              title: "tasks",
              tasks: snapshot.data ?? [],
              onDeleteTask: widget.tasksController.removeTask,
              onSelectedTask: widget.tasksController.handleSelectedTask,
              updateTask: _updateTask,
            ),
    );
  }
}
