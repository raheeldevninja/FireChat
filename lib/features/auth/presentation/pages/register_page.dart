import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fire_chat/features/auth/presentation/auth.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterView();
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.go('/chat-rooms');
        }
        else if (state.status == AuthStatus.error) {
          context.showSnackBarMessage(context, message: state.error ?? 'An error occurred');
        }
      },
      builder: (context, state) {

        final authCubit = context.read<AuthCubit>();
        final isLoading = state.status == AuthStatus.loading;

        return Scaffold(
          appBar: BaseAppBar(
            title: 'Register',
            showBackButton: true,
            isLoading: isLoading,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(
                              'FireChat',
                              style: context.textTheme.headlineLarge,
                            ),
                            SizedBox(height: 16),
                            AppTextField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              label: 'Name',
                              hint: 'Enter your name here ...',
                              onChanged: authCubit.nameChanged,
                              validator: (value) {
                                if (Validators.isFieldEmpty(value)) {
                                  return 'Name is required';
                                }

                                if ((value?.length ?? 0) < 3) {
                                  return 'Name must be at least 3 characters';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            AppTextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              label: 'Email',
                              hint: 'Enter your email here ...',
                              onChanged: authCubit.emailChanged,
                              validator: (value) {
                                if (Validators.isFieldEmpty(value)) {
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
                            AppButton(
                              isLoading: isLoading,
                              onPressed: isLoading ? null : () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                context.read<AuthCubit>().register();
                              },
                              text: 'Register',
                            ),
                            SizedBox(height: 16),
                            RichText(
                              text: TextSpan(
                                text: "Already have an account? ",
                                style: context.textTheme.bodyLarge,
                                children: [
                                  TextSpan(
                                    text: "Login",
                                    style: context.textTheme.titleMedium,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.pop();
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
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
