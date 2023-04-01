import 'package:flutter/material.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class HomeController {
  final tasks = ValueNotifier<List<TaskModel>>([]);
  late final RepositoryInterface _repositoryInterface;

  HomeController({required RepositoryInterface repositoryInterface}) {
    _repositoryInterface = repositoryInterface;
  }

  addTask({required String title, required String description}) {
    tasks.value =
        _repositoryInterface.addTask(title: title, description: description);
  }

  getAllTask() {
    tasks.value = _repositoryInterface.getAllTasks();
  }

  removeTask({required int id}) {
    tasks.value = _repositoryInterface.removeTask(id: id);
  }
}
