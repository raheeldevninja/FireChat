import 'package:flutter/material.dart';
import 'package:fire_chat/core/extensions/context.dart';

class ErrorLayout extends StatelessWidget {
  const ErrorLayout(this.error, {super.key});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Failed: $error', style: context.textTheme.bodyMedium,));
  }
}
