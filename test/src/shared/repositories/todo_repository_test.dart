// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/src/shared/model/task_model.dart';
import 'package:todo_list/src/shared/repositories/repository_interface.dart';

class TodoRepositoryMock extends Mock implements RepositoryInterface {}

void main() {
  late final RepositoryInterface todoRepository;
  setUpAll(() {
    todoRepository = TodoRepositoryMock();
    registerFallbackValue(todoRepository);
    registerFallbackValue(
        TaskModel(id: "dwdwd", title: "teste", description: "testando"));
    registerFallbackValue(
        TaskModel(id: "dwdwd", title: "ernando", description: "doido"));
  });

  test("add task", () {
    when(
      () => todoRepository.addTask(
          title: any(named: "title"), description: any(named: "description")),
    );

    var tasks = todoRepository.addTask(title: "ernando", description: "doido");
    print(tasks);
    expect(tasks, isNotEmpty);
    expect(tasks, isA<List<TaskModel>>());

    verify(
      () => todoRepository.addTask(
          title: any(named: "title"), description: any(named: "description")),
    ).called(1);
    // verifyNoMoreInteractions(todoRepository);
  });

  test("get all tasks", () {
    when(
      () => todoRepository.getAllTasks(),
    ).thenAnswer(
        (invocation) => [TaskModel(title: "teste", description: "testando")]);

    todoRepository.addTask(title: "ernando", description: "doido");
    var tasks = todoRepository.getAllTasks();
    print(tasks);
    expect(tasks, isNotEmpty);
    expect(tasks, isA<List<TaskModel>>());

    verify(
      () => todoRepository.getAllTasks(),
    ).called(1);
  });

  test("get task", () {
    when(
      () => todoRepository.getTask(id: "dwdwd"),
    ).thenAnswer((invocation) =>
        TaskModel(id: "dwdwd", title: "teste", description: "testando"));

    todoRepository.addTask(title: "ernando", description: "doido");
    var task = todoRepository.getTask(id: "dwdwd");
    print(task);
    expect(task, isA<TaskModel>());

    verify(
      () => todoRepository.getTask(id: any(named: "id")),
    ).called(1);
  });

  test("delete task", () {
    when(
      () => todoRepository.removeTask(id: any(named: "id")),
    );

    todoRepository.addTask(title: "ernando", description: "doido");
    var tasks = todoRepository.removeTask(id: "dwdwd");
    print(tasks);
    expect(tasks, isEmpty);
    expect(tasks, isA<List<TaskModel>>());

    verify(
      () => todoRepository.removeTask(id: any(named: "id")),
    ).called(1);
  });

  test("updated task", () {
    when(
      () => todoRepository.updateTask("dwdwd",
          title: any(named: "title", that: equals("ernando")),
          description: any(named: "description", that: equals("doido"))),
    );

    var updatedTask = todoRepository.updateTask("dwdwd",
        title: "ernando", description: "doido");

    print(updatedTask);
    expect(updatedTask, isA<List<TaskModel>>());
    verify(
      () => todoRepository.updateTask("dwdwd",
          title: any(named: "title", that: equals("ernando")),
          description: any(named: "description", that: equals("doido"))),
    ).called(1);
    // verifyNoMoreInteractions(todoRepository);
  });
}
