import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/todo/model/todo_list_item_model.dart';

import '../../repository/todos_repository.dart';

part 'todo_list_service.g.dart';

/// A service that handles the backend operations for the todo list
abstract class TodoListService {
  /// Fetches the list of todo list items
  Future<List<TodoListItemModel>> fetchTodoListItems();

  /// Checks the todo list item with the given [id]
  Future<void> checkTodoListItem({required String id});

  /// Unchecks the todo list item with the given [id]
  Future<void> uncheckTodoListItem({required String id});
}

/// A [TodoListService] that uses a [TodosRepository] for retrieval and storage
class TodoListServiceImpl extends TodoListService {
  final TodosRepository _todosRepository;

  TodoListServiceImpl({required TodosRepository todosRepository})
    : _todosRepository = todosRepository;

  @override
  Future<List<TodoListItemModel>> fetchTodoListItems() =>
      _todosRepository.fetchTodoListItems();

  @override
  Future<void> checkTodoListItem({required String id}) =>
      _todosRepository.checkTodoListItem(id: id);

  @override
  Future<void> uncheckTodoListItem({required String id}) =>
      _todosRepository.uncheckTodoListItem(id: id);
}

@riverpod
TodoListService todoListService(Ref ref) {
  final repository = ref.watch(todosRepositoryProviderProvider);
  return TodoListServiceImpl(todosRepository: repository);
}
