import 'package:todo_list/src/shared/model/task_model.dart';

abstract class RepositoryInterface {
  List<TaskModel> getAllTasks();
  TaskModel getTask({required int id});
  Future<void> addTask({required String title, required String description});
  Future<void> removeTask({required int id});
  Future<void> updateTask(int id,
      {String? title, String? description, bool? selected});
  List<TaskModel> getAllTasksChecked();
  Future<void> addTaskChecked({required TaskModel task});
  Future<void> removeTaskChecked({required TaskModel taskRemove});
}
