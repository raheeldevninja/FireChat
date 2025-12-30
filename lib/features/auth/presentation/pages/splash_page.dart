import 'package:flutter/material.dart';
import 'package:fire_chat/features/auth/presentation/auth.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('FireChat', style: context.textTheme.headlineLarge),
              const SizedBox(height: 16),
              LoadingIndicator(size: 32),
            ],
          ),
        ),
      ),
    );
  }
}
