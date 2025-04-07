import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/todo/add/domain/add_todo_view_model.dart';
import 'package:todo_app/todo/add/service/add_todo_service.dart';

class MockAddTodoService extends Mock implements AddTodoService {}

void main() {
  late ProviderContainer container;
  late MockAddTodoService mockService;

  setUp(() {
    mockService = MockAddTodoService();
    container = ProviderContainer(
      overrides: [addTodoServiceProvider.overrideWithValue(mockService)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('initial state is AddTodoState.initial', () {
    final viewModel = container.read(addTodoViewModelProvider.notifier);
    expect(viewModel.state, AddTodoState.initial);
  });

  test('saveNewTodo sets state to saving then done', () async {
    // Arrange
    const testTitle = 'Test Title';
    const testDescription = 'Test Description';

    when(
      () => mockService.addTodoListItem(
        title: testTitle,
        description: testDescription,
      ),
    ).thenAnswer((_) async {});

    final viewModel = container.read(addTodoViewModelProvider.notifier);

    // Act
    final future = viewModel.saveNewTodo(
      title: testTitle,
      description: testDescription,
    );

    // Expect intermediate state change
    expect(viewModel.state, AddTodoState.saving);

    await future;

    // Expect final state change
    expect(viewModel.state, AddTodoState.done);
    verify(
      () => mockService.addTodoListItem(
        title: testTitle,
        description: testDescription,
      ),
    ).called(1);
  });
}
