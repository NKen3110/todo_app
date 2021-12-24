import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_app/src/all_too_screen.dart';
import 'package:todo_app/src/complete_todo_screen.dart';
import 'package:todo_app/src/create_task_screen.dart';
import 'package:todo_app/src/exception_screen.dart';
import 'package:todo_app/src/incomplete_todo_screen.dart';
import 'package:todo_app/src/main_tabs.dart';

const root = "/";
const mainTabs = "/main_tabs";
const allTodoScreen = "/all_todo";
const completeTodoScreen = "/complete_todo";
const incompleteTodoScreen = "/incomplete_todo";
const exceptionScreen = "/exception";
const createTaskScreen = "/create_task";

Route<dynamic> getRoute(RouteSettings settings,
    {String tabName,
    final void Function(String,
            {Map<String, dynamic> args, void Function(Object) onDone})
        navigator}) {
  switch (settings.name) {
    case root:
      Widget builder = AllTodoScreen(
        title: "All Todo",
        navigator: navigator,
      );
      if (tabName == completeTodoScreen) {
        builder = CompleteTodoScreen(
          title: 'Complete Todo',
          navigator: navigator,
        );
      } else if (tabName == incompleteTodoScreen) {
        builder = IncompleteTodoScreen(
          title: 'Incomplete Todo',
          navigator: navigator,
        );
      }
      return _buildRoute(settings, builder);
    case mainTabs:
      Widget builder = const MainTabs();
      return _buildRouteWithTransition(settings, builder);
    case createTaskScreen:
      return _buildRoute(
          settings,
          const CreateTaskScreen(
            title: "Create Task",
          ));
    case exceptionScreen:
      return _buildRoute(
          settings,
          ExceptionScreen(
            args: settings.arguments,
          ));
    default:
      return null;
      break;
  }
}

PageTransition _buildRouteWithTransition(RouteSettings settings, Widget builder,
    {PageTransitionType type = PageTransitionType.fade, int duration = 1500}) {
  return PageTransition(
      settings: settings,
      child: builder,
      type: type,
      duration: Duration(milliseconds: duration));
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => builder,
  );
}
