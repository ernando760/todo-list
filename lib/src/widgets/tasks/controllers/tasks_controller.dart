// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class TasksController extends ChangeNotifier {
  late final RepositoryInterface _repository;
  TasksController({required RepositoryInterface repositoryInterface}) {
    _repository = repositoryInterface;
  }

  Stream<List<TaskModel>> tasksStream = const Stream.empty();

  bool isLoaded = false;
  TaskModel? task;
  int indexSelected = 0;
  List<TaskModel> tasks = [];

  void onIndexSelected(int index) {
    indexSelected = index;
    notifyListeners();
  }

  ///// Getting all tasks on database in real-time///////

  void getAllTasksStream() {
    tasksStream = _repository.getAllTaskStream().asBroadcastStream();
    notifyListeners();
  }

  /// adding task on database ///

  Future<void> addTask(
      {required String title, required String description}) async {
    isLoaded = true;
    for (var task in tasks) {
      if (task.title == title) {
        log("task already was added");
        isLoaded = false;
        notifyListeners();
        return;
      }
    }
    await _repository.addTask(title: title, description: description);
    getAllTasks();
    isLoaded = false;
    notifyListeners();
  }

  /// getting all tasks on database ///
  Future<void> getAllTasks() async {
    isLoaded = true;
    tasks = await _repository.getAllTasks();
    isLoaded = false;
    notifyListeners();
  }

  /// rtemove task on database ///

  Future<void> removeTask({required String id}) async {
    isLoaded = true;
    await _repository.removeTask(id: id);
    getAllTasks();
    isLoaded = false;
    notifyListeners();
  }

  /// updating task on database ///

  Future<void> updateTask(String id,
      {String? title, String? description, bool? isSelected}) async {
    late final TaskModel task;
    if (isSelected == null) {
      task = await _repository.getTask(id: id);
    }
    isLoaded = true;
    await _repository.updateTask(id,
        title: title,
        description: description,
        selected: isSelected ?? task.isSelected);
    await getAllTasks();
    await getTask(id: id);
    isLoaded = false;
    notifyListeners();
  }

  /// getting task on database ///

  Future<void> getTask({required String id}) async {
    isLoaded = true;
    task = await _repository.getTask(id: id);
    isLoaded = false;
    notifyListeners();
  }

  /// handling selected task ///

  void handleSelectedTask(
      {required bool? isSelected, required String id}) async {
    if (isSelected != null) {
      isLoaded = true;
      task = await _repository.getTask(id: id);

      if (task != null) {
        task!.isSelected = isSelected;
        await updateTask(id,
            title: task!.title,
            description: task!.description,
            isSelected: isSelected);
      }
      isLoaded = false;
      notifyListeners();
    }
  }
}
