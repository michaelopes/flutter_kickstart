import 'package:example/global_reactive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

class ReactiveWidget extends FkWidget<GlobalReactive> {
  ReactiveWidget({super.key}) : super(reactive: GlobalReactive());

  @override
  Widget build(BuildContext context) {
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
