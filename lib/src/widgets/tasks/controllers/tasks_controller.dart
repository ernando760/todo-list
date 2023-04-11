// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class TasksController extends ChangeNotifier {
  // TaskModel? task;
  TaskModel? task;
  late final RepositoryInterface _repositoryInterface;
  List<TaskModel> tasks = [];
  TasksController({required RepositoryInterface repositoryInterface}) {
    _repositoryInterface = repositoryInterface;
  }

  addTask({required String title, required String description}) async {
    await _repositoryInterface.addTask(title: title, description: description);
    tasks = _repositoryInterface.getAllTasks();
    notifyListeners();
  }

  getAllTask() {
    tasks = _repositoryInterface.getAllTasks();
    notifyListeners();
  }

  removeTask({required int id}) async {
    await _repositoryInterface.removeTask(id: id);
    tasks = _repositoryInterface.getAllTasks();
    notifyListeners();
  }

  updateTask(int id, {String? title, String? description}) async {
    await _repositoryInterface.updateTask(id,
        title: title, description: description);
    tasks = _repositoryInterface.getAllTasks();
    notifyListeners();
  }

  getTask({required int id}) {
    task = _repositoryInterface.getTask(id: id);
    notifyListeners();
  }

  isSelected(bool? isSelected, int id) {
    task = tasks.firstWhere((element) => element.id == id);
    task?.setSelected = isSelected!;
    _repositoryInterface.updateTask(id,
        title: task?.title,
        description: task?.description,
        selected: task?.isSelected);
    print(task);
    notifyListeners();
  }
}
