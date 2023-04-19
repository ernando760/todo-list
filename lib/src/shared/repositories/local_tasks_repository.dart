// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class LocalTasksRepository extends RepositoryInterface {
  List<TaskModel> _tasks = [];
  List<TaskModel> _tasksChecked = [];

  @override
  List<TaskModel> getAllTasks() {
    final taskBox = Hive.box<TaskModel>("tasks");
    _tasks = taskBox.values.map((task) => task).toList();
    ("tasks:$_tasks");
    return _tasks;
  }

  @override
  Future<void> addTask(
      {required String title, required String description}) async {
    _tasks = getAllTasks();
    final taskBox = Hive.box<TaskModel>("tasks");
    await taskBox.add(TaskModel(
        id: _tasks.length + 1, title: title, description: description));
  }

  @override
  TaskModel getTask({required int id}) {
    _tasks = getAllTasks();

    var taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex == -1) {
      _tasksChecked = getAllTasksChecked();
      taskIndex = _tasksChecked.indexWhere((task) => task.id == id);
      return _tasksChecked[taskIndex];
    }

    return _tasks[taskIndex];
  }

  @override
  Future<void> removeTask({required int id}) async {
    final taskBox = Hive.box<TaskModel>("tasks");
    _tasks = getAllTasks();

    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) {
      final task = _tasksChecked.firstWhere((task) => task.id == id);
      _removeTaskChecked(taskRemove: task);
      return;
    }
    await taskBox.deleteAt(index);
  }

  @override
  Future<void> updateTask(int id,
      {String? title, String? description, bool? selected = false}) async {
    _tasks = getAllTasks();
    final taskBox = Hive.box<TaskModel>("tasks");

    var index = _tasks.indexWhere((task) => task.id == id);
    print(index);
    // if (index == -1) {
    //   await _updateTaskChecked(id,
    //       title: title, description: description, selected: selected);
    //   return;
    // }
    final task = _tasks.firstWhere(
      (task) => task.id == id,
    );
    final taskUpdated = task.copyWith(
        id: id, title: title, description: description, isSelected: selected);
    await taskBox.putAt(index, taskUpdated);
  }

  //////////// task checked //////////////

  // Future<void> _updateTaskChecked(int id,
  //     {String? title, String? description, bool? selected = false}) async {
  //   final taskBox = Hive.box<TaskModel>("tasks complete");
  //   _tasksChecked = getAllTasksChecked();
  //   final index = _tasksChecked.indexWhere((task) => task.id == id);
  //   print(index);
  //   final task = _tasksChecked.firstWhere(
  //     (task) => task.id == id,
  //   );
  //   final taskUpdated = task.copyWith(
  //       id: id, title: title, description: description, isSelected: selected);
  //   await taskBox.putAt(index, taskUpdated);
  // }

  @override
  Future<void> addTaskChecked({
    required TaskModel task,
  }) async {
    final taskBoxCompleted = Hive.box<TaskModel>("tasks complete");
    await taskBoxCompleted.add(task);
    await removeTask(id: task.id ?? 0);
  }

  @override
  List<TaskModel> getAllTasksChecked() {
    final taskBox = Hive.box<TaskModel>("tasks complete");
    _tasksChecked = taskBox.values.map((task) => task).toList();
    return _tasksChecked;
  }

  Future<void> _removeTaskChecked({required TaskModel taskRemove}) async {
    final taskBox = Hive.box<TaskModel>("tasks complete");
    _tasksChecked = getAllTasksChecked();

    final index = _tasksChecked.indexWhere((task) => task.id == taskRemove.id);
    await taskBox.deleteAt(index);
  }
}
