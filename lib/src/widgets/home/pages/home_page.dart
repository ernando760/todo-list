import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/widgets/tasks/controllers/tasks_controller.dart';

import '../../tasks/components/form_task.dart';
import '../../tasks/pages/tasks_page.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _homeController;
  late final TasksController _tasksController;

  Future<void> _showFormTask() async {
    return showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(title: Text("Add task"), content: FormTask()));
  }

  @override
  void initState() {
    _homeController = context.read<HomeController>();
    _tasksController = context.read<TasksController>();
    super.initState();
  }

  @override
  void dispose() {
    _homeController.dispose();
    _tasksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _homeController,
        builder: (context, child) {
          final pageController =
              PageController(initialPage: _homeController.indexSelected);
          return AnimatedBuilder(
              animation: _tasksController,
              builder: (context, child) {
                return Scaffold(
                  body: PageView(
                    onPageChanged: (index) =>
                        _homeController.onIndexSelected(index),
                    controller: pageController,
                    children: [
                      TasksPage(title: "tasks", tasks: _tasksController.tasks),
                      TasksPage(
                          title: "tasks done",
                          tasks: _tasksController.tasksChecked),
                      // TasksCheckedPage()
                    ],
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                      currentIndex: _homeController.indexSelected,
                      onTap: (index) {
                        _homeController.onIndexSelected(index);
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
