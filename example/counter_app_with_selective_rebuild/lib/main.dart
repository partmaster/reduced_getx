// main.dart

import 'package:counter_app_with_selective_rebuild/state.dart';
import 'package:flutter/widgets.dart';
import 'package:reduced_getx/reduced_getx.dart';

import 'widgets.dart';

void main() {
  registerState(
    initialState: MyAppState(title: 'reduced_getx example'),
  );
  runApp(const MyApp());
}
