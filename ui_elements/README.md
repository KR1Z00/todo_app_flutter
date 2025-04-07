A package containing the UI elements for the CheckMate TODO list app.

## Features

Contains theming and standard UI elements for the app:
- A root `CMNavigationScrollView` for standardised scrolling behaviour and app bar appearance;
- Standardised buttons e.g. `CMPrimaryButton` and `CMSecondaryButton`;

## Getting started

This package only has basic pub dependencies. To use, simply run `flutter pub get`.

## Usage

1. Import this package in your app.
2. Use one of the `MaterialTheme` factories e.g. `MaterialTheme.dark()` to use the CheckMate theme in your Flutter Material app.
3. When implementing the `body` of a `Scaffold`, use `CMNavigationScrollView`, and pass your content as a `Sliver` for the `childSliver` argument to have standardised app bar appearance and scrolling behaviour.
4. Build your screens using the standardised UI elements provided by this package to ensure consistent CheckMate brand appearance.
