import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/todo/model/todo_list_item_model.dart';

part 'todo_list_view_model.g.dart';

@riverpod
class TodoListViewModel extends _$TodoListViewModel {
  @override
  List<TodoListItemModel> build() {
    return [
      TodoListItemModel(title: "Test", description: "Foo", isChecked: true),
    ];
  }
}
