import 'package:flutter/material.dart';

import '../../domain/interfaces/custom_controller.dart';

class CustomListenableBuilder<T, E, S> extends StatelessWidget {
  const CustomListenableBuilder({
    super.key,
    required this.controller,
    required this.builder,
  });

  final CustomController<E, S> controller;
  final Widget Function(
    BuildContext context,
    S state,
    bool isLoading,
    bool hasError,
    E? error,
  )
  builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        return builder(
          context,
          state,
          controller.isLoading,
          controller.hasError,
          controller.error,
        );
      },
    );
  }
}
