import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fire_chat/features/auth/presentation/auth.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {

        if (state.status == AuthStatus.passwordChanged) {
          context.showSnackBarMessage(
            context,
            message: "Password changed successfully!",
            contentType: ContentType.success,
          );

          Future.delayed(const Duration(milliseconds: 300), () {

            if (!context.mounted) {
              return;
            }

            context.read<AuthCubit>().signOut();


          });

        } else if (state.status == AuthStatus.error) {
          context.showSnackBarMessage(context, message: state.error ?? 'An error occurred');
        }


      },
      builder: (context, state) {

        final authCubit = context.read<AuthCubit>();
        final isLoading = state.status == AuthStatus.loading;

        return Scaffold(
          appBar: BaseAppBar(
            title: 'Change Password',
            isLoading: isLoading,
            showBackButton: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  AppTextField.password(
                    controller: _currentPasswordController,
                    label: "Current Password",
                    hint: "Current Password",
                    onChanged: authCubit.passwordChanged,
                    validator: (value) {

                      if (Validators.isFieldEmpty(value)) {
                        return 'Current password is required';
                      }

                      if (value!.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AppTextField.password(
                    controller: _passwordController,
                    label: "New Password",
                    hint: "Enter new password",
                    onChanged: authCubit.newPasswordChanged,
                    validator: (value) {
                      if (Validators.isFieldEmpty(value)) {
                        return 'Password is required';
                      }
                      if (value!.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AppTextField.password(
                    controller: _confirmPasswordController,
                    label: "Confirm Password",
                    hint: "Confirm new password",
                    validator: (value) {
                      if (value != _passwordController.text.trim()) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AppButton(
                    isLoading: isLoading,
                    onPressed: _changePassword,
                    text: "Change Password",
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

    _currentPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  void _changePassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().changePassword();
    }

  }

}
