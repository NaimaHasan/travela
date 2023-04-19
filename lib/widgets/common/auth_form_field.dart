import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({Key? key, required this.text, required this.validatorFn, required this.savedFn, this.controller}) : super(key: key);

  final String text;
  final void Function(String? value) savedFn;
  final String? Function(String? value) validatorFn;
  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(
            fontSize: 15,
          ),
          isDense: true,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)),
        ),
        validator: validatorFn,
        onSaved: savedFn,
      ),
    );
  }
}
