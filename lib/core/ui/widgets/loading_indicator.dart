import 'package:flutter/material.dart';
import 'package:fire_chat/core/extensions/context.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: context.colorScheme.onSecondary),
    );
  }
}
