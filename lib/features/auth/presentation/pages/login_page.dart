import 'package:fire_chat/core/constants/validators.dart';
import 'package:fire_chat/features/auth/presentation/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Login'),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            context.go('/chat-room');
          }
          else if (state.status == AuthStatus.error) {
            context.showSnackBarMessage(context, message: state.error ?? 'An error occurred');
          }
        },
        builder: (context, state) {

          final authCubit = context.read<AuthCubit>();
          final isLoading = state.status == AuthStatus.loading;

          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text('FireChat', style: context.textTheme.headlineLarge),
                            SizedBox(height: 16),
                            AppTextField(
                              controller: _emailController,
                              onChanged: authCubit.emailChanged,
                              keyboardType: TextInputType.emailAddress,
                              label: 'Email',
                              hint: 'Enter your email here ...',
                              validator: (value) {

                                if(Validators.isFieldEmpty(value)) {
                                  return 'Email is required';
                                }

                                if (!Validators.isEmailValid(value)) {
                                  return 'Please enter a valid email';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            AppTextField.password(
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                              label: 'Password',
                              hint: 'Enter password ...',
                              onChanged: authCubit.passwordChanged,
                              validator: (value) {
                                if (Validators.isFieldEmpty(value)) {
                                  return 'Password is required';
                                }

                                if ((value?.length ?? 0) < 8) {
                                  return 'Password must be at least 8 characters';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    context.push('/forgot-password');
                                  },
                                  child: Text('Forgot Password'),
                                ),
                              ],
                            ),

                            SizedBox(height: 16),
                            AppButton(
                              isLoading: isLoading,
                              onPressed: isLoading ? null : () {

                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                context.read<AuthCubit>().login();
                              },
                              text: 'Login',
                            ),
                            SizedBox(height: 16),
                            RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: context.textTheme.bodyLarge,
                                children: [
                                  TextSpan(
                                    text: "Register",
                                    style: context.textTheme.titleMedium,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.push('/register');
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
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
