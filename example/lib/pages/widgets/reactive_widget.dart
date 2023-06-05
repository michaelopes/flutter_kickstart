import 'package:example/app_reactive.dart';
import 'package:example/global_reactive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import '../main/main_viewmodel.dart';

class ReactiveWidget extends FkSimpleView<GlobalReactive> {
  ReactiveWidget({super.key}) : super(reactive: GlobalReactive());

  t() {
    var sd = context;
  }

  @override
  Widget builder(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Column(
        children: [
          Text(reactive.counter.toString()),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              reactive.counter++;
            },
            child: const Text("Increment"),
          )
        ],
      ),
    );
  }
}
