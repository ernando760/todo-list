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

  void addTask({required String title, required String description}) async {
    await _repositoryInterface.addTask(title: title, description: description);
    tasks = _repositoryInterface.getAllTasks();
    notifyListeners();
  }

  void getAllTasks() {
    tasks = _repositoryInterface.getAllTasks();
    tasksChecked = _repositoryInterface.getAllTasksChecked();
    notifyListeners();
  }

  void removeTask({required int id}) async {
    await _repositoryInterface.removeTask(id: id);
    getAllTasks();
    notifyListeners();
  }

  void removeTaskChecked({required int id}) async {
    final task = tasksChecked.firstWhere((element) => element.id == id);
    await _repositoryInterface.removeTaskChecked(taskRemove: task);
    getAllTasks();
    notifyListeners();
  }

  void updateTask(int id, {String? title, String? description}) async {
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

  void isSelected(bool? isSelected, int id) async {
    if (isSelected != null) {
      if (isSelected) {
        task = tasks.firstWhere((element) => element.id == id);
        if (task != null) {
          task?.setSelected = isSelected;
          await _repositoryInterface.addTaskChecked(task: task!);
        }
      } else {
        task = tasksChecked.firstWhere((element) => element.id == id);
        if (task != null) {
          task?.setSelected = isSelected;
          removeTaskChecked(id: id);
          addTask(title: task!.title, description: task!.description);
        }
      }
    }
    getAllTasks();
    print(task);
    notifyListeners();
  }

  void onIndexSelected(int index) {
    indexSelected = index;
    notifyListeners();
  }
}
