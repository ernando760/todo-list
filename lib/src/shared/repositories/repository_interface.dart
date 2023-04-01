import 'package:todo_list/src/shared/model/task_model.dart';

abstract class RepositoryInterface {
  List<TaskModel> getAllTasks();
  TaskModel getTask({required int id});
  List<TaskModel> addTask({required String title, required String description});
  List<TaskModel> removeTask({required int id});
  List<TaskModel> updateTask(int id, {String? title, String? description});
}
