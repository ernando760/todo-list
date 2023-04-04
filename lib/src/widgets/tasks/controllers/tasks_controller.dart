import 'package:flutter/material.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class TasksController extends ChangeNotifier {
  List<TaskModel> tasks = [];
  TaskModel? task;
  late final RepositoryInterface _repositoryInterface;

  TasksController({required RepositoryInterface repositoryInterface}) {
    _repositoryInterface = repositoryInterface;
  }

  addTask({required String title, required String description}) {
    tasks =
        _repositoryInterface.addTask(title: title, description: description);
    print(tasks);
    notifyListeners();
  }

  getAllTask() {
    tasks = _repositoryInterface.getAllTasks();
    notifyListeners();
  }

  removeTask({required int id}) {
    tasks = _repositoryInterface.removeTask(id: id);
    notifyListeners();
  }

  updateTask(int id, {String? title, String? despcription}) {
    tasks = _repositoryInterface.updateTask(id,
        title: title, description: despcription);
    notifyListeners();
  }

  getTask({required int id}) {
    task = _repositoryInterface.getTask(id: id);
    notifyListeners();
  }
}
