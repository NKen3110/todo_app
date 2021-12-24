import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/blocs/todo_bloc.dart';
import 'package:todo_app/components/custom_app_bar..dart';
import 'package:todo_app/models/objects/todo.dart';
import 'package:todo_app/navigator/router.dart';
import 'package:todo_app/services/api_response.dart';
import 'package:todo_app/utils/constant.dart';

class IncompleteTodoScreen extends StatefulWidget {
  final String title;
  final void Function(String,
      {Map<String, dynamic> args, void Function(Object) onDone}) navigator;

  const IncompleteTodoScreen({Key key, this.title, this.navigator})
      : super(key: key);

  @override
  _IncompleteTodoScreenState createState() => _IncompleteTodoScreenState();
}

class _IncompleteTodoScreenState extends State<IncompleteTodoScreen> {
  TodoBloc todoBloc;
  List<Todo> lstTodo = [];

  @override
  void initState() {
    super.initState();
    todoBloc = TodoBloc(statusTodo: StatusTask.incomplete);
    _streamListener();
  }

  _streamListener() {
    todoBloc.baseStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          lstTodo.clear();
          setState(() => lstTodo.addAll(snapshot.data));
          break;
        case Status.ERROR:
          widget.navigator(exceptionScreen,
              args: {
                "message": snapshot.message,
                "errorCode": snapshot.errorCode
              },
              onDone: (value) => todoBloc.fetchAllTodo());
          break;
      }
    });
  }

  Widget _buildCellTodo(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) => todoBloc.deleteTask(lstTodo[index]),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 70,
        child: Row(
          children: [
            Container(
                color: Colors.transparent,
                width: size.width / 2,
                child: Text(
                  lstTodo[index].name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                color: Colors.transparent,
                width: size.width / 3,
                child: const Text(
                  "complete",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Checkbox(
                  value: lstTodo[index].status,
                  onChanged: (value) {
                    todoBloc.updateTask(lstTodo[index]);
                    // setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black26))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        type: "mainbar",
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.all(10),
            color: kDarkSystemColor,
            child: Row(
              children: [
                Container(
                    color: Colors.transparent,
                    width: size.width / 2,
                    child: const Text(
                      'Task Name',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70),
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.transparent,
                    width: size.width / 3,
                    child: const Text(
                      'Status',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70),
                    )),
                Container(color: Colors.transparent),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: lstTodo.length, itemBuilder: _buildCellTodo)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    todoBloc.dispose();
    super.dispose();
  }
}
