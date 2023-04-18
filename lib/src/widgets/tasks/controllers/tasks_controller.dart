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

  Future<void> addTask(
      {required String title, required String description}) async {
    await _repositoryInterface.addTask(title: title, description: description);
    tasks = _repositoryInterface.getAllTasks();
    notifyListeners();
  }

  void getAllTasks() {
    tasks = _repositoryInterface.getAllTasks();
    tasksChecked = _repositoryInterface.getAllTasksChecked();
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
      if (isSelected) {
        task = tasks.firstWhere((element) => element.id == id);
        if (task != null) {
          task?.setSelected = isSelected;
          _repositoryInterface.addTaskChecked(task: task!);
        }
      } else {
        task = tasksChecked.firstWhere((element) => element.id == id);
        if (task != null) {
          task?.setSelected = isSelected;
          addTask(title: task!.title, description: task!.description);
        }
      }
    }
    getAllTasks();
    print(task);
    notifyListeners();
  }
}
