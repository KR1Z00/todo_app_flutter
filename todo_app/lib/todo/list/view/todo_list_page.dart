import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
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
    final todoItems = ref.watch(todoListViewModelProvider);
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
          sliver:
              todoItems.isEmpty
                  ? SliverToBoxAdapter(child: _EmptyTodosContent())
                  : _TodoListContent(),
        ),
      ),
    );
  }
}

class _TodoListContent extends ConsumerWidget {
  const _TodoListContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoItems = ref.watch(todoListViewModelProvider);
    return SliverList.separated(
      itemCount: todoItems.length,
      itemBuilder:
          (context, index) => CMTodoListItem(
            title: todoItems[index].title,
            description: todoItems[index].description,
            isChecked: todoItems[index].isChecked,
          ),
      separatorBuilder: (context, index) => SizedBox(height: 16),
    );
  }
}

class _EmptyTodosContent extends StatelessWidget {
  const _EmptyTodosContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr(LocaleKeys.emptyTodosTitle),
          style: context.textTheme().headlineSmall,
        ),
        Gap(8),
        Text(tr(LocaleKeys.emptyTodosGuidance)),
      ],
    );
  }
}
