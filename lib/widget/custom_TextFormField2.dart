// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTextFormField2 extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const CustomTextFormField2({
    this.hintText,
    required this.controller,
    required this.validator,
    this.obscureText = false,
  });

  final String? hintText;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final bool? obscureText;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField2> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFormField2> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: TextFormField(
        obscureText: _isObscure &&
            widget.obscureText ==
                true, // Set obscureText based on widget property
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          suffixIcon: widget.obscureText == true
              ? IconButton(
                  // Only show suffix icon if obscureText is true
                  icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
          hintText: widget.hintText,
          filled: true,
          fillColor: const Color.fromARGB(255, 228, 233, 251),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF047EB0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFFF1F4FF),
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF047EB0),
            ),
          ),
        ),
      ),
    );
  }
}
