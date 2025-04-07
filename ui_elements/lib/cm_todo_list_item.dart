import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_elements/theme/theme_extensions.dart';

class CMTodoListItem extends StatelessWidget {
  final String title;
  final String description;
  final bool isChecked;

  const CMTodoListItem({
    super.key,
    required this.title,
    required this.description,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme().surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 48,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        isChecked
                            ? context.colorScheme().primary
                            : context.colorScheme().onSurface,
                    width: isChecked ? 3 : 2,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child:
                      isChecked
                          ? Icon(
                            Icons.check,
                            color: context.colorScheme().primary,
                          )
                          : null,
                ),
              ),
            ),
            Gap(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme().titleLarge),
                Text(description),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
