import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../model/todo_list_item_model.dart';
import '../service/todo_list_service.dart';

part 'todo_list_view_model.g.dart';

@riverpod
class TodoListViewModel extends _$TodoListViewModel {
  @override
  Future<List<TodoListItemModel>> build() => _fetchList();

  Future<void> refresh({bool showLoading = false}) async {
    try {
      if (showLoading) {
        state = const AsyncValue.loading();
      }
      final list = await _fetchList();
      state = AsyncValue.data(list);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  Future<void> didTapItem({required String id}) async {
    await state.when(
      data: (list) async {
        final itemIndex = list.indexWhere((item) => item.id == id);
        if (itemIndex == -1) {
          return;
        }

        final item = list[itemIndex];
        if (item.isChecked) {
          await ref.read(todoListServiceProvider).uncheckTodoListItem(id: id);
          list[itemIndex] = item.copyWith(isChecked: false);
        } else {
          await ref.read(todoListServiceProvider).checkTodoListItem(id: id);
          list[itemIndex] = item.copyWith(isChecked: true);
        }

        state = AsyncValue.data(list);
      },
      error: (_, __) async {},
      loading: () async {},
    );
  }

  Future<List<TodoListItemModel>> _fetchList() {
    final service = ref.read(todoListServiceProvider);
    return service.fetchTodoListItems();
  }
}
