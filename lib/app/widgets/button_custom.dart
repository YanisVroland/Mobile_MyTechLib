/*
  This file contains a custom button widget used throughout the application.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/color_const.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final bool isLoading;
  final bool disabled;
  final Color color;
  final int width;
  final int height;
  final TextStyle textStyle;
  final Widget? prefix;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.prefix,
    this.width = 200,
    this.height = 40,
    this.isLoading = false,
    this.disabled = false,
    this.color = ColorConst.primary,
    this.textStyle = const TextStyle(
      fontFamily: "montesserat_semi_bold",
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isLoading || widget.disabled ? null : widget.onTap,
      child: Container(
        height: widget.height.h,
        width: widget.width.w,
        constraints: BoxConstraints(
          minWidth: 30.w,
        ),
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(0),
          horizontal: 8.w,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorConst.primary.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(36.r),
          color: widget.disabled ? Colors.grey : widget.color,
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            if (widget.isLoading)
              CupertinoTheme(
                data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
                child: const CupertinoActivityIndicator(),
              ),
            Visibility(
              visible: !widget.isLoading,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.prefix != null)
                    Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: widget.prefix!,
                    ),
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: widget.textStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
