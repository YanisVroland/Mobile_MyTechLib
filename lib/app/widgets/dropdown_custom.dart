/*
  This file contains a custom dropdown widget used throughout the application.
*/

import 'package:flutter/material.dart';
import '../theme/color_const.dart';

class CustomDropDown extends StatefulWidget {
  String hintText;
  String? labelText;
  List<dynamic> listValue;
  final Color fillColor;
  final Color borderColor;
  bool disabled;
  dynamic value;
  var action;
  var suffixIcon;
  var validator;
  var errorStyle;

  CustomDropDown({
    required this.listValue,
    required this.action,
    required this.value,
    this.hintText = "",
    this.errorStyle,
    this.validator,
    this.suffixIcon,
    this.borderColor = Colors.white,
    this.fillColor = Colors.white,
    this.labelText = null,
    this.disabled = false,
  });

  @override
  _CustomDropDown createState() => _CustomDropDown();
}

class _CustomDropDown extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<dynamic>(
        value: widget.value,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        validator: widget.validator,
        style: TextStyle(
          color: widget.disabled ? Colors.grey.withOpacity(0.9) : Colors.black.withOpacity(0.8),
          fontSize:  16.0,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.disabled ? Colors.grey.withOpacity(0.2) : widget.fillColor,
          errorMaxLines: 2,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: widget.disabled ? Colors.grey : Colors.black.withOpacity(0.6),
          ),
          floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.6)),
          alignLabelWithHint: true,
          errorStyle: widget.errorStyle ?? const TextStyle(height: 0),
          hintText: widget.hintText,
          suffixIcon: widget.suffixIcon,
          hintMaxLines: 1,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
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
        onChanged: widget.disabled ? null : widget.action,
        items: widget.listValue.map<DropdownMenuItem<dynamic>>((dynamic value) {
          return DropdownMenuItem<dynamic>(
            value: value,
            child: Text(value is String ? value : value.name),
          );
        }).toList(),
      ),
    );
  }
}
