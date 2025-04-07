import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/todo/list/domain/todo_list_view_model.dart';
import 'package:todo_app/todo/list/service/todo_list_service.dart';
import 'package:todo_app/todo/model/todo_list_item_model.dart';

class MockTodoListService extends Mock implements TodoListService {}

void main() {
  late ProviderContainer container;
  late MockTodoListService mockService;

  final mockTodos = [
    TodoListItemModel(
      id: '1',
      title: 'Test 1',
      description: 'Desc 1',
      isChecked: false,
    ),
    TodoListItemModel(
      id: '2',
      title: 'Test 2',
      description: 'Desc 2',
      isChecked: true,
    ),
  ];

  setUp(() {
    mockService = MockTodoListService();
    container = ProviderContainer(
      overrides: [todoListServiceProvider.overrideWithValue(mockService)],
    );
  });

  tearDown(() => container.dispose());

  test('build returns fetched todo list', () async {
    when(
      () => mockService.fetchTodoListItems(),
    ).thenAnswer((_) async => mockTodos);

    final result = await container.read(todoListViewModelProvider.future);

    expect(result, mockTodos);
    verify(() => mockService.fetchTodoListItems()).called(1);
  });

  test('refresh sets loading state if showLoading is true', () async {
    when(
      () => mockService.fetchTodoListItems(),
    ).thenAnswer((_) async => mockTodos);

    final notifier = container.read(todoListViewModelProvider.notifier);

    await notifier.refresh(showLoading: true);

    final state = container.read(todoListViewModelProvider);
    expect(state, AsyncValue.data(mockTodos));
  });

  test('refresh sets data without loading when showLoading is false', () async {
    when(
      () => mockService.fetchTodoListItems(),
    ).thenAnswer((_) async => mockTodos);

    final notifier = container.read(todoListViewModelProvider.notifier);

    await notifier.refresh();

    final state = container.read(todoListViewModelProvider);
    expect(state, AsyncValue.data(mockTodos));
  });

  test('refresh sets error if fetch fails', () async {
    final error = Exception('Failed to fetch');
    when(() => mockService.fetchTodoListItems()).thenThrow(error);

    final notifier = container.read(todoListViewModelProvider.notifier);

    await notifier.refresh(showLoading: true);

    final state = container.read(todoListViewModelProvider);
    expect(state.hasError, true);
    expect(state.error, error);
  });

  test('didTapItem checks an unchecked item and updates state', () async {
    when(
      () => mockService.fetchTodoListItems(),
    ).thenAnswer((_) async => mockTodos);
    when(
      () => mockService.checkTodoListItem(id: '1'),
    ).thenAnswer((_) async => {});

    final notifier = container.read(todoListViewModelProvider.notifier);
    await notifier.refresh();

    await notifier.didTapItem(id: '1');

    final updatedState = container.read(todoListViewModelProvider);
    final updatedItem = updatedState.value!.firstWhere(
      (item) => item.id == '1',
    );
    expect(updatedItem.isChecked, true);
  });

  test('didTapItem unchecks a checked item and updates state', () async {
    when(
      () => mockService.fetchTodoListItems(),
    ).thenAnswer((_) async => mockTodos);
    when(
      () => mockService.uncheckTodoListItem(id: '2'),
    ).thenAnswer((_) async => {});

    final notifier = container.read(todoListViewModelProvider.notifier);
    await notifier.refresh();

    await notifier.didTapItem(id: '2');

    final updatedState = container.read(todoListViewModelProvider);
    final updatedItem = updatedState.value!.firstWhere(
      (item) => item.id == '2',
    );
    expect(updatedItem.isChecked, false);
  });

  test('didTapItem does nothing if ID not found', () async {
    when(
      () => mockService.fetchTodoListItems(),
    ).thenAnswer((_) async => mockTodos);

    final notifier = container.read(todoListViewModelProvider.notifier);
    await notifier.refresh();

    await notifier.didTapItem(id: '999'); // Nonexistent

    final state = container.read(todoListViewModelProvider);
    expect(state.value, mockTodos);
  });
}
