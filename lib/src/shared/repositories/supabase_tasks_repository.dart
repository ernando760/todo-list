// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class SupabaseTasksRepository extends RepositoryInterface {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  List<TaskModel> _tasks = [];

  // getting all tasks on database in real-time ///
  @override
  Stream<List<TaskModel>> getAllTaskStream() async* {
    try {
      final supabaseStreamBuilder =
          _supabaseClient.from("tasks").stream(primaryKey: ["id"]);
      final tasksStream = supabaseStreamBuilder
          .asyncMap((event) => event.map((e) => TaskModel.fromMap(e)).toList());
      yield* tasksStream;
    } catch (e) {
      print(" ========== ERROR: 'getAllTaskStream' ==========");
      print(e);
      yield* const Stream.empty();
    }
  }

  /// add task on database ///
  @override
  Future<bool?> addTask(
      {required String title, required String description}) async {
    try {
      await _supabaseClient.from("tasks").insert(
          {"title": title, "description": description, "isSelected": false});
      return true;
    } catch (e) {
      print(" ========== ERROR: 'addTask' ==========");
      print(e);
      return null;
    }
  }

  /// getting all tasks on database ///
  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final List<Map<String, dynamic>> res =
          await _supabaseClient.from("tasks").select();
      print(res);
      _tasks = res.map((e) => TaskModel.fromMap(e)).toList();
      return _tasks;
    } catch (e) {
      print(" ========== ERROR: 'getAllTasks' ==========");
      print(e);
      return [];
    }
  }

  /// getting task on database ///
  @override
  Future<TaskModel> getTask({required String id}) async {
    try {
      //_tasks = await getAllTasks();
      var taskMap = await _supabaseClient
          .from("tasks")
          .select<PostgrestMap>()
          .eq("id", id)
          .limit(1)
          .single();
      // var indexTask = _tasks.indexWhere((element) => element.id == id);
      var task = TaskModel.fromMap(taskMap);
      return task;
    } catch (e) {
      print(" ========== ERROR: 'getTask' ==========");
      print(e);
      rethrow;
    }
  }

  /// remove task on database ///
  @override
  Future<bool?> removeTask({required String id}) async {
    try {
      await _supabaseClient.from("tasks").delete().eq("id", id);

      return true;
    } catch (e) {
      print(" ========== ERROR: 'removeTask' ==========");
      print(e);
      return false;
    }
  }

  /// updating task on database ///
  @override
  Future<bool?> updateTask(String id,
      {String? title, String? description, bool? selected}) async {
    try {
      await _supabaseClient.from("tasks").update({
        'title': title,
        'description': description,
        'isSelected': selected
      }).eq("id", id);
      return true;
    } catch (e) {
      print(" ========== ERROR: 'updateTask' ==========");
      print(e);
      return false;
    }
  }
}
