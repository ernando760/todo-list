import 'package:flutter/material.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class TasksController {
  final tasks = ValueNotifier<List<TaskModel>>([]);
  final task = ValueNotifier<TaskModel?>(null);
  late final RepositoryInterface _repositoryInterface;

  TasksController({required RepositoryInterface repositoryInterface}) {
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

  updateTask(int id, {String? title, String? despcription}) {
    tasks.value = _repositoryInterface.updateTask(id,
        title: title, description: despcription);
  }

  getTask({required int id}) {
    task.value = _repositoryInterface.getTask(id: id);
  }
}
