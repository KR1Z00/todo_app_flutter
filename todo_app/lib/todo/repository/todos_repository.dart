import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/todo/model/todo_list_item_model.dart';

part 'todos_repository.g.dart';

/// Manages the data retrieval and storage for Todo list items
abstract class TodosRepository {
  /// Fetches the list of todo items
  Future<List<TodoListItemModel>> fetchTodoListItems();

  /// Adds a new Todo list item with a given title and description
  Future<void> addTodoListItem({
    required String title,
    required String description,
  });

  /// Checks the todo list item with the given [id]
  Future<void> checkTodoListItem({required String id});

  /// Unchecks the todo list item with the given [id]
  Future<void> uncheckTodoListItem({required String id});
}

/// A mock [TodosRepository] that simply stores the Todo list in memory
class MockTodosRepository implements TodosRepository {
  final Map<String, TodoListItemModel> _todoList = {};

  @override
  Future<List<TodoListItemModel>> fetchTodoListItems() async {
    await Future.delayed(Duration(milliseconds: _randomMockDelayMs));
    return (_todoList.entries.toList()
          ..sort((entryA, entryB) => entryA.key.compareTo(entryB.key)))
        .map((entry) => entry.value)
        .toList();
  }

  @override
  Future<void> addTodoListItem({
    required String title,
    required String description,
  }) async {
    await Future.delayed(Duration(milliseconds: _randomMockDelayMs));
    final newId = _todoList.length.toString();
    _todoList[newId] = TodoListItemModel(
      id: newId,
      title: title,
      description: description,
      isChecked: false,
    );
  }

  @override
  Future<void> checkTodoListItem({required String id}) async {
    await Future.delayed(Duration(milliseconds: _randomMockDelayMs));
    final newListItem = _todoList[id]?.copyWith(isChecked: true);
    if (newListItem != null) {
      _todoList[id] = newListItem;
    }
  }

  @override
  Future<void> uncheckTodoListItem({required String id}) async {
    await Future.delayed(Duration(milliseconds: _randomMockDelayMs));
    final newListItem = _todoList[id]?.copyWith(isChecked: false);
    if (newListItem != null) {
      _todoList[id] = newListItem;
    }
  }

  static const int _maxRandomMockDelayMs = 1800;
  int get _randomMockDelayMs => Random().nextInt(_maxRandomMockDelayMs);
}

@riverpod
TodosRepository todosRepositoryProvider(Ref ref) {
  return MockTodosRepository();
}
