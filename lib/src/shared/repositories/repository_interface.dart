import 'package:todo_list/src/shared/model/task_model.dart';

abstract class RepositoryInterface {
  List<TaskModel> getAllTasks();
  TaskModel getTask({required String id});
  Future<void> addTask({required String title, required String description});
  Future<void> removeTask({required String id});
  Future<void> updateTask(String id,
      {String? title, String? description, bool? selected});
  List<TaskModel> getAllTasksChecked();
  Future<void> addTaskChecked({required TaskModel task});
  Future<void> removeTaskChecked({required String id});
}
