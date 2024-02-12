import 'package:flutter/material.dart';

class CustomDialogBoxEmpty extends StatefulWidget {
  Widget body;

  CustomDialogBoxEmpty(this.body);

  @override
  _CustomDialogBoxEmptyState createState() => _CustomDialogBoxEmptyState();
}

class _CustomDialogBoxEmptyState extends State<CustomDialogBoxEmpty> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
            //padding: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: widget.body),
      ],
    );
  }
}
