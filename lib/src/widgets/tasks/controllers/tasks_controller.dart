// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class TasksController extends ChangeNotifier {
  late final RepositoryInterface _repositoryInterface;
  TasksController({required RepositoryInterface repositoryInterface}) {
    _repositoryInterface = repositoryInterface;
  }
  TaskModel? task;
  int indexSelected = 0;
  List<TaskModel> tasks = [];
  List<TaskModel> tasksChecked = [];

  void onIndexSelected(int index) {
    indexSelected = index;
    print("change");
    notifyListeners();
  }

  Future<void> addTask(
      {required String title, required String description}) async {
    await _repositoryInterface.addTask(title: title, description: description);
    tasks = _repositoryInterface.getAllTasks();
    notifyListeners();
  }

  void getAllTasks() {
    tasks = _repositoryInterface.getAllTasks();
    tasksChecked = tasks.where((task) => task.isSelected == true).toList();
    notifyListeners();
  }

  Future<void> removeTask({required int id}) async {
    await _repositoryInterface.removeTask(id: id);
    getAllTasks();
    notifyListeners();
  }

  Future<void> updateTask(int id, {String? title, String? description}) async {
    await _repositoryInterface.updateTask(id,
        title: title, description: description, selected: task?.isSelected);
    getAllTasks();
    getTask(id: id);
    notifyListeners();
  }

  void getTask({required int id}) {
    task = _repositoryInterface.getTask(id: id);
    notifyListeners();
  }

  void isSelected({required bool? isSelected, required int id}) {
    if (isSelected != null) {
      var indexTask = tasks.indexWhere((element) => element.id == id);
      if (isSelected) {
        task = tasks[indexTask];
        print("task selected true: $task");
        if (task != null) {
          task?.setSelected = isSelected;
          _repositoryInterface.updateTask(id, selected: isSelected);
          tasks.removeAt(
            indexTask,
          );
          tasksChecked.add(task!);
        }
      } else {
        indexTask = tasksChecked.indexWhere((element) => element.id == id);
        task = tasksChecked[indexTask];
        print("task selected false: $task");
        if (task != null) {
          task?.setSelected = isSelected;
          _repositoryInterface.updateTask(id, selected: isSelected);
          tasksChecked.removeAt(
            indexTask,
          );
          tasks.add(task!);
        }
      }
    }
    // getAllTasks();
    print(task);
    notifyListeners();
  }
}
