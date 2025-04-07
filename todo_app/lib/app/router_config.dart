import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/add_todo/view/add_todo_page.dart';
import 'package:todo_app/todo_list/view/todo_list_page.dart';

enum AppRoute {
  root('/'),
  addTodo('/add-todo');

  final String routePath;

  const AppRoute(this.routePath);
}

final appRouterConfig = GoRouter(
  initialLocation: AppRoute.root.routePath,
  routes: [
    GoRoute(
      path: AppRoute.root.routePath,
      builder: (context, state) {
        return TodoListPage();
      },
    ),
    GoRoute(
      path: AppRoute.addTodo.routePath,
      builder: (context, state) {
        return AddTodoPage();
      },
    ),
  ],
);

extension RouterNavigation on BuildContext {
  void goAppRoute(AppRoute route) {
    go(route.routePath);
  }

  void pushAppRoute(AppRoute route) {
    push(route.routePath);
  }
}
