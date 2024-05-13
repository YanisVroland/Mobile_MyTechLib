/*
  This file contains a custom search input field widget with various customization options.
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color_const.dart';

class SearchCustom extends StatefulWidget {
  final String hintText;
  final Widget? suffixIcon;
  final Function(String) search;

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
    // Define the search input field widget
    Widget searchField = TextFormField(
      style: TextStyle(color: Colors.black),
      controller: _searchcontroller,
      focusNode: _focussearch,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hintText,
        prefixIcon: Icon(Icons.search, color: ColorConst.secondary),
        suffixIcon: widget.suffixIcon,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: "montesserat_bold",
        ),
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: "montesserat_bold",
          color: ColorConst.primary,
        ),
      ),
      cursorColor: ColorConst.background,
      onChanged: (val) {
        widget.search(val);
      },
    );

    // Build the search input field container
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0.r),
      ),
      child: Row(
        children: [
          Expanded(child: searchField),
          Container(width: 5.w),
        ],
      ),
    );
  }
}
