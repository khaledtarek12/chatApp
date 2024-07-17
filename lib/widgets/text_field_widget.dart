import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormTextFieldWidget extends StatelessWidget {
  FormTextFieldWidget(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.isPassword,
      this.onChanged});

  final String hintText;
  final Icon icon;
  final bool isPassword;

  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is empty';
        }
        return null;
      },
      onChanged: onChanged,
      obscureText: isPassword ? true : false,
      enableSuggestions: isPassword ? false : true,
      autocorrect: isPassword ? false : true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 20,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 20,
        ),
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        suffixIcon: icon,
        suffixIconColor: Colors.white,
      ),
    );
  }
}
