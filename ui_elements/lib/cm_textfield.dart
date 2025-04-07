import 'package:flutter/material.dart';
import 'package:ui_elements/theme/theme_extensions.dart';

class CMTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool canWrapLines;

  const CMTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.canWrapLines = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(labelText!, style: context.textTheme().labelLarge),
          ),
        TextField(
          controller: controller,
          keyboardType:
              canWrapLines ? TextInputType.multiline : TextInputType.text,
          maxLines: canWrapLines ? null : 1,
          minLines: 1,
          decoration: InputDecoration(
            filled: true,
            fillColor: context.colorScheme().surfaceContainerHigh,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
