// ignore_for_file: avoid_print

import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class TodoRepository extends RepositoryInterface {
  final List<TaskModel> _tasks = [];
  @override
  Future<void> addTask(
      {required String title, required String description}) async {
    final task = TaskModel(
        id: _tasks.length + 1, title: title, description: description);
    _tasks.add(task);
    print(task);
  }

  @override
  Future<void> removeTask({required int id}) async {
    _tasks.removeWhere((element) => element.id == id);
  }

  @override
  Future<void> updateTask(int id,
      {String? title, String? description, bool? selected}) async {
    final taskId = _tasks.indexWhere((element) => element.id == id);
    final taskUpdated = _tasks
        .map((task) => task.id == _tasks[taskId].id
            ? task.copyWith(
                id: id,
                title: title,
                description: description,
                isSelected: selected)
            : task)
        .toList();

    _tasks.addAll(taskUpdated);
  }

  @override
  List<TaskModel> getAllTasks() {
    return _tasks;
  }

  @override
  TaskModel getTask({required int id}) {
    final taskId = _tasks.indexWhere((element) => element.id == id);
    print("get task: ${_tasks[taskId]}");
    return _tasks[taskId];
  }

  @override
  Future<void> addTaskChecked({required TaskModel task}) {
    // TODO: implement addTaskChecked
    throw UnimplementedError();
  }

  @override
  List<TaskModel> getAllTasksChecked() {
    // TODO: implement getAllTasksChecked
    throw UnimplementedError();
  }

  @override
  Future<void> removeTaskChecked({required TaskModel taskRemove}) {
    // TODO: implement removeTaskChecked
    throw UnimplementedError();
  }
}
