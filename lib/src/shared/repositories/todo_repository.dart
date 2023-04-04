import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class TodoRepository extends RepositoryInterface {
  final List<TaskModel> _tasks = [];
  @override
  List<TaskModel> addTask(
      {required String title, required String description}) {
    final task = TaskModel(
        id: _tasks.length + 1, title: title, description: description);
    _tasks.add(task);
    return _tasks;
  }

  @override
  List<TaskModel> removeTask({required int id}) {
    _tasks.removeWhere((element) => element.id == id);
    return _tasks;
  }

  @override
  List<TaskModel> updateTask(int id, {String? title, String? description}) {
    final taskUpdated = _tasks
        .map((element) => element.id == id
            ? element.copyWith(title: title, description: description)
            : element)
        .toList();
    return taskUpdated;
  }

  @override
  List<TaskModel> getAllTasks() {
    return _tasks;
  }

  @override
  TaskModel getTask({required int id}) {
    final id = _tasks.indexWhere((element) => element.id == element.id);

    return _tasks[id];
  }
}
