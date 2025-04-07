import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../todo/add/view/add_todo_page.dart';
import '../todo/list/view/todo_list_page.dart';

abstract class RouteProtocol {
  final String routePath;
  String get routeName;

  const RouteProtocol({required this.routePath});
}

enum AppRoute implements RouteProtocol {
  root('/'),
  addTodo('/add-todo');

  @override
  final String routePath;
  @override
  String get routeName => name;

  const AppRoute(this.routePath);
}

final appRouterConfig = GoRouter(
  initialLocation: AppRoute.root.routePath,
  routes: [
    GoRoute(
      name: AppRoute.root.routeName,
      path: AppRoute.root.routePath,
      builder: (context, state) {
        return TodoListPage();
      },
    ),
    GoRoute(
      name: AppRoute.addTodo.routeName,
      path: AppRoute.addTodo.routePath,
      builder: (context, state) {
        return AddTodoPage();
      },
    ),
  ],
);

extension RouterNavigation on BuildContext {
  void goRoute(
    RouteProtocol route, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    goNamed(
      route.routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void replaceRoute(
    RouteProtocol route, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    replaceNamed(
      route.routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  Future<T?> pushRoute<T extends Object?>(
    RouteProtocol route, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return pushNamed<T>(
      route.routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }
}
