import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonColor extends StatefulWidget {
  Color color;
  String title;
  bool disabled;
  IconData? prefixIcon;
  IconData? suffixIcon;
  double fontSize;
  var onPressed;

  CustomButtonColor(
      {required this.color,
      required this.title,
      required this.onPressed,
      this.fontSize = 20,
      this.disabled = false,
      this.prefixIcon = null,
      this.suffixIcon = null
      })
      : super();

  @override
  _CustomButtonColorState createState() => _CustomButtonColorState();
}

class _CustomButtonColorState extends State<CustomButtonColor> {
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
          child: widget.title.isEmpty
              ? widget.prefixIcon != null
                  ? Icon(
                        widget.prefixIcon,
                        color: Colors.white,
                      )
                  : Container()
              : RichText(
                  text: TextSpan(children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: widget.prefixIcon != null
                        ? Padding(
                            padding: EdgeInsets.only(right: 2.w),
                            child: Icon(
                              widget.prefixIcon,
                              color: Colors.white,
                            ))
                        : Container(),
                  ),
                  TextSpan(
                    text: widget.title,
                    style: TextStyle(color: Colors.white, fontSize: widget.fontSize),
                  ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: widget.suffixIcon != null
                          ? Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: Icon(
                            widget.suffixIcon,
                            color: Colors.white,
                          ))
                          : Container(),
                    ),
                ])),
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontSize: widget.fontSize),
            primary: widget.color,
          ),
        ));
  }
}
