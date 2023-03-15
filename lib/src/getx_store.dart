// getx_store.dart

import 'package:get/get.dart';
import 'package:reduced/reduced.dart';

/// Derivation of the class [GetxController] with support of the [Store] interface.
class GetxControllerStore<S> extends GetxController
    implements Store<S> {
  GetxControllerStore(S state) : _state = state;

  S _state;

  @override
  get state => _state;

  @override
  process(event) {
    _state = event(_state);
    update();
  }
}
