import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
   final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final IconData? icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final TextStyle? style;
  final TextStyle? labelstyle;
  final TextStyle? hintsstyle;
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.enabledBorder,
    this.focusedBorder,
    this.style,
    this.icon,
    this.labelstyle,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.validator,
    this.hintsstyle,
    this.suffixIcon,
    String? errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodySmall,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        focusedBorder: focusedBorder,
        enabledBorder: enabledBorder,
        labelText: labelText,
        hintText: hintText,
        labelStyle: labelstyle,
        suffixIcon: suffixIcon,
        hintStyle: hintsstyle,
        prefixIcon: icon != null ? Icon(icon) : null,
        
      ),
      validator: validator,
    );
  }
}