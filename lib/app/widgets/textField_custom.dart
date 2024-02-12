import 'package:flutter/material.dart';
import '../theme/color_const.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController? controller;
  String hintText;
  String? labelText;
  double hintSize;
  double size_text;
  int maxLines;
  var keyboardType;
  var prefixIcon;
  var suffixIcon;
  var errorStyle;
  var borderColor;
  bool obscureText;
  bool disabled;
  bool enabled;
  bool readOnly;
  final focus;
  bool passwordVisible;
  bool submitted;
  var onChanged;
  var validator;

  CustomTextField({
    this.controller,
    this.hintText = "",
    this.labelText = null,
    this.size_text = 16.0,
    this.hintSize = 16.5,
    this.maxLines = 1,
    this.keyboardType,
    this.passwordVisible = false,
    this.obscureText = false,
    this.enabled = true,
    this.submitted = false,
    this.focus,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.errorStyle,
    this.borderColor = Colors.black,
    this.validator,
    this.disabled = false,
    this.readOnly = false,
  });

  @override
  _CustomTextField createState() => _CustomTextField();
}

class _CustomTextField extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          readOnly: widget.readOnly,
          enabled: widget.disabled ? false : widget.enabled,
          controller: widget.controller ?? new TextEditingController(),
          maxLines: widget.maxLines,
          obscureText: widget.obscureText,
          focusNode: widget.focus,
          style: TextStyle(color: widget.disabled ? Colors.grey.withOpacity(0.9) : widget.borderColor),
          keyboardType: widget.keyboardType ?? TextInputType.text,
          validator: widget.validator,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
              filled: true,
              fillColor: widget.disabled ? Colors.grey.withOpacity(0.2) : Colors.white,
              errorMaxLines: 2,
              labelText: widget.labelText,
              labelStyle: TextStyle(
                  color: widget.disabled ? Colors.grey : Colors.blueAccent.withOpacity(0.8)),
              floatingLabelStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.6)),
              alignLabelWithHint: true,
              // errorStyle: widget.errorStyle,
              errorStyle: TextStyle(height: 0),
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
              hintMaxLines: 1,
              hintStyle: TextStyle(
                color: ColorConst.primaryColor,
              ),
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
              )),
          onChanged: (val) {
            if (widget.onChanged != null && !widget.disabled) {
              setState(() {
                widget.onChanged(val);

              });
            }
          },
        ));
  }
}
