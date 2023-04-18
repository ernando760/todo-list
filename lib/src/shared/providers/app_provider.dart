import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';
import 'package:todo_list/src/shared/repositories/local_tasks_repository.dart';
import 'package:todo_list/src/widgets/home/controllers/home_controller.dart';
import 'package:todo_list/src/widgets/home/pages/home_page.dart';
import 'package:todo_list/src/widgets/tasks/controllers/tasks_controller.dart';

class AppProvider {
  static final List<SingleChildWidget> providers = [
    Provider<RepositoryInterface>(
      create: (context) => LocalTasksRepository(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeController(),
      child: const HomePage(),
    ),
    ChangeNotifierProvider(
        create: (context) => TasksController(
            repositoryInterface: context.read<RepositoryInterface>())),
  ];
}
