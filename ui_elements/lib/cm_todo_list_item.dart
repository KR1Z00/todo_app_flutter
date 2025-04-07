import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_elements/theme/theme_extensions.dart';

class CMTodoListItem extends StatefulWidget {
  final String title;
  final String description;
  final bool isChecked;
  final bool togglesAsync;
  final bool rejectsTapsWhenLoading;
  final Future<void> Function() didTap;

  const CMTodoListItem({
    super.key,
    required this.title,
    required this.description,
    required this.isChecked,
    this.togglesAsync = true,
    this.rejectsTapsWhenLoading = true,
    required this.didTap,
  });

  @override
  State<CMTodoListItem> createState() => _CMTodoListItemState();
}

class _CMTodoListItemState extends State<CMTodoListItem> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    return Material(
      color: context.colorScheme().surfaceContainer,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () async {
          setState(() {
            if (widget.togglesAsync) {
              _isLoading = true;
            }
          });
          await widget.didTap();
          if (widget.togglesAsync) {
            setState(() {
              _isLoading = false;
            });
          }
        },
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
                          widget.isChecked
                              ? context.colorScheme().primary
                              : context.colorScheme().onSurface,
                      width: widget.isChecked ? 3 : 1,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child:
                        widget.isChecked
                            ? Icon(
                              Icons.check,
                              color: context.colorScheme().primary,
                            )
                            : null,
                  ),
                ),
              ),
              Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: context.textTheme().titleLarge),
                    Text(widget.description),
                  ],
                ),
              ),
              if (_isLoading)
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
