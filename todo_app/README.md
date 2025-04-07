# todo_app

A TODO app made with Flutter for iOS and Android.

## Getting Started

### 1. Run the code generator

```zsh
dart run build_runner build --delete-conflicting-outputs
```

### 2. Generating the Dart localization key constants

```zsh
dart run easy_localization:generate -S assets/translations -f json -O lib/app/localization/generated -o locale_json.g.dart
dart run easy_localization:generate -S assets/translations -f keys -O lib/app/localization/generated -o locale_keys.g.dart
```