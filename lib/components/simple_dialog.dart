import 'package:flutter/material.dart';
import 'package:todo_app/utils/constant.dart';

class CustomSimpleDialog {
  static Future<void> showSimpleDialog(BuildContext context,
      {GlobalKey key,
      String title = "",
      String content = "",
      TypeDialog type = TypeDialog.info,
      VoidCallback onDone}) async {
    final Size size = MediaQuery.of(context).size;
    Widget header;
    switch (type) {
      case TypeDialog.info:
        header = Row(
          children: [
            const Icon(Icons.info_rounded),
            const SizedBox(width: 5),
            Text(title),
          ],
        );
        break;
      case TypeDialog.warning:
        header = Row(
          children: [
            const Icon(
              Icons.warning_rounded,
              color: kWarningColor,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(color: kWarningColor),
            ),
          ],
        );
        break;
      case TypeDialog.error:
        header = Row(
          children: [
            const Icon(
              Icons.error_rounded,
              color: kDarkPastelRedColor,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(color: kDarkPastelRedColor),
            ),
          ],
        );
        break;
      default:
        header = Row(
          children: [
            const Icon(
              Icons.warning_rounded,
              color: Colors.yellow,
            ),
            const SizedBox(width: 5),
            Text(title),
          ],
        );
        break;
    }

    return showGeneralDialog<void>(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        pageBuilder: (context, animation1, animation2) {},
        transitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;

          return Transform(
            transform: Matrix4.translationValues(0.0, -curvedValue * 600, 0.0),
            child: WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                titlePadding: const EdgeInsets.all(0),
                // contentPadding: EdgeInsets.all(0),
                title: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  height: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: kLightBlue1Color,
                  ),
                  child: header,
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: Text(
                      content,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: kLightBlue1Color),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        onDone();
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
