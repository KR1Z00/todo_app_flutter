import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/todo/model/todo_list_item_model.dart';
import 'package:ui_elements/constants/ui_constants.dart';

import 'package:ui_elements/cm_todo_list_item.dart';
import 'package:ui_elements/root/cm_navigation_scroll_view.dart';
import 'package:ui_elements/root/cm_logo_app_bar_leading.dart';
import 'package:ui_elements/theme/theme_extensions.dart';

import '../../../app/localization/generated/locale_keys.g.dart';
import '../domain/todo_list_view_model.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListState = ref.watch(todoListViewModelProvider);
    return Scaffold(
      backgroundColor: context.colorScheme().surface,
      body: CMNavigationScrollView(
        appBarLeading: CMLogoAppBarLeading(),
        appBarType: CMNavigationAppBarType.medium,
        title: tr(LocaleKeys.yourTodos),
        childSliver: SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalScreenMargin,
            vertical: 48,
          ),
          sliver: todoListState.when(
            data:
                (todoList) =>
                    todoList.isEmpty
                        ? _EmptyTodosContent()
                        : _TodoListContent(todoList: todoList),
            error: (_, __) => SliverFillRemaining(),
            loading:
                () => SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
          ),
        ),
      ),
    );
  }
}

class _TodoListContent extends ConsumerWidget {
  final List<TodoListItemModel> _todoList;

  const _TodoListContent({required List<TodoListItemModel> todoList})
    : _todoList = todoList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList.separated(
      itemCount: _todoList.length,
      itemBuilder:
          (context, index) => CMTodoListItem(
            title: _todoList[index].title,
            description: _todoList[index].description,
            isChecked: _todoList[index].isChecked,
            didTap:
                () => ref
                    .read(todoListViewModelProvider.notifier)
                    .didTapItem(id: _todoList[index].id),
          ),
      separatorBuilder: (context, index) => SizedBox(height: 16),
    );
  }
}

class _EmptyTodosContent extends StatelessWidget {
  const _EmptyTodosContent();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(LocaleKeys.emptyTodosTitle),
            style: context.textTheme().headlineSmall,
          ),
          Gap(8),
          Text(tr(LocaleKeys.emptyTodosGuidance)),
        ],
      ),
    );
  }
}
