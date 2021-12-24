import 'package:flutter/material.dart';
import 'package:todo_app/navigator/router.dart';
import 'package:todo_app/navigator/tab_navigator.dart';
import 'package:todo_app/utils/constant.dart';

class MainTabs extends StatefulWidget {
  const MainTabs({Key key}) : super(key: key);

  @override
  _MainTabsState createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  String _currentPage = allTodoScreen;
  List<String> pageKeys = [
    allTodoScreen,
    completeTodoScreen,
    incompleteTodoScreen
  ];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    allTodoScreen: GlobalKey<NavigatorState>(),
    completeTodoScreen: GlobalKey<NavigatorState>(),
    incompleteTodoScreen: GlobalKey<NavigatorState>(),
  };
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _selectTab(int index, String tabItem) {
    // print('current page - $_currentPage - tab - $tabItem');
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      // _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
      setState(() {
        _currentPage = pageKeys[index];
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(ModalRoute.of(context).settings.name);
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != allTodoScreen) {
            _selectTab(1, allTodoScreen);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        // drawer: CustomSideDrawer(),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _buildOffstageNavigator(_currentPage),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: kLightBlue4Color,
          currentIndex: selectedIndex,
          onTap: (index) => _selectTab(index, pageKeys[index]),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: "All Todo"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_rounded), label: "Complete"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_rounded), label: "Incomplete"),
          ],
        ),
      ),
    );
  }

  void handleNavigator(String routeName,
      {Map<String, dynamic> args, void Function(Object) onDone}) {
    Navigator.of(context).pushNamed(routeName, arguments: args).then(onDone);
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      key: ValueKey<int>(selectedIndex),
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
        navigator: handleNavigator,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
