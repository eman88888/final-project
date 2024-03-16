
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {

  CustomTextFormField({
    required this.iconData,
    required this.controller,
    required this.labelText,
    required this.labelFontSize,
    required this.labelColor,
    required this.labelFontWeight,
    
  });
  final IconData iconData;
  final TextEditingController controller;
  final String labelText;
  final double labelFontSize;
  final Color labelColor;
  final labelFontWeight;

  
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
                          suffixIcon: Icon(widget.iconData,color: Color(0xFF1D5D9B)),
                          filled: true,
                          fillColor: Color.fromARGB(255, 228, 233, 251),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                              labelText: (widget.labelText),
                               labelStyle: TextStyle(
                                   fontSize: widget.labelFontSize, 
                                   color: widget.labelColor,
                                   fontWeight: widget.labelFontWeight, 
                                       ),
                           focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Color(0xFF047EB0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Color(0xFF88AACA),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF88AACA),
                            ),
                          )
                        ),
      ),
    );
  }
}
