import 'package:fire_chat/core/ui/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: 'Forgot Password',
          showBackButton: true,
      ),
      body: Center(
        child: Text('Forgot Password Page'),
      ),
    );
  }
}
