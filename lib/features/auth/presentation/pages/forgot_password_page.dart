import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fire_chat/features/auth/presentation/auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {

        if (state.status == AuthStatus.passwordReset) {

          context.showSnackBarMessage(
            context,
            message: "Password reset email sent!",
            contentType: ContentType.success,
          );

          Future.delayed(const Duration(milliseconds: 300), () {
            if (context.mounted) context.pop();
          });

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
            title: 'Forgot Password',
            isLoading: isLoading,
            showBackButton: true,
          ),
          body: Padding(
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
                  AppButton(
                    isLoading: isLoading,
                    onPressed: isLoading ? null : () {

                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      context.read<AuthCubit>().sendResetPasswordEmail();
                    },
                    text: 'Reset Password',
                  ),

                ],
              ),
            ),
          ),
        );
      },

    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

}
