import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../app/widgets/button_custom.dart';
import '../../../services/models/project_model.dart';

class MobileWidget extends StatefulWidget {
  const MobileWidget(this.project, {Key? key}) : super(key: key);
  final Project project;

  @override
  _MobileWidgetState createState() => _MobileWidgetState();
}

class _MobileWidgetState extends State<MobileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final unfocusNode = FocusNode();
  CarouselController buttonCarouselController = CarouselController();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    unfocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 100.h,
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: AppTheme.of(context).primary,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child:   widget.project.logoUrl.isNotEmpty ? Image.network(
                        widget.project.logoUrl ,
                          fit: BoxFit.cover,
                        ) : Image.asset(
                          'assets/images/tlchargement.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.project.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: AppTheme.of(context).primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (widget.project.companyName != null)
                                Text(
                                  widget.project.companyName!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade500,
                                  ),
                                ),

                            ],
                          ),

                          Text(
                            widget.project.version,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           CustomButton(
                             text: "Obtenir",
                             width: 90,
                             height: 30,
                             onTap: () {},
                           ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade300,
          ),
          Visibility(visible: widget.project.illustrationsUrl.isNotEmpty, child: Container(
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            height: 175,
            width: double.infinity,
            child: CarouselSlider(
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                ),
                items: widget.project.illustrationsUrl.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList()),
          ),),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade300,
          ),
          Container(
              padding: EdgeInsets.only(top: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tags : ",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        color: AppTheme.of(context).primary,
                        fontWeight: FontWeight.w600,
                      )),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Row(mainAxisSize: MainAxisSize.max, children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: 32.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: AppTheme.of(context).primary,
                                ),
                              ),
                              child: const Align(
                                alignment: AlignmentDirectional(0.00, 0.00),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                  child: Text("website"),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 32.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: AppTheme.of(context).secondary,
                              ),
                            ),
                            child: const Align(
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                child: Text("ux"),
                              ),
                            ),
                          ),
                        ])),
                  ),
                ],
              )),
          Container(
              height: 200.0,
              padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description :",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        color: AppTheme.of(context).primary,
                        fontWeight: FontWeight.w600,
                      )),
                  Text(widget.project.description,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              )),
        ]
            // .divide(SizedBox(height: 12.0)),
            ));
  }
}
