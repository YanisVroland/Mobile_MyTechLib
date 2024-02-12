import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/color_const.dart';

class CustomButton extends StatefulWidget {
  String text;
  bool isLoading;
  bool disabled;
  Color color;
  TextStyle textStyle;
  var prefix;
  var onTap;

  CustomButton(
      {required this.onTap,
      required this.text,
      this.prefix,
      this.isLoading = false,
      this.disabled = false,
      this.color = ColorConst.primaryColor,
      this.textStyle = const TextStyle(
        fontFamily: "montesserat_semi_bold",
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      )})
      : super();

  @override
  _SecCustomButtonState createState() => _SecCustomButtonState();
}

class _SecCustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isLoading ||  widget.disabled  ? null : widget.onTap,
      child: Container(
        height: 60.h,
        width: 100.w,
        constraints: BoxConstraints(
          minWidth: 30.w,
        ),
        padding:
            EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(0).toDouble(), horizontal: 8.w),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorConst.primaryColor.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(36.r),
          color: widget.disabled ? Colors.grey : widget.color,
          border: Border.all(color: Colors.white, width: 1),
        ),
        child:  Stack(
          alignment: Alignment.center,
          children: <Widget>[
            if (widget.isLoading)
              CupertinoTheme(
                data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
                child: CupertinoActivityIndicator(),
              ),
            Visibility(
              visible: !widget.isLoading,
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.prefix != null) Padding(padding: EdgeInsets.only(right: 5.w),child: widget.prefix),
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: widget.textStyle,
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
