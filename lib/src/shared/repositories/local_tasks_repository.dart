// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';
import 'package:uuid/uuid.dart';

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
    const uuid = Uuid();
    final task =
        TaskModel(id: uuid.v4(), title: title, description: description);
    await taskBox.add(task);
  }

  @override
  TaskModel getTask({required String id}) {
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
  Future<void> removeTask({required String id}) async {
    final taskBox = Hive.box<TaskModel>("tasks");
    _tasks = getAllTasks();

    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) {
      removeTaskChecked(id: id);
      return;
    }

    await taskBox.deleteAt(index);
  }

  @override
  Future<void> updateTask(String id,
      {String? title, String? description, bool? selected = false}) async {
    _tasks = getAllTasks();
    final taskBox = Hive.box<TaskModel>("tasks");
    var index = _tasks.indexWhere((task) => task.id == id);
    print(index);
    if (index == -1) {
      _updateTaskChecked(id,
          title: title, description: description, selected: selected);
      return;
    }

    final taskUpdated = _tasks[index].copyWith(
        id: id, title: title, description: description, isSelected: selected);
    await taskBox.putAt(index, taskUpdated);
  }

  //////////// task checked //////////////

  Future<void> _updateTaskChecked(String id,
      {String? title, String? description, bool? selected = false}) async {
    final taskBox = Hive.box<TaskModel>("tasks complete");
    _tasksChecked = getAllTasksChecked();
    final index = _tasksChecked.indexWhere((task) => task.id == id);
    final taskUpdated = _tasksChecked[index].copyWith(
        id: id, title: title, description: description, isSelected: selected);
    await taskBox.putAt(index, taskUpdated);
  }

  @override
  Future<void> addTaskChecked({
    required TaskModel task,
  }) async {
    final taskBoxCompleted = Hive.box<TaskModel>("tasks complete");
    await taskBoxCompleted.add(task);
  }

  @override
  List<TaskModel> getAllTasksChecked() {
    final taskBox = Hive.box<TaskModel>("tasks complete");
    _tasksChecked = taskBox.values.map((task) => task).toList();
    return _tasksChecked;
  }

  @override
  Future<void> removeTaskChecked({required String id}) async {
    final taskBox = Hive.box<TaskModel>("tasks complete");
    _tasksChecked = getAllTasksChecked();

    final index = _tasksChecked.indexWhere((task) => task.id == id);
    await taskBox.deleteAt(index);
  }
}
