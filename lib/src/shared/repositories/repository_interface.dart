import 'package:todo_list/src/shared/model/task_model.dart';

abstract class RepositoryInterface {
  Future<List<TaskModel>> getAllTasks();
  Future<TaskModel> getTask({required String id});
  Future<bool?> addTask({required String title, required String description});
  Future<bool?> removeTask({required String id});
  Future<bool?> updateTask(String id,
      {String? title, String? description, bool? selected});
  Stream<List<TaskModel>> getAllTaskStream() => const Stream.empty();
}
