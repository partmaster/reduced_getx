import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:reduced/reduced.dart';

import 'package:reduced_getx/reduced_getx.dart';

class Incrementer extends Reducer<int> {
  @override
  int call(int state) {
    return state + 1;
  }
}

void main() {
  test('ReducibleGetx state 0', () {
    final objectUnderTest = ReducibleGetx(0);
    expect(objectUnderTest.state, 0);
  });

  test('ReducibleGetx state 1', () {
    final objectUnderTest = ReducibleGetx(1);
    expect(objectUnderTest.state, 1);
  });

  test('ReducibleGetx reduce', () async {
    final objectUnderTest = ReducibleGetx(0);
    objectUnderTest.reduce(Incrementer());
    expect(objectUnderTest.state, 1);
  });

  test('wrapWithConsumer', () {
    final objectUnderTest = wrapWithConsumer(
      builder: ({Key? key, required int props}) => const SizedBox(),
      transformer: (reducible) => 1,
    );
    expect(objectUnderTest, isA<GetBuilder>());
  });
}
