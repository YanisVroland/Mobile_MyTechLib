import 'package:flutter/material.dart';
import '../theme/color_const.dart';

class CustomDropDown extends StatefulWidget {
  String hintText;
  String? labelText;
  List<dynamic> listValue;
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
    this.labelText = null,
    this.disabled = false,
  });

  @override
  _CustomDropDown createState() => _CustomDropDown();
}

class _CustomDropDown extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
        value: widget.value,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        validator: widget.validator,
        // style: TextStyle(color: widget.disabled ? Colors.grey : Colors.black),
        decoration: InputDecoration(
            filled: true,
            fillColor:
                widget.disabled ? Colors.grey.withOpacity(0.2) : Colors.white,
            hintText: widget.hintText,
            labelText :  widget.labelText,
            labelStyle:  TextStyle(color: widget.disabled ? Colors.grey :  Colors.blueAccent.withOpacity(0.8)),
            floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.6)),
            alignLabelWithHint: true,
            // errorStyle: widget.errorStyle,
            errorStyle: TextStyle(height: 0),
            suffixIcon: widget.suffixIcon,
            hintStyle: TextStyle(
              color:  widget.disabled ? Colors.grey : ColorConst.primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onChanged: widget.disabled ? null : widget.action,
        items: widget.listValue.map<DropdownMenuItem<dynamic>>((dynamic value) {
          return DropdownMenuItem<dynamic>(
            value: value,
            child: Text(value is String ? value : value.name),
          );
        }).toList());
  }
}
