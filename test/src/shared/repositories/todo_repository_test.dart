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
    registerFallbackValue(TaskModel(title: "teste", description: "testando"));
  });

  test("add task", () {
    when(
      () => todoRepository.addTask(
          title: any(named: "title"), description: any(named: "description")),
    ).thenAnswer(
        (invocation) => [TaskModel(title: "teste", description: "testando")]);

    var tasks = todoRepository.addTask(title: "ernando", description: "doido");
    expect(tasks, isNotEmpty);
    expect(tasks, isA<List<TaskModel>>());

    verify(
      () => todoRepository.addTask(
          title: any(named: "title"), description: any(named: "description")),
    ).called(1);
  });
}
