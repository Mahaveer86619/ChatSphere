// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;

  MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.label,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      maxLines: 1,
      autocorrect: false,
      onChanged: (value) {
        widget.controller.text = value;
      },
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.background,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class MyPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;

  const MyPasswordField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.label,
  });

  @override
  State<MyPasswordField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool _visibility = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _visibility,
      keyboardType: widget.keyboardType,
      maxLines: 1,
      autocorrect: false,
      onChanged: (value) {
        widget.controller.text = value;
      },
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _visibility ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () {
            setState(() {
              _visibility = !_visibility;
            });
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.background,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
