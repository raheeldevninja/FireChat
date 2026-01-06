import 'package:flutter/material.dart';
import 'package:fire_chat/features/account/presentation/account.dart';
import 'package:fire_chat/core/ui/widgets/app_text_field.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  bool _hasInitializedControllers = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {

        final user = authState.user;
        if (user == null) {
          return const Scaffold(body: Center(child: Text('No user data')));
        }

        // Initialize once
        if (!_hasInitializedControllers) {
          _nameController.text = user.name;
          _emailController.text = user.email;
          _hasInitializedControllers = true;
        }

        return BlocConsumer<AccountCubit, AccountState>(
          listener: (context, state) {
            if (state.status == AccountStatus.error) {
              context.showSnackBarMessage(
                context,
                message: state.error ?? 'Failed to update profile',
              );
            }
            if (state.status == AccountStatus.profileUpdated) {

              // Update AuthCubit with fresh data
              context.read<AuthCubit>().updateCurrentUser(state.user ?? user);
              context.pop();
            }

          },
          builder: (context, state) {

            final accountCubit = context.read<AccountCubit>();
            final isLoading = state.status == AccountStatus.loading;

            return Scaffold(
              appBar: BaseAppBar(
                title: 'Update Profile Information',
                showBackButton: true,
                isLoading: isLoading,
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        label: 'Name',
                        hint: 'Enter your name here ...',
                        onChanged: accountCubit.nameChanged,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
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
                        isReadOnly: true,
                      ),
                      SizedBox(height: 16),
                      AppButton(
                        isLoading: isLoading,
                        onPressed: isLoading
                            ? null
                            : () {

                          if (_formKey.currentState!.validate()) {
                            context.read<AccountCubit>().updateProfile();
                          }

                        },
                        text: 'Update Profile',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
  }
}