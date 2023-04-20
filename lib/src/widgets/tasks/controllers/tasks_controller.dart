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
    for (var task in tasks) {
      if (task.title == title) {
        print("task already was added");
        notifyListeners();
        return;
      }
    }
    await _repositoryInterface.addTask(title: title, description: description);
    getAllTasks();
    notifyListeners();
  }

  void getAllTasks() {
    tasks = _repositoryInterface.getAllTasks();
    tasksChecked = _repositoryInterface.getAllTasksChecked();
    notifyListeners();
  }

  Future<void> removeTask({required String id}) async {
    await _repositoryInterface.removeTask(id: id);
    getAllTasks();
    notifyListeners();
  }

  Future<void> updateTask(String id,
      {String? title, String? description}) async {
    await _repositoryInterface.updateTask(id,
        title: title, description: description, selected: task?.isSelected);
    getAllTasks();
    getTask(id: id);
    notifyListeners();
  }

  void getTask({required String id}) {
    task = _repositoryInterface.getTask(id: id);
    notifyListeners();
  }

  void handlerCheckedTask({required bool? isSelected, required String id}) {
    if (isSelected != null) {
      var indexTask = tasks.indexWhere((element) => element.id == id);
      if (isSelected) {
        task = tasks[indexTask];
        if (task != null) {
          task?.setSelected = isSelected;
          print("task selected true: $task");
          _repositoryInterface.removeTask(id: task!.id!);
          _repositoryInterface.addTaskChecked(task: task!);
        }
      } else {
        indexTask = tasksChecked.indexWhere((element) => element.id == id);
        task = tasksChecked[indexTask];
        print("task selected false: $task");
        if (task != null) {
          task?.setSelected = isSelected;
          _repositoryInterface.removeTaskChecked(id: task!.id!);
          _repositoryInterface.addTask(
            title: task!.title,
            description: task!.description,
          );
        }
      }
    }
    getAllTasks();
    notifyListeners();
  }
}
