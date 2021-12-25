import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/components/input_form_field.dart';
import 'package:todo_app/navigator/router.dart';
import 'package:todo_app/src/create_task_screen.dart';
import 'package:todo_app/utils/constant.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

final mockObserver = MockNavigatorObserver();
Widget createNewTaskScreen() => MaterialApp(
      home: const CreateTaskScreen(),
      onGenerateRoute: getRoute,
      navigatorObservers: [mockObserver],
      // routes: Routes.routes(),
    );

void main() {
  group('New Task Page Widget Tests:', () {
    testWidgets("Testing Input Field", (tester) async {
      await tester.pumpWidget(createNewTaskScreen());
      expect(find.byType(InputFormField), findsOneWidget);
    });

    testWidgets("Testing Radio Button", (tester) async {
      await tester.pumpWidget(createNewTaskScreen());
      expect(find.byType(ListTile), findsWidgets);
      expect(
          find.byWidgetPredicate(
            (widget) => widget is Radio<StatusTask>,
          ),
          findsNWidgets(2));
    });

    testWidgets("Testing Back Button", (tester) async {
      await tester.pumpWidget(createNewTaskScreen());
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets("Testing Save Button", (tester) async {
      await tester.pumpWidget(createNewTaskScreen());
      expect(find.byIcon(Icons.save_alt_rounded), findsOneWidget);
      expect(find.text("Save"), findsOneWidget);

      await tester.tap(find.byIcon(Icons.save_alt_rounded).first);
      await tester.pumpAndSettle();
    });
  });
}
