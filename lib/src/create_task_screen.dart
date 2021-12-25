import 'package:flutter/material.dart';
import 'package:todo_app/blocs/todo_bloc.dart';
import 'package:todo_app/components/custom_app_bar..dart';
import 'package:todo_app/components/custom_loading.dart';
import 'package:todo_app/components/input_form_field.dart';
import 'package:todo_app/navigator/router.dart';
import 'package:todo_app/services/api_response.dart';
import 'package:todo_app/utils/constant.dart';
import 'package:todo_app/utils/helper.dart';

class CreateTaskScreen extends StatefulWidget {
  final String title;

  const CreateTaskScreen({Key key, this.title}) : super(key: key);

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _saveFormKey = GlobalKey<FormState>();
  final _regisNameController = TextEditingController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  AutovalidateMode _regisNameValidateMode = AutovalidateMode.disabled;

  StatusTask _statusTask = StatusTask.incomplete;

  TodoBloc todoBloc;

  @override
  void initState() {
    super.initState();
    todoBloc = TodoBloc(isRead: false);
    _streamBuilder();
  }

  _streamBuilder() {
    todoBloc.baseStream.listen((snapshot) {
      switch (snapshot.status) {
        case Status.LOADING:
          CustomLoading.showLoadingDialog(context, _keyLoader);
          break;
        case Status.COMPLETED:
          CustomLoading.hideLoadingDialog(_keyLoader);
          Navigator.pushNamed(context, mainTabs);
          break;
        case Status.ERROR:
          CustomLoading.hideLoadingDialog(_keyLoader);
          Navigator.pushNamed(context, exceptionScreen, arguments: {
            "message": snapshot.message,
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BoxShadow boxShadow = const BoxShadow(
      // spreadRadius: 5.0,
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: widget.title,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          margin:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, color: Colors.black, offset: Offset(1, 3)),
              ],
              color: Colors.white),
          child: Form(
            key: _saveFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                InputFormField(
                  autovalidateMode: _regisNameValidateMode,
                  controller: _regisNameController,
                  hintText: 'Enter Task Name',
                  // hintTextColor: Colors.white70,
                  // textColor: Colors.white70,
                  fillColor: Colors.white,
                  // cursorColor: Colors.white70,
                  prefixIcon: const Icon(Icons.task, color: kLightBlue1Color),
                  validator: (value) => TaskNameFieldValidator.validate(value),
                  boxShadow: [boxShadow],
                  onChanged: (value) {
                    setState(() {
                      _regisNameValidateMode =
                          AutovalidateMode.onUserInteraction;
                    });
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: size.width * 0.8,
                  child: const Text(
                    "Status Task: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: ListTile(
                    title: const Text(
                      'Complete',
                    ),
                    leading: Radio<StatusTask>(
                      // fillColor: MaterialStateProperty.resolveWith(
                      //     (states) => Colors.white70),
                      value: StatusTask.complete,
                      groupValue: _statusTask,
                      onChanged: (StatusTask value) {
                        setState(() {
                          _statusTask = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: ListTile(
                    title: const Text(
                      'Incomplete',
                    ),
                    leading: Radio<StatusTask>(
                      // fillColor: MaterialStateProperty.resolveWith(
                      //     (states) => Colors.white70),
                      value: StatusTask.incomplete,
                      groupValue: _statusTask,
                      onChanged: (StatusTask value) {
                        setState(() {
                          _statusTask = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_saveFormKey.currentState.validate()) {
                        todoBloc.createNewTask(_regisNameController.text,
                            _statusTask == StatusTask.complete ? true : false);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.save_alt_rounded),
                        SizedBox(width: 10),
                        Text(
                          "Save",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(primary: kLightBlue1Color),
                  ),
                ),
                // const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    todoBloc.dispose();
    _regisNameController.dispose();
    super.dispose();
  }
}
