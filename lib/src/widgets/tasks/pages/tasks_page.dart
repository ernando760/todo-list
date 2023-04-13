// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/widgets/tasks/components/form_task.dart';
import 'package:todo_list/src/widgets/tasks/components/tasks_list_checked.dart';

import '../components/tasks_list.dart';
import '../controllers/tasks_controller.dart';

class TasksPage extends StatefulWidget {
  const TasksPage(
      {super.key,
      required this.title,
      required this.indexTasks,
      this.onTasksSelected});
  final String title;
  final int indexTasks;
  final void Function(int index)? onTasksSelected;

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late final TasksController _tasksController;
  Future<void> _showFormTask() async {
    return showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(title: Text("Add task"), content: FormTask()));
  }

  @override
  void initState() {
    _tasksController = context.read<TasksController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("init state");
      _tasksController.getAllTasks();
    });
    super.initState();
  }

  @override
  void dispose() {
    print("dispose");
    _tasksController.dispose();
    super.dispose();
  }

  Widget _tasksListSelected({required int index}) {
    const widgetTasks = [
      TasksList(),
      TasksListChecked(),
    ];

    return widgetTasks[index];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _tasksController,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [_tasksListSelected(index: widget.indexTasks)],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _showFormTask,
              child: const Icon(Icons.add),
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: widget.indexTasks,
                onTap: widget.onTasksSelected,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.task), label: "tasks"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.done), label: "tasks done"),
                ]),
          );
        });
  }
}
