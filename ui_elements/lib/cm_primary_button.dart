import 'package:flutter/material.dart';

class CMPrimaryButton extends StatelessWidget {
  static const double preferredHeight = 48;

  final Widget? icon;
  final Widget label;
  final void Function()? onPressed;

  const CMPrimaryButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(onPressed: onPressed, icon: icon, label: label);
  }
}
