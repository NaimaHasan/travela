import 'package:flutter/material.dart';

class AuthFormField extends StatefulWidget {
  const AuthFormField(
      {Key? key,
      required this.text,
      required this.validatorFn,
      required this.savedFn,
      required this.width,
      this.controller,
      this.isObscurable = false})
      : super(key: key);

  final String text;
  final width;
  final void Function(String? value) savedFn;
  final String? Function(String? value) validatorFn;
  final TextEditingController? controller;
  final bool isObscurable;

  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  late bool isObscured;
  var changeIcon = Icons.visibility_off_outlined;

  @override
  void initState() {
    isObscured = widget.isObscurable ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        controller: widget.controller,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: widget.text,
          labelStyle: const TextStyle(
            fontSize: 15,
          ),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          suffixIcon: widget.isObscurable
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                      if (changeIcon == Icons.visibility_outlined) {
                        changeIcon = Icons.visibility_off_outlined;
                      } else {
                        changeIcon = Icons.visibility_outlined;
                      }
                    });
                  },
                  icon: Icon(changeIcon),
                  iconSize: 16,
                  splashRadius: 16,
                )
              : null,
        ),
        validator: widget.validatorFn,
        onSaved: widget.savedFn,
        obscureText: isObscured,
      ),
    );
  }
}
