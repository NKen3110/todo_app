import 'package:flutter/material.dart';
import 'package:todo_app/blocs/todo_bloc.dart';
import 'package:todo_app/components/simple_dialog.dart';
import 'package:todo_app/models/objects/todo.dart';
import 'package:todo_app/navigator/router.dart';
import 'package:todo_app/services/api_response.dart';
import 'package:todo_app/src/create_task_screen.dart';
import 'package:todo_app/utils/constant.dart';

class AllTodoScreen extends StatefulWidget {
  final String title;
  final void Function(String,
      {Map<String, dynamic> args, void Function(Object) onDone}) navigator;

  const AllTodoScreen({Key key, this.title = "", this.navigator})
      : super(key: key);

  @override
  _AllTodoScreenState createState() => _AllTodoScreenState();
}

class _AllTodoScreenState extends State<AllTodoScreen> {
  TodoBloc todoBloc;
  List<Todo> lstTodo = [];

  @override
  void initState() {
    super.initState();
    todoBloc = TodoBloc();
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
          if (snapshot.errorCode != null && snapshot.errorCode == "404") {
            CustomSimpleDialog.showSimpleDialog(context,
                content: snapshot.message,
                type: TypeDialog.error,
                onDone: () => {});
          } else {
            widget.navigator(exceptionScreen,
                args: {
                  "message": snapshot.message,
                  "errorCode": snapshot.errorCode
                },
                onDone: (value) => todoBloc.fetchAllTodo());
          }
          break;
      }
    });
  }

  Widget _buildCellTodo(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;

    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
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
                child: Text(
                  lstTodo[index].status
                      ? StatusTask.complete.toString().split('.').last
                      : StatusTask.incomplete.toString().split('.').last,
                  style: const TextStyle(
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

  Widget _buildAppBar() {
    return AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: const Icon(Icons.add_circle),
          onPressed: () => {
            // Navigator.of(context, rootNavigator: true)
            //     .pushNamed(createTaskScreen),
            widget.navigator(createTaskScreen, onDone: (value) {}),
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(),
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
