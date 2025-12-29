import 'package:flutter/material.dart';
import 'package:fire_chat/core/extensions/context.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({this.size, super.key});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          color: context.colorScheme.onSecondary),
      ),
    );
  }
}
