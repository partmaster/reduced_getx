// getx_wrapper.dart

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reduced/reduced.dart';

import 'getx_reducible.dart';

void registerState<S>({required S initialState}) {
  Get.put(ReducibleGetx<S>(initialState));
}

Widget wrapWithConsumer<S, P extends Object>({
  required ReducedTransformer<S, P> transformer,
  required ReducedWidgetBuilder<P> builder,
}) =>
    GetBuilder<ReducibleGetx<S>>(
      filter: transformer,
      builder: (controller) =>
          builder(props: transformer(controller)),
    );
