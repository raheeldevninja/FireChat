import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum DialogType { info, confirm, error }

class AppDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String content,
    DialogType type = DialogType.confirm,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
  }) {
    final isConfirm = type == DialogType.confirm;

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(
              _getIcon(type),
            ),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(content),
        actions: [
          if (isConfirm)
            TextButton(
              onPressed: () => context.pop(false),
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              child: Text(cancelText),
            ),
          ElevatedButton(
            onPressed: () => context.pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: _getColor(type),
              foregroundColor: Colors.white,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  static Future<String?> showPasswordDialog(BuildContext context,
      {DialogType type = DialogType.confirm}) async {
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Re-enter Password'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
              ),
              onPressed: () => context.pop(null),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.pop(passwordController.text.trim());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _getColor(type),
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  static IconData _getIcon(DialogType type) {
    switch (type) {
      case DialogType.info:
        return Icons.info_outline;
      case DialogType.confirm:
        return Icons.help_outline;
      case DialogType.error:
        return Icons.error_outline;
    }
  }

  static Color _getColor(DialogType type) {
    switch (type) {
      case DialogType.info:
        return Colors.blue;
      case DialogType.confirm:
        return Colors.black;
      case DialogType.error:
        return Colors.red;
    }
  }
}
