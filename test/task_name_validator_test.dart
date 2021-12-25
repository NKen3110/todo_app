import 'package:test/test.dart';
import 'package:todo_app/utils/helper.dart';

void main() {
  test("empty task name returns error string", () {
    var result = TaskNameFieldValidator.validate("");
    expect(result, "Task name is required");
  });

  test("non-empty task name returns null", () {
    var result = TaskNameFieldValidator.validate("todo");
    expect(result, null);
  });
}
