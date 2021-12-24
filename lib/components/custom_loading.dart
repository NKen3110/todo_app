import 'package:flutter/material.dart';

class CustomLoading {
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key,
      {String loadingMessage = "",
      String type,
      Color indicatorColor = Colors.white}) async {
    Widget loading = CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(indicatorColor));

    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.transparent,
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          loading,
                          const SizedBox(height: 10),
                          Text(
                            loadingMessage,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]));
        });
  }

  static Future<void> hideLoadingDialog(GlobalKey key) async {
    Navigator.of(key.currentContext, rootNavigator: true).pop();
  }
}
