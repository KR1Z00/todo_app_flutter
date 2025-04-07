import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/todo/add/service/add_todo_service.dart';
import 'package:todo_app/todo/repository/todos_repository.dart';

class MockTodosRepository extends Mock implements TodosRepository {}

void main() {
  late MockTodosRepository mockTodosRepository;
  late AddTodoServiceImpl service;

  setUp(() {
    mockTodosRepository = MockTodosRepository();
    service = AddTodoServiceImpl(todosRepository: mockTodosRepository);
  });

  test('addTodoListItem calls repository with correct arguments', () async {
    // Arrange
    const testTitle = 'Test title';
    const testDescription = 'Test description';

    when(
      () => mockTodosRepository.addTodoListItem(
        title: testTitle,
        description: testDescription,
      ),
    ).thenAnswer((_) async {});

    // Act
    await service.addTodoListItem(
      title: testTitle,
      description: testDescription,
    );

    // Assert
    verify(
      () => mockTodosRepository.addTodoListItem(
        title: testTitle,
        description: testDescription,
      ),
    ).called(1);
  });
}
