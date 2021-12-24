import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:todo_app/services/api_response.dart';
import 'package:todo_app/services/datasource/database.dart';

class BaseBloc<T> {
  StreamController<ApiResponse<T>> _streamController;

  StreamSink<ApiResponse<T>> get baseSink => _streamController.sink;

  Stream<ApiResponse<T>> get baseStream => _streamController.stream;

  BaseBloc() {
    _streamController = StreamController<ApiResponse<T>>.broadcast();
  }

  dispose() {
    _streamController?.close();
    // SQLiteDbProvider.instance.closeDB();
    if (kDebugMode) {
      print('Close $T Stream');
    }
  }
}
