import 'package:todo_app/blocs/base_bloc.dart';
import 'package:todo_app/models/data_repository/todo_repository.dart';
import 'package:todo_app/models/objects/todo.dart';
import 'package:todo_app/services/api_response.dart';
import 'package:todo_app/utils/constant.dart';

class TodoBloc extends BaseBloc<List<Todo>> {
  final StatusTask statusTodo;
  final bool isRead;

  TodoRepository _todoRepository;

  TodoBloc({this.isRead = true, this.statusTodo}) {
    _todoRepository = TodoRepository();
    if (isRead) {
      initData();
    }
  }

  void initData() {
    if (statusTodo == StatusTask.complete) {
      fetchCompleteTodo();
    } else if (statusTodo == StatusTask.incomplete) {
      fetchIncompleteTodo();
    } else {
      fetchAllTodo();
    }
  }

  Future fetchAllTodo() async {
    baseSink.add(ApiResponse.loading(''));
    try {
      List<Todo> list = await _todoRepository.getAllTodo();
      baseSink.add(ApiResponse.completed(list));
    } catch (ex) {
      final args = ex.toString().split("-");
      if (args.length > 1) {
        baseSink.add(ApiResponse.error(args[0], errorCode: args[1].trim()));
      } else {
        baseSink.add(ApiResponse.error(ex.toString()));
      }
    }
  }

  Future fetchCompleteTodo() async {
    baseSink.add(ApiResponse.loading(''));
    try {
      List<Todo> list = await _todoRepository.getTodoByStatus(true);
      baseSink.add(ApiResponse.completed(list));
    } catch (ex) {
      final args = ex.toString().split("-");
      if (args.length > 1) {
        baseSink.add(ApiResponse.error(args[0], errorCode: args[1].trim()));
      } else {
        baseSink.add(ApiResponse.error(ex.toString()));
      }
    }
  }

  Future fetchIncompleteTodo() async {
    baseSink.add(ApiResponse.loading(''));
    try {
      List<Todo> list = await _todoRepository.getTodoByStatus(false);
      baseSink.add(ApiResponse.completed(list));
    } catch (ex) {
      final args = ex.toString().split("-");
      if (args.length > 1) {
        baseSink.add(ApiResponse.error(args[0], errorCode: args[1].trim()));
      } else {
        baseSink.add(ApiResponse.error(ex.toString()));
      }
    }
  }

  Future createNewTask(String name, bool statusTask) async {
    baseSink.add(ApiResponse.loading(''));
    try {
      int results = await _todoRepository.createTask(name, statusTask);
      print("add Successs - $results");
      await Future.delayed(const Duration(milliseconds: 600));
      List<Todo> list = [];
      baseSink.add(ApiResponse.completed(list));
    } catch (ex) {
      final args = ex.toString().split("-");
      if (args.length > 1) {
        baseSink.add(ApiResponse.error(args[0], errorCode: args[1].trim()));
      } else {
        baseSink.add(ApiResponse.error(ex.toString()));
      }
    }
  }

  Future updateTask(Todo todo) async {
    baseSink.add(ApiResponse.loading(''));
    try {
      int results = await _todoRepository.updateTask(todo);
      print("update successs - $results");
      initData();
    } catch (ex) {
      final args = ex.toString().split("-");
      if (args.length > 1) {
        baseSink.add(ApiResponse.error(args[0], errorCode: args[1].trim()));
      } else {
        baseSink.add(ApiResponse.error(ex.toString()));
      }
    }
  }

  Future deleteTask(Todo todo) async {
    baseSink.add(ApiResponse.loading(''));
    try {
      int results = await _todoRepository.deleteTask(todo);
      print("delete successs - $results");
      initData();
    } catch (ex) {
      final args = ex.toString().split("-");
      if (args.length > 1) {
        baseSink.add(ApiResponse.error(args[0], errorCode: args[1].trim()));
      } else {
        baseSink.add(ApiResponse.error(ex.toString()));
      }
    }
  }
}
