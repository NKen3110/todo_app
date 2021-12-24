import 'package:flutter/material.dart';
import 'package:todo_app/navigator/router.dart';

class ExceptionScreen extends StatelessWidget {
  final Map<String, dynamic> args;

  const ExceptionScreen({Key key, this.args}) : super(key: key);

  Widget _buildButton(BuildContext context) {
    String title = "Home";
    VoidCallback handleNavigator =
        () => Navigator.popUntil(context, ModalRoute.withName(root));

    if (args['errorCode'] != null && args['errorCode'] == '404') {
      title = "Create Task";
      handleNavigator = () => Navigator.pushNamed(context, createTaskScreen);
    }

    return ElevatedButton(onPressed: handleNavigator, child: Text(title));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Text(
              args["message"],
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          _buildButton(context)
        ],
      ),
    );
  }
}
