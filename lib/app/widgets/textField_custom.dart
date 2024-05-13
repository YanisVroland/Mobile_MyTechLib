/*
  This file contains a custom text field widget with various customization options.
*/

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? labelText;
  final double hintSize;
  final double sizeText;
  final int maxLines;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? errorStyle;
  final Color borderColor;
  final Color fillColor;
  final bool obscureText;
  final bool disabled;
  final bool enabled;
  final bool readOnly;
  final FocusNode? focus;
  final bool passwordVisible;
  final bool submitted;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText = "",
    this.labelText,
    this.sizeText = 16.0,
    this.hintSize = 16.5,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.passwordVisible = false,
    this.obscureText = false,
    this.enabled = true,
    this.submitted = false,
    this.focus,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.errorStyle,
    this.borderColor = Colors.white,
    this.fillColor = Colors.white,
    this.validator,
    this.disabled = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    // Define the custom text form field
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        readOnly: widget.readOnly,
        enabled: !widget.disabled && widget.enabled,
        controller: widget.controller ?? TextEditingController(),
        maxLines: widget.maxLines,
        obscureText: widget.obscureText && !widget.passwordVisible,
        focusNode: widget.focus,
        style: TextStyle(
          color: widget.disabled ? Colors.grey.withOpacity(0.9) : Colors.black.withOpacity(0.8),
          fontSize: widget.sizeText,
        ),
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.disabled ? Colors.grey.withOpacity(0.2) : widget.fillColor,
          errorMaxLines: 2,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: widget.disabled ? Colors.grey : Colors.black.withOpacity(0.6),
          ),
          floatingLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.6),
          ),
          alignLabelWithHint: true,
          errorStyle: widget.errorStyle ?? const TextStyle(height: 0),
          hintText: widget.hintText,
          suffixIcon: widget.suffixIcon,
          hintMaxLines: 1,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
          prefixIcon: widget.prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: widget.borderColor.withOpacity(0.7),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.7)),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (val) {
          if (widget.onChanged != null && !widget.disabled) {
            widget.onChanged!(val);
          }
        },
      ),
    );
  }
}
