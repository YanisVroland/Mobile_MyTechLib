/*
  This file contains a custom icon button widget with a specified color.
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButtonColor extends StatefulWidget {
  Color color;
  bool disabled;
  Icon icon;
  double fontSize;
  var onPressed;

  CustomIconButtonColor({
    required this.color,
    required this.onPressed,
    required this.icon,
    this.fontSize = 20,
    this.disabled = false,
  }) : super();

  @override
  _CustomIconButtonColorState createState() => _CustomIconButtonColorState();
}

class _CustomIconButtonColorState extends State<CustomIconButtonColor> {
  late Color colorBackground;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.w, left: 2.w),
      child: ElevatedButton(
        onPressed: widget.disabled ? null : widget.onPressed,
        child: widget.icon,
        style: ElevatedButton.styleFrom(
          textStyle: TextStyle(fontSize: widget.fontSize),
          primary: widget.color,
        ),
      ),
    );
  }
}
