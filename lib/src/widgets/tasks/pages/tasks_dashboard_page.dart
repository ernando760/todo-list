// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/widgets/tasks/components/list_tasks_stream.dart';

import 'package:todo_list/src/widgets/tasks/pages/task_page.dart';

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

  void _addTask() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TaskPage(addTask: _tasksController.addTask),
    ));
  }

  @override
  void initState() {
    super.initState();
    _tasksController = context.read<TasksController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tasksController.getAllTasksStream();
    });
  }

  @override
  void dispose() {
    print("dispose");
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
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        bottom: 15, top: 15, left: 8.0, right: 8.0),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: const BoxDecoration(),
                    child: Text(
                      _tasksController.indexSelected == 0
                          ? "Tasks"
                          : "Tasks done",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 42,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (index) {
                        _tasksController.onIndexSelected(index);
                        pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                      children: [
                        _tasksController.isLoaded
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListTasksStream(
                                tasksController: _tasksController,
                                isSelected: false),
                        ListTasksStream(
                            tasksController: _tasksController,
                            isSelected: true),
                        // TasksCheckedPage()
                      ],
                    ),
                  ),
                ],
              ),
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
              onPressed: _addTask,
              child: const Icon(Icons.task_alt),
            ),
          );
        });
  }
}
