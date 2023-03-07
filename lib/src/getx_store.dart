// getx_store.dart

import 'package:get/get.dart';
import 'package:reduced/reduced.dart';

/// Derivation of the class [GetxController] with support of the [ReducedStore] interface.
class Store<S> extends GetxController implements ReducedStore<S> {
  Store(S state) : _state = state;

  S _state;

  @override
  get state => _state;

  @override
  reduce(reducer) {
    _state = reducer(_state);
    update();
  }
}
