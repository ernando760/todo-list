import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';
import 'package:todo_list/src/shared/repositories/tasks_repository.dart';
import 'package:todo_list/src/widgets/tasks/controllers/tasks_controller.dart';

class AppProvider {
  static final List<SingleChildWidget> providers = [
    Provider<RepositoryInterface>(
      create: (context) => TasksRepository(),
    ),
    ChangeNotifierProvider(
        create: (context) => TasksController(
            repositoryInterface: context.read<RepositoryInterface>()))
  ];
}
