import 'package:flutter/material.dart';
import 'package:fire_chat/core/extensions/context.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget(this.error, {super.key});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Failed: $error', style: context.textTheme.bodyMedium,));
  }
}
