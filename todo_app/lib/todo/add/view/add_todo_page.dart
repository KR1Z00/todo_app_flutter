import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import 'package:ui_elements/cm_primary_button.dart';
import 'package:ui_elements/cm_secondary_button.dart';
import 'package:ui_elements/cm_textfield.dart';
import 'package:ui_elements/constants/ui_constants.dart';
import 'package:ui_elements/root/cm_logo_app_bar_leading.dart';
import 'package:ui_elements/root/cm_navigation_scroll_view.dart';
import 'package:ui_elements/theme/theme_extensions.dart';

import '../../../app/localization/generated/locale_keys.g.dart';
import '../domain/add_todo_view_model.dart';

class AddTodoPage extends ConsumerWidget {
  static const double _listTopMargin = 40;
  static const double _addButtonBottomMargin = 24;
  static const double _addButtonHeight = CMPrimaryButton.preferredHeight;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  AddTodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomSafeAreaPadding = MediaQuery.viewPaddingOf(context).bottom;

    final addTodoState = ref.watch(addTodoViewModelProvider);
    ref.listen(addTodoViewModelProvider, (_, next) {
      if (next == AddTodoState.done) {
        context.pop();
      }
    });

    return Scaffold(
      backgroundColor: context.colorScheme().surface,
      body: Stack(
        children: [
          Positioned.fill(
            child: CMNavigationScrollView(
              appBarLeading: CMLogoAppBarLeading(),
              appBarType: CMNavigationAppBarType.medium,
              title: tr(LocaleKeys.addTodo),
              childSliver: SliverPadding(
                padding: EdgeInsets.only(
                  left: horizontalScreenMargin,
                  right: horizontalScreenMargin,
                  top: _listTopMargin,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12,
                    children: [
                      CMTextField(
                        controller: _titleController,
                        labelText: tr(LocaleKeys.todoTitle),
                      ),
                      CMTextField(
                        controller: _descriptionController,
                        labelText: tr(LocaleKeys.todoDescription),
                        canWrapLines: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: bottomSafeAreaPadding + _addButtonBottomMargin,
            left: horizontalScreenMargin,
            right: horizontalScreenMargin,
            height: _addButtonHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CMSecondaryButton(
                    icon: Icon(Icons.close),
                    label: Text(tr(LocaleKeys.cancel)),
                    onPressed:
                        addTodoState == AddTodoState.initial
                            ? () => context.pop()
                            : null,
                  ),
                ),
                Gap(16),
                Expanded(
                  child: CMPrimaryButton(
                    icon:
                        addTodoState == AddTodoState.saving
                            ? SizedBox.square(
                              dimension: 16,
                              child: CircularProgressIndicator(
                                color: context.colorScheme().onPrimary,
                              ),
                            )
                            : Icon(Icons.save),
                    label: Text(tr(LocaleKeys.save)),
                    onPressed: () {
                      if (addTodoState == AddTodoState.initial) {
                        ref
                            .read(addTodoViewModelProvider.notifier)
                            .saveNewTodo(
                              title: _titleController.text,
                              description: _descriptionController.text,
                            );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
