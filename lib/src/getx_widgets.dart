// getx_widgets.dart

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reduced/reduced.dart';

import 'getx_store.dart';

void registerState<S>({required S initialState}) {
  Get.put(GetxControllerStore<S>(initialState));
}

class ReducedConsumer<S, P extends Object> extends StatelessWidget {
  const ReducedConsumer({
    super.key,
    required this.mapper,
    required this.builder,
  });

  final StateToPropsMapper<S, P> mapper;
  final WidgetFromPropsBuilder<P> builder;

  @override
  Widget build(BuildContext context) =>
      GetBuilder<GetxControllerStore<S>>(
        filter: (store) => mapper(store.state, store),
        builder: (controller) => builder(
          props: mapper(
            controller.state,
            controller,
          ),
        ),
      );
}
