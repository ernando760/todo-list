// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_list/src/widgets/tasks/pages/task_page.dart';

import '../components/form_task.dart';
import '../components/tasks_list_widget.dart';
import '../controllers/tasks_controller.dart';

class TasksDashboardPage extends StatefulWidget {
  const TasksDashboardPage({
    super.key,
  });

  @override
  State<TasksDashboardPage> createState() => _TasksDashboardPageState();
}

class _TasksDashboardPageState extends State<TasksDashboardPage> {
  late final TasksController _tasksController;

  Future<void> _showFormTask() async {
    return showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(title: Text("Add task"), content: FormTask()));
  }

  _navigateToTaskPage({required int id}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskPage(id: id),
        ));
  }

  @override
  void initState() {
    _tasksController = context.read<TasksController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tasksController.getAllTasks();
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
        builder: (context, child) {
          final pageController =
              PageController(initialPage: _tasksController.indexSelected);
          return AnimatedBuilder(
              animation: _tasksController,
              builder: (context, child) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(pageController.initialPage == 0
                        ? "tasks"
                        : "tasks done"),
                  ),
                  body: PageView(
                    onPageChanged: (index) =>
                        _tasksController.onIndexSelected(index),
                    controller: pageController,
                    children: [
                      TasksListWidget(
                        title: "tasks",
                        tasks: _tasksController.tasks,
                        onDeleteTask: _tasksController.removeTask,
                        onSelectedTask: _tasksController.isSelected,
                        navigateToTaskPage: _navigateToTaskPage,
                      ),
                      TasksListWidget(
                        title: "tasks done",
                        tasks: _tasksController.tasksChecked,
                        onDeleteTask: _tasksController.removeTask,
                        onSelectedTask: _tasksController.isSelected,
                        navigateToTaskPage: _navigateToTaskPage,
                      ),
                      // TasksCheckedPage()
                    ],
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                      currentIndex: _tasksController.indexSelected,
                      onTap: (index) {
                        _tasksController.onIndexSelected(index);
                        pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.task), label: "tasks"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.done), label: "tasks done"),
                      ]),
                  floatingActionButton: FloatingActionButton(
                    onPressed: _showFormTask,
                    child: const Icon(Icons.add),
                  ),
                );
              });
        });
  }
}
