import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData theme() => Theme.of(this);
  TextTheme textTheme() => theme().textTheme;
  ColorScheme colorScheme() => theme().colorScheme;
}
