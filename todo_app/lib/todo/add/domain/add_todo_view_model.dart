import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/todo/add/service/add_todo_service.dart';

part 'add_todo_view_model.g.dart';

enum AddTodoState { initial, saving, done }

@riverpod
class AddTodoViewModel extends _$AddTodoViewModel {
  @override
  AddTodoState build() => AddTodoState.initial;

  Future<void> saveNewTodo({
    required String title,
    required String description,
  }) async {
    state = AddTodoState.saving;
    await ref
        .read(addTodoServiceProvider)
        .addTodoListItem(title: title, description: description);
    state = AddTodoState.done;
  }
}
