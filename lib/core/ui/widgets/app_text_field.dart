import 'package:fire_chat/core/extensions/context.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isPassword;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool isReadOnly;
  final bool autoFocus;
  final TextInputType keyboardType;
  final Function(String)? onChanged;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.maxLines = 1,
    this.isReadOnly = false,
    this.autoFocus = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  })  : isPassword = false;

  const AppTextField.password({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.maxLines = 1,
    this.isReadOnly = false,
    this.autoFocus = false,
    this.keyboardType = TextInputType.visiblePassword,
    this.onChanged,
  })  : isPassword = true;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      autofocus: widget.autoFocus,
      obscureText: widget.isPassword ? _obscureText : false,
      maxLines: widget.maxLines,
      readOnly: widget.isReadOnly,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _toggleVisibility,
        )
            : null,
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
      cursorColor: context.colorScheme.onSecondary,
    );
  }
}
