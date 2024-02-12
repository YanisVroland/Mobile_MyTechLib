import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color_const.dart';

class SearchCustom extends StatefulWidget {
  String hintText;
  var suffixIcon;
  Function search;

  SearchCustom(
    this.search, {
    required this.hintText,
    this.suffixIcon,
  });

  @override
  _SearchCustomState createState() => _SearchCustomState();
}

class _SearchCustomState extends State<SearchCustom> {
  final FocusNode _focussearch = FocusNode();
  final _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget search_field = TextFormField(
      style: TextStyle(color: Colors.black),
      controller: _searchcontroller,
      focusNode: _focussearch,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          prefixIcon: Icon(Icons.search, color: ColorConst.secondaryColor),
          suffixIcon: widget.suffixIcon,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: "montesserat_bold",
          ),
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: "montesserat_bold",
              color: ColorConst.primaryColor)),
      cursorColor: ColorConst.background,
      onChanged: (val) {
        widget.search(val);
      },
    );

    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0.r),
        ),
        child: Row(children: [
          Expanded(child: search_field),
          Container(width: 5.w),
        ]));
  }
}
