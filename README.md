# CheckMate - A Sample TODO App

This sample TODO app workspace consists of a `todo_app` Flutter app, and a `ui_elements` widgets library and branding Dart package.
It is powered by melos to manage these dependencies in a monorepo.

## Getting started

### 1. (If applicable) install melos

```zsh
dart pub global activate melos
```

### 2. Bootstrap the melos project

```zsh
melos bootstrap
```

### 3. Run the custom script to setup the project

This will fetch all dependencies, and will generate all the required generated code.

```zsh
melos run setup
```

### 4. You are now ready to start the app!

Optionally you can use the custom script:

```zsh
melos run start
```

Or you can `cd` into `todo_app/` yourself and run there using the standard `flutter run`.
You could also use whichever IDE extension of your choice!

## Architecture

The app is built following the MVVM pattern, using `ƒlutter_riverpod`. 
It uses the `riverpod_annotation` code generation tools to simplify the riverpod syntax.

It is simply a dummy app, but demonstrates how a `ViewModel` would delegate to a `Service` layer, which would delegate to a `Repository` layer.

The `ViewModel` performs the UI business logic, and the `Service` performs any data manipulation logic.

The `Repository` simply acts as a data retrieval and storage layer which could communicate with some backend, or could be stored locally on the phone. For this mock project, a dummy mock repository is added that simply stores the TODO list in-memory.

The app is built to also demonstrate how you would potentially handle async todo list fetching, adding a todo, and checking/unchecking a todo. In an implementation where the TODO list is stored on the phone itself, this could be unnecessary.

## Tests

There are unit tests written for the `ViewModel`s and `Service`s, using `mocktail` for mocking.

To run these easily, a melos script is defined:

```zsh
melos run test
```