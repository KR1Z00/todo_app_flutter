import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_list_item_model.freezed.dart';

@freezed
sealed class TodoListItemModel with _$TodoListItemModel {
  const factory TodoListItemModel({
    required String title,
    required String description,
    required bool isChecked,
  }) = _TodoListItemModel;
}
