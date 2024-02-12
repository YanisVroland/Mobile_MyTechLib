import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainerBody extends StatefulWidget {
  Widget body;
  String title;

  CustomContainerBody({
    required this.body,
    required this.title,
  }) : super();

  @override
  _CustomContainerBodyState createState() => _CustomContainerBodyState();
}

class _CustomContainerBodyState extends State<CustomContainerBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h, bottom: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.title.isNotEmpty
            ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          Divider(thickness: 1, color: Colors.black),
          SizedBox(height: 10.h),
          widget.body
        ])
            : widget.body);
  }
}
