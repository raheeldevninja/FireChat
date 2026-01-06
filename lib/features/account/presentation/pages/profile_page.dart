import 'package:flutter/material.dart';
import 'package:fire_chat/features/account/presentation/account.dart';
import 'package:fire_chat/core/ui/widgets/error_widget.dart';
import 'package:fire_chat/core/ui/widgets/app_text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          context.showSnackBarMessage(
            context,
            message: state.error ?? 'Failed to load user',
          );
        }
      },
      builder: (context, state) {

        if (state.status == AuthStatus.error) {
          return Scaffold(
            body: Center(
              child: ErrorLayout(state.error ?? 'An error occurred'),
            ),
          );
        }

        final user = state.user;
        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('No user data available')),
          );
        }

        // Update controllers safely when user data changes
        _nameController.text = user.name;
        _emailController.text = user.email;

        return Scaffold(
          appBar: BaseAppBar(
            title: 'Profile Page',
            showBackButton: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                AppTextField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  label: 'Name',
                  hint: 'Enter your name here ...',
                  isReadOnly: true,
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
                  onPressed: () {
                    context.push('/update-profile-page');
                  },
                  text: 'Update Profile',
                ),
              ],
            ),
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
  }

}