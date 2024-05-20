// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const CustomTextFormField({
    required this.iconData,
    required this.controller,
    required this.labelText,
    required this.labelFontSize,
    required this.labelColor,
    required this.labelFontWeight,
    required this.hintText, 
   
  });
  final IconData iconData;
  final TextEditingController controller;
  final String labelText;
  final double labelFontSize;
  final Color labelColor;
  // ignore: prefer_typing_uninitialized_variables
  final labelFontWeight;
   final String hintText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
            suffixIcon: Icon(widget.iconData, color: const Color(0xFF1D5D9B)),
            filled: true,
            fillColor: const Color.fromARGB(255, 228, 233, 251),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            labelText: (widget.labelText),
            hintText: widget.hintText,
            labelStyle: TextStyle(
              fontSize: widget.labelFontSize,
              color: widget.labelColor,
              fontWeight: widget.labelFontWeight,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFF047EB0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFF88AACA),
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF88AACA),
              ),
            )),
      ),
    );
  }
}
