class TaskNameFieldValidator {
  static String validate(String value) {
    return checkStringEmpty(value) ? "Task name is required" : null;
  }
}

bool checkStringEmpty(String value) {
  if (value == null || value.trim() == '') {
    return true;
  }
  return false;
}
