import 'package:fire_chat/core/extensions/context.dart';
import 'package:fire_chat/core/ui/widgets/app_button.dart';
import 'package:fire_chat/core/ui/widgets/app_text_field.dart';
import 'package:fire_chat/core/ui/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthView();
  }
}

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Login'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [

            Text('FireChat', style: context.textTheme.headlineLarge),
            SizedBox(height: 16),
            AppTextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                label: 'Email',
                hint: 'Enter your email here ...',
            ),
            SizedBox(height: 16),
            AppTextField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              label: 'Password',
              hint: 'Enter password ...',
            ),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('Forgot Password'),
                ),
              ],
            ),

            SizedBox(height: 16),
            AppButton(onPressed: () {}, text: 'Login'),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

}
