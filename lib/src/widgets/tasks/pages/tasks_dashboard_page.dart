// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_list/src/widgets/tasks/pages/task_page.dart';

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

  void _addTask() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TaskPage(addTask: _tasksController.addTask),
    ));
  }

  _updateTask({required String id}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskPage(
            id: id,
            updateTask: _tasksController.updateTask,
          ),
        ));
  }

  @override
  void initState() {
    _tasksController = context.read<TasksController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tasksController.getAllTasksStream();
    });

    super.initState();
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
          final tasks = _tasksController.tasksStream.asBroadcastStream();
          final pageController =
              PageController(initialPage: _tasksController.indexSelected);
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        bottom: 15, top: 15, left: 8.0, right: 8.0),
                    width: MediaQuery.of(context).size.width,
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
                            : StreamBuilder(
                                stream: tasks
                                    .map((event) => event
                                        .where(
                                            (task) => task.isSelected == false)
                                        .toList())
                                    .distinct(),
                                builder: (context, snapshot) =>
                                    !snapshot.hasData
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : TasksListWidget(
                                            title: "tasks",
                                            tasks: snapshot.data ?? [],
                                            onDeleteTask:
                                                _tasksController.removeTask,
                                            onSelectedTask: _tasksController
                                                .handleSelectedTask,
                                            updateTask: _updateTask,
                                          ),
                              ),
                        StreamBuilder(
                          stream: tasks
                              .map((event) => event
                                  .where((task) => task.isSelected == true)
                                  .toList())
                              .distinct(),
                          builder: (context, snapshot) => !snapshot.hasData
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : TasksListWidget(
                                  title: "tasks done",
                                  tasks: snapshot.data ?? [],
                                  onDeleteTask: _tasksController.removeTask,
                                  onSelectedTask:
                                      _tasksController.handleSelectedTask,
                                  updateTask: _updateTask,
                                ),
                        ),

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
