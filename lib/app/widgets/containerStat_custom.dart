import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/color_const.dart';
import '../theme/snackBar_const.dart';

class CustomContainerStat extends StatefulWidget {
  Widget body;
  num percentage;
  Function onTap;
  double width;
  Color colorBackground;
  bool hasMissingTrainings;

  CustomContainerStat({
    required this.body,
    required this.percentage,
    required this.onTap,
    required this.colorBackground,
    this.width = 54,
    this.hasMissingTrainings = false,
  }) : super();

  @override
  _CustomContainerStatState createState() => _CustomContainerStatState();
}

class _CustomContainerStatState extends State<CustomContainerStat> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if(widget.hasMissingTrainings){
            SnackConst.SnackCustom("Il vous manque une formation obligatoire", context, color: Colors.blue);
          }else if (widget.percentage < 0) {
            SnackConst.SnackCustom("Aucune activité n'est à réaliser", context, color: Colors.blue);
          } else {
            widget.onTap();
          }

        },
        child: Container(
            decoration: BoxDecoration(
                color: widget.hasMissingTrainings ? Colors.grey : ColorConst.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                Container(
                  width: widget.percentage <= 0
                      ? widget.width.w
                      : widget.width.w * (widget.percentage / 100),
                  decoration: BoxDecoration(
                    color: widget.hasMissingTrainings ? Colors.grey : widget.colorBackground,
                    borderRadius: widget.percentage <= 0 || widget.percentage > 5
                        ? BorderRadius.circular(10)
                        : BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 5.w, right: 5.w),
                    child: Center(child: widget.body)),
              ],
            )));
  }
}
