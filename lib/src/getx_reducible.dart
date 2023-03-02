// getx_reducible.dart

import 'package:get/get.dart';
import 'package:reduced/reduced.dart';

/// Derivation of the class [GetxController] with support of the [Reducible] interface.
class ReducibleGetx<S> extends GetxController
    implements Reducible<S> {
  ReducibleGetx(S state) : _state = state;

  S _state;

  @override
  get state => _state;

  @override
  reduce(reducer) {
    _state = reducer(_state);
    update();
  }
}
