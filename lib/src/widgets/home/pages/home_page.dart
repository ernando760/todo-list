import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../tasks/pages/tasks_page.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController pageController;
  late final HomeController homeController;
  @override
  void initState() {
    homeController = context.read<HomeController>();
    pageController = PageController(initialPage: homeController.indexSelected);

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: homeController,
        builder: (context, child) {
          return PageView(
            onPageChanged: (index) => homeController.onIndexSelected(index),
            controller: pageController,
            children: [
              TasksPage(
                title: "tasks",
                indexTasks: homeController.indexSelected,
                onTasksSelected: homeController.onIndexSelected,
              ),
              TasksPage(
                title: "tasks done",
                indexTasks: homeController.indexSelected,
                onTasksSelected: homeController.onIndexSelected,
              ),
            ],
          );
        });
  }
}
