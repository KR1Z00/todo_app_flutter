import 'package:flutter/material.dart';

class CMSecondaryButton extends StatelessWidget {
  static const double preferredHeight = 48;

  final Icon? icon;
  final Widget label;
  final void Function() onPressed;

  const CMSecondaryButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(onPressed: onPressed, icon: icon, label: label);
  }
}
