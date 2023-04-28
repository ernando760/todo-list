import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class SupabaseTasksREpository extends RepositoryInterface {
  @override
  Future<void> addTask({required String title, required String description}) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<void> addTaskChecked({required TaskModel task}) {
    // TODO: implement addTaskChecked
    throw UnimplementedError();
  }

  @override
  List<TaskModel> getAllTasks() {
    // TODO: implement getAllTasks
    throw UnimplementedError();
  }

  @override
  List<TaskModel> getAllTasksChecked() {
    // TODO: implement getAllTasksChecked
    throw UnimplementedError();
  }

  @override
  TaskModel getTask({required String id}) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<void> removeTask({required String id}) {
    // TODO: implement removeTask
    throw UnimplementedError();
  }

  @override
  Future<void> removeTaskChecked({required String id}) {
    // TODO: implement removeTaskChecked
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(String id,
      {String? title, String? description, bool? selected}) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
