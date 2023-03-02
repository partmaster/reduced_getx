![GitHub release (latest by date)](https://img.shields.io/github/v/release/partmaster/reduced_getx)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/partmaster/reduced_getx/dart.yml)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/partmaster/reduced_getx)
![GitHub last commit](https://img.shields.io/github/last-commit/partmaster/reduced_getx)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/partmaster/reduced_getx)
# reduced_getx

Implementation of the 'reduced' API for the 'GetX' state management framework with following features:

1. Implementation of the ```Reducible``` interface 
2. Register a state for management.
3. Trigger a rebuild on widgets selectively after a state change.

## Features

#### 1. Implementation of the ```Reducible``` interface 

```dart
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
```

#### 2. Register a state for management.

```dart
void registerState<S>({required S initialState}) {
  Get.put(ReducibleGetx<S>(initialState));
}
```

#### 3. Trigger a rebuild on widgets selectively after a state change.

```dart
Widget wrapWithConsumer<S, P extends Object>({
  required ReducedTransformer<S, P> transformer,
  required ReducedWidgetBuilder<P> builder,
}) =>
    GetBuilder<ReducibleGetx<S>>(
      filter: transformer,
      builder: (controller) =>
          builder(props: transformer(controller)),
    );
```

## Getting started

In the pubspec.yaml add dependencies on the package 'reduced' and on the package  'reduced_getx'.

```
dependencies:
  reduced: ^0.1.0
  reduced_getx: ^0.1.0
```

Import package 'reduced' to implement the logic.

```dart
import 'package:reduced/reduced.dart';
```

Import package 'reduced' to use the logic.

```dart
import 'package:reduced_getx/reduced_getx.dart';
```

## Usage

Implementation of the counter demo app logic with the 'reduced' API without further dependencies on state management packages.

```dart
// logic.dart

import 'package:flutter/material.dart';
import 'package:reduced/reduced.dart';

class Incrementer extends Reducer<int> {
  @override
  int call(int state) => state + 1;
}

class Props {
  Props({required this.counterText, required this.onPressed});
  final String counterText;
  final Callable<void> onPressed;
}

Props transformer(Reducible<int> reducible) => Props(
      counterText: '${reducible.state}',
      onPressed: CallableAdapter(reducible, Incrementer()),
    );

Widget builder({Key? key, required Props props}) => Scaffold(
      appBar: AppBar(title: const Text('reduced_getx example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(props.counterText),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: props.onPressed,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
```

Finished counter demo app using logic.dart and 'reduced_getx' package:

```dart
// main.dart

import 'package:flutter/material.dart';
import 'package:reduced_getx/reduced_getx.dart';
import 'logic.dart';

void main() {
  registerState(initialState: 0);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Builder(
          builder: (context) => wrapWithConsumer(
            transformer: transformer,
            builder: builder,
          ),
        ),
      );
}
```

# Additional information

Implementations of the 'reduced' API are available for the following state management frameworks:

|framework|implementation package for 'reduced' API|
|---|---|
|[Bloc](https://bloclibrary.dev/#/)|[reduced_bloc](https://github.com/partmaster/reduced_bloc)|
|[GetIt](https://pub.dev/packages/get_it)|[reduced_getit](https://github.com/partmaster/reduced_getit)|
|[GetX](https://pub.dev/packages/get)|[reduced_getx](https://github.com/partmaster/reduced_getx)|
|[Redux](https://pub.dev/packages/redux)|[reduced_redux](https://github.com/partmaster/reduced_redux)|
|[Riverpod](https://riverpod.dev/)|[reduced_riverpod](https://github.com/partmaster/reduced_riverpod)|
