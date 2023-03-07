// getx_widgets.dart

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reduced/reduced.dart';

import 'getx_store.dart';

void registerState<S>({required S initialState}) {
  Get.put(Store<S>(initialState));
}

class ReducedConsumer<S, P extends Object> extends StatelessWidget {
  const ReducedConsumer({
    super.key,
    required this.transformer,
    required this.builder,
  });

  final ReducedTransformer<S, P> transformer;
  final ReducedWidgetBuilder<P> builder;

  @override
  Widget build(BuildContext context) => GetBuilder<Store<S>>(
        filter: transformer,
        builder: (controller) => builder(props: transformer(controller)),
      );
}
