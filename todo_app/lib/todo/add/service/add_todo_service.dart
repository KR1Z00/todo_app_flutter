import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repository/todos_repository.dart';

part 'add_todo_service.g.dart';

/// A service that handles the backend operations for adding a todo list item
sealed class AddTodoService {
  /// Adds a new Todo list item with a given title and description
  Future<void> addTodoListItem({
    required String title,
    required String description,
  });
}

/// An [AddTodoService] that uses a [TodosRepository] for storage
class AddTodoServiceImpl extends AddTodoService {
  final TodosRepository _todosRepository;

  AddTodoServiceImpl({required TodosRepository todosRepository})
    : _todosRepository = todosRepository;

  @override
  Future<void> addTodoListItem({
    required String title,
    required String description,
  }) =>
      _todosRepository.addTodoListItem(title: title, description: description);
}

@riverpod
AddTodoService addTodoService(Ref ref) {
  final repository = ref.watch(todosRepositoryProviderProvider);
  return AddTodoServiceImpl(todosRepository: repository);
}
