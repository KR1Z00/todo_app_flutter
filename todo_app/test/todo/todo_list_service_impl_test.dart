import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/todo/list/service/todo_list_service.dart';
import 'package:todo_app/todo/model/todo_list_item_model.dart';
import 'package:todo_app/todo/repository/todos_repository.dart';

class MockTodosRepository extends Mock implements TodosRepository {}

void main() {
  late MockTodosRepository mockRepository;
  late TodoListServiceImpl service;

  setUp(() {
    mockRepository = MockTodosRepository();
    service = TodoListServiceImpl(todosRepository: mockRepository);
  });

  test('fetchTodoListItems delegates to repository', () async {
    final mockItems = [
      TodoListItemModel(
        id: '1',
        title: 'Item 1',
        description: 'Description 1',
        isChecked: false,
      ),
    ];

    when(
      () => mockRepository.fetchTodoListItems(),
    ).thenAnswer((_) async => mockItems);

    final result = await service.fetchTodoListItems();

    expect(result, mockItems);
    verify(() => mockRepository.fetchTodoListItems()).called(1);
  });

  test('checkTodoListItem delegates to repository', () async {
    const testId = '123';

    when(
      () => mockRepository.checkTodoListItem(id: testId),
    ).thenAnswer((_) async {});

    await service.checkTodoListItem(id: testId);

    verify(() => mockRepository.checkTodoListItem(id: testId)).called(1);
  });

  test('uncheckTodoListItem delegates to repository', () async {
    const testId = '456';

    when(
      () => mockRepository.uncheckTodoListItem(id: testId),
    ).thenAnswer((_) async {});

    await service.uncheckTodoListItem(id: testId);

    verify(() => mockRepository.uncheckTodoListItem(id: testId)).called(1);
  });
}
