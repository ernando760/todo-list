// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';
import 'package:uuid/uuid.dart';

class LocalTasksRepository extends RepositoryInterface {
  List<TaskModel> _tasks = [];

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final taskBox = Hive.box<TaskModel>("tasks");
      _tasks = taskBox.values.map((task) => task).toList();
      ("tasks:$_tasks");
      return _tasks;
    } catch (e) {
      print(" ========== ERROR: 'getAllTasks' ==========");
      print(e);
      return [];
    }
  }

  @override
  Future<bool?> addTask(
      {required String title, required String description}) async {
    try {
      final taskBox = Hive.box<TaskModel>("tasks");
      if (title.isNotEmpty || description.isNotEmpty) {
        const uuid = Uuid();
        final task =
            TaskModel(id: uuid.v4(), title: title, description: description);
        await taskBox.add(task);
        return true;
      }

      return false;
    } catch (e) {
      print(" ========== ERROR: 'addTask' ==========");
      print(e);
      return null;
    }
  }

  @override
  Future<TaskModel> getTask({required String id}) async {
    _tasks = await getAllTasks();
    try {
      var taskIndex = _tasks.indexWhere((task) => task.id == id);
      return _tasks[taskIndex];
    } catch (e) {
      print(" ========== ERROR: 'getTask' ==========");
      print(e);
      rethrow;
    }
  }

  @override
  Future<bool?> removeTask({required String id}) async {
    try {
      final taskBox = Hive.box<TaskModel>("tasks");
      _tasks = await getAllTasks();

      final index = _tasks.indexWhere((task) => task.id == id);
      await taskBox.deleteAt(index);
      return true;
    } catch (e) {
      print(" ========== ERROR: 'removeTask' ==========");
      print(e);
      return false;
    }
  }

  @override
  Future<bool?> updateTask(String id,
      {String? title, String? description, bool? selected = false}) async {
    try {
      _tasks = await getAllTasks();
      final taskBox = Hive.box<TaskModel>("tasks");
      var index = _tasks.indexWhere((task) => task.id == id);
      print(index);

      final taskUpdated = _tasks[index].copyWith(
          id: id, title: title, description: description, isSelected: selected);
      await taskBox.putAt(index, taskUpdated);
      return true;
    } catch (e) {
      print(" ========== ERROR: 'updateTask' ==========");
      print(e);
      return false;
    }
  }
}
