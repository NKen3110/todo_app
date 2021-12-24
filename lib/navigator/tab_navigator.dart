import 'package:flutter/material.dart';
import 'package:todo_app/navigator/router.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  final void Function(String,
      {Map<String, dynamic> args, void Function(Object) onDone}) navigator;

  const TabNavigator({Key key, this.navigatorKey, this.tabItem, this.navigator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (setting) {
        return getRoute(setting, tabName: tabItem, navigator: navigator);
      },
    );
  }
}
