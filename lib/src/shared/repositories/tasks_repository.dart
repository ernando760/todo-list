// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class TasksRepository extends RepositoryInterface {
  @override
  Future<void> addTask(
      {required String title, required String description}) async {
    final taskBox = Hive.box<TaskModel>("tasks");
    await taskBox.add(TaskModel(
        id: taskBox.length + 1, title: title, description: description));
  }

  @override
  List<TaskModel> getAllTasks() {
    final taskBox = Hive.box<TaskModel>("tasks");
    var tasks = taskBox.values.map((task) => task).toList();
    ("tasks:$tasks");
    return tasks;
  }

  @override
  TaskModel getTask({required int id}) {
    final tasks = getAllTasks();

    final taskIndex = tasks.indexWhere((task) => task.id == id);

    return tasks[taskIndex];
  }

  @override
  Future<void> removeTask({required int id}) async {
    final taskBox = Hive.box<TaskModel>("tasks");
    final tasks = getAllTasks();

    final index = tasks.indexWhere((task) => task.id == id);
    await taskBox.deleteAt(index);
  }

  @override
  Future<void> updateTask(int id,
      {String? title, String? description, bool? selected = false}) async {
    final taskBox = Hive.box<TaskModel>("tasks");
    final tasks = getAllTasks();

    final task = tasks.firstWhere((task) => task.id == id);
    final index = tasks.indexWhere((task) => task.id == id);
    final taskUpdated = task.copyWith(
        id: id, title: title, description: description, isSelected: selected);
    await taskBox.putAt(index, taskUpdated);
  }
}