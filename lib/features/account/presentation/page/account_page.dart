import 'package:fire_chat/features/account/presentation/account.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: 'Account'),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {

          if(state.status == AuthStatus.authenticated) {

            final user = state.user!;

            // Build initials
            final initials = (user.name.isNotEmpty
                ? user.name.trim().split(' ').map((e) => e[0]).take(2).join()
                : user.email.isNotEmpty
                ? user.email[0]
                : '?')
                .toUpperCase();

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [

                  CircleAvatar(
                    radius: 40,
                    backgroundColor: context.colorScheme.secondary,
                    child: Text(
                      initials,
                      style: context.textTheme.headlineMedium!.copyWith(
                        color: context.colorScheme.onPrimaryFixed,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: context.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colorScheme.tertiaryFixedDim,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    height: 0,
                  ),

                  ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: Text(
                      "Change Password",
                      style: context.textTheme.bodyLarge,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.push('/change-password');
                    },
                  ),
                  const Divider(
                    height: 0,
                  ),

                  const Spacer(),

                  const SizedBox(height: 12),

                  //logout button
                  AppButton(
                    onPressed: () => _handleLogout(context),
                    text: 'Logout',
                  ),

                ],
              ),
            );

          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    final confirmed = await AppDialog.show(
      context: context,
      title: 'Logout',
      content: 'Are you sure you want to logout?',
      type: DialogType.confirm,
      confirmText: 'Logout',
    );

    if (!context.mounted) {
      return;
    }

    if (confirmed ?? false) {
      context.read<AuthCubit>().signOut();
    }
  }
}
