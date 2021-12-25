import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/navigator/router.dart';
import 'package:todo_app/src/all_too_screen.dart';
import 'package:todo_app/src/complete_todo_screen.dart';
import 'package:todo_app/src/create_task_screen.dart';
import 'package:todo_app/src/incomplete_todo_screen.dart';
import 'package:todo_app/src/main_tabs.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

final mockObserver = MockNavigatorObserver();
Widget createMainTabsScreen() => MaterialApp(
      home: const MainTabs(),
      onGenerateRoute: getRoute,
      navigatorObservers: [mockObserver],
    );
void main() {
  group('Main Tabs Page Widget Tests:', () {
    testWidgets('Testing if ListView shows up', (tester) async {
      await tester.pumpWidget(createMainTabsScreen());
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Testing if Checkbox not shows up', (tester) async {
      await tester.pumpWidget(createMainTabsScreen());
      expect(find.byType(Checkbox), findsNothing);
    });

    testWidgets('Testing Bottom Navigation Bar', (tester) async {
      await tester.pumpWidget(createMainTabsScreen());
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      await tester.tap(find.byIcon(Icons.home_rounded));
      await tester.pumpAndSettle();
      expect(find.byType(AllTodoScreen), findsOneWidget);
      print('clicked on All Todo');

      await tester.tap(find.byIcon(Icons.list_alt_rounded));
      await tester.pumpAndSettle();
      expect(find.byType(CompleteTodoScreen), findsOneWidget);
      print('clicked on Complete');

      await tester.tap(find.byIcon(Icons.list_rounded));
      await tester.pumpAndSettle();
      expect(find.byType(IncompleteTodoScreen), findsOneWidget);
      print('clicked on Incomplete');

      expect(find.text('All Todo'), findsOneWidget);
      expect(find.text('Complete'), findsOneWidget);
      expect(find.text('Incomplete'), findsOneWidget);
    });

    testWidgets("Testing create new task button", (WidgetTester tester) async {
      await tester.pumpWidget(createMainTabsScreen());
      expect(find.byIcon(Icons.add_circle), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add_circle).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      verify(mockObserver.didPush(any, any));
      expect(find.byType(CreateTaskScreen), findsOneWidget);
    });
  });
}
