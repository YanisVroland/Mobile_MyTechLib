import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/routes/router.dart';
import '../../app/theme/app_const.dart';
import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/validators.dart';
import '../../app/widgets/textField_custom.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController textController;
  late TabController tabBarController;

  int get tabBarCurrentIndex => tabBarController.index;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    textController.dispose();
    tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).background,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, AppRouter.CREATE_PUBLIC_LIBRARY);
        },
        backgroundColor: AppTheme.of(context).primary,
        child: const Icon(
          Icons.post_add_rounded,
          size: 32.0,
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).background,
        automaticallyImplyLeading: false,
        title: const Text(AppConst.appName),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
            child: InkWell(
              onTap: () async {
                Navigator.pushNamed(context, AppRouter.PROFILE);
              },
              child: const Icon(
                Icons.settings,
                size: 26.0,
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 5.0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 15.h, top: 10.h),
              child: Container(
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).background,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Color(0x33000000),
                      offset: Offset(0.0, 3.0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child:  CustomTextField(
                    fillColor: AppTheme.of(context).secondaryBackground,
                    controller: textController,
                    hintText: "Recherche par nom ...",
                    prefixIcon: const Icon(
                      Icons.search_outlined,
                      size: 24.0,
                    ),
                    validator: Validators.validateEmpty,
                  ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.of(context).secondaryBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),

                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment(0.0, 0),
                            child: TabBar(
                              unselectedLabelStyle: TextStyle(),
                              indicatorColor: AppTheme.of(context).primary,
                              padding: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                              tabs: [
                                Tab(
                                  text: "TOUT",
                                ),
                                Tab(
                                  text: "PUBLIC",
                                ),
                                Tab(text: "TEAM"),
                              ],
                              controller: tabBarController,
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabBarController,
                              children: [
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                                    child:
                                        // ListView.builder(
                                        //   padding: EdgeInsets.zero,
                                        //   shrinkWrap: true,
                                        //   scrollDirection: Axis.vertical,
                                        //   itemCount:
                                        //   listViewLibrairiesRecordList.length,
                                        //   itemBuilder: (context, listViewIndex) {
                                        //     final listViewLibrairiesRecord =
                                        //     listViewLibrairiesRecordList[
                                        //     listViewIndex];
                                        //     return Padding(
                                        //       padding:
                                        //       EdgeInsetsDirectional.fromSTEB(
                                        //           0.0, 0.0, 0.0, 8.0),
                                        //       child: InkWell(
                                        //         splashColor: Colors.transparent,
                                        //         focusColor: Colors.transparent,
                                        //         hoverColor: Colors.transparent,
                                        //         highlightColor:
                                        //         Colors.transparent,
                                        //         onTap: () async {
                                        //           //TODO Nav (
                                        //           'Library',
                                        //           queryParameters: {
                                        //           'library': serializeParam(
                                        //           listViewLibrairiesRecord,
                                        //           ParamType.Document,
                                        //           ),
                                        //           }.withoutNulls,
                                        //           extra: <String, dynamic>{
                                        //           'library':
                                        //           listViewLibrairiesRecord,
                                        //           },
                                        //           );
                                        //         },
                                        //         child: Container(
                                        //           decoration: BoxDecoration(
                                        //             color: AppTheme.of(
                                        //                 context)
                                        //                 .secondaryBackground,
                                        //             boxShadow: [
                                        //               BoxShadow(
                                        //                 blurRadius: 4.0,
                                        //                 color: Color(0x3F14181B),
                                        //                 offset: Offset(0.0, 3.0),
                                        //               )
                                        //             ],
                                        //             borderRadius:
                                        //             BorderRadius.circular(
                                        //                 8.0),
                                        //           ),
                                        //           child: Padding(
                                        //             padding: EdgeInsetsDirectional
                                        //                 .fromSTEB(
                                        //                 0.0, 5.0, 0.0, 10.0),
                                        //             child: Row(
                                        //               mainAxisSize:
                                        //               MainAxisSize.min,
                                        //               children: [
                                        //                 Expanded(
                                        //                   child: Padding(
                                        //                     padding:
                                        //                     EdgeInsetsDirectional
                                        //                         .fromSTEB(
                                        //                         12.0,
                                        //                         0.0,
                                        //                         0.0,
                                        //                         0.0),
                                        //                     child: Column(
                                        //                       mainAxisSize:
                                        //                       MainAxisSize
                                        //                           .max,
                                        //                       mainAxisAlignment:
                                        //                       MainAxisAlignment
                                        //                           .start,
                                        //                       crossAxisAlignment:
                                        //                       CrossAxisAlignment
                                        //                           .start,
                                        //                       children: [
                                        //                         Text(
                                        //                           listViewLibrairiesRecord
                                        //                               .name,
                                        //                           style: AppTheme.of(
                                        //                               context)
                                        //                               .headlineSmall
                                        //                               .override(
                                        //                             fontFamily:
                                        //                             'Lexend',
                                        //                             fontSize:
                                        //                             14.0,
                                        //                             fontWeight:
                                        //                             FontWeight
                                        //                                 .bold,
                                        //                           ),
                                        //                         ),
                                        //                         Padding(
                                        //                           padding:
                                        //                           EdgeInsetsDirectional
                                        //                               .fromSTEB(
                                        //                               0.0,
                                        //                               10.0,
                                        //                               0.0,
                                        //                               0.0),
                                        //                           child: Row(
                                        //                             mainAxisSize:
                                        //                             MainAxisSize
                                        //                                 .max,
                                        //                             crossAxisAlignment:
                                        //                             CrossAxisAlignment
                                        //                                 .center,
                                        //                             children: [
                                        //                               Padding(
                                        //                                 padding: EdgeInsetsDirectional.fromSTEB(
                                        //                                     0.0,
                                        //                                     0.0,
                                        //                                     4.0,
                                        //                                     0.0),
                                        //                                 child:
                                        //                                 Text(
                                        //                                   FFLocalizations.of(context)
                                        //                                       .getText(
                                        //                                     'wlgqt0bd' /* Par : */,
                                        //                                   ),
                                        //                                   style: AppTheme.of(context)
                                        //                                       .bodyMedium
                                        //                                       .override(
                                        //                                     fontFamily: 'Lexend',
                                        //                                     fontSize: 13.0,
                                        //                                   ),
                                        //                                 ),
                                        //                               ),
                                        //                               Text(
                                        //                                 listViewLibrairiesRecord
                                        //                                     .creatorName,
                                        //                                 style: AppTheme.of(
                                        //                                     context)
                                        //                                     .bodyMedium
                                        //                                     .override(
                                        //                                   fontFamily:
                                        //                                   'Lexend',
                                        //                                   fontSize:
                                        //                                   13.0,
                                        //                                 ),
                                        //                               ),
                                        //                             ],
                                        //                           ),
                                        //                         ),
                                        //                       ],
                                        //                     ),
                                        //                   ),
                                        //                 ),
                                        //                 Padding(
                                        //                   padding:
                                        //                   EdgeInsetsDirectional
                                        //                       .fromSTEB(
                                        //                       12.0,
                                        //                       0.0,
                                        //                       12.0,
                                        //                       0.0),
                                        //                   child: Column(
                                        //                     mainAxisSize:
                                        //                     MainAxisSize.max,
                                        //                     mainAxisAlignment:
                                        //                     MainAxisAlignment
                                        //                         .start,
                                        //                     crossAxisAlignment:
                                        //                     CrossAxisAlignment
                                        //                         .end,
                                        //                     children: [
                                        //                       Text(
                                        //                         dateTimeFormat(
                                        //                           'd/M/y',
                                        //                           listViewLibrairiesRecord
                                        //                               .createdDate!,
                                        //                           locale: FFLocalizations.of(
                                        //                               context)
                                        //                               .languageCode,
                                        //                         ),
                                        //                         textAlign:
                                        //                         TextAlign.end,
                                        //                         style: AppTheme
                                        //                             .of(context)
                                        //                             .titleSmall
                                        //                             .override(
                                        //                           fontFamily:
                                        //                           'Lexend',
                                        //                           color: AppTheme.of(
                                        //                               context)
                                        //                               .secondaryText,
                                        //                         ),
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     );
                                        //   },
                                        // ),
                                        Container()),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                                    child:
                                        // ListView.builder(
                                        //   padding: EdgeInsets.zero,
                                        //   shrinkWrap: true,
                                        //   scrollDirection: Axis.vertical,
                                        //   itemCount:
                                        //   listViewLibrairiesRecordList
                                        //       .length,
                                        //   itemBuilder:
                                        //       (context, listViewIndex) {
                                        //     final listViewLibrairiesRecord =
                                        //     listViewLibrairiesRecordList[
                                        //     listViewIndex];
                                        //     return Padding(
                                        //       padding: EdgeInsetsDirectional
                                        //           .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                        //       child: Container(
                                        //         decoration: BoxDecoration(
                                        //           color: AppTheme.of(
                                        //               context)
                                        //               .secondaryBackground,
                                        //           boxShadow: [
                                        //             BoxShadow(
                                        //               blurRadius: 4.0,
                                        //               color: Color(0x3F14181B),
                                        //               offset: Offset(0.0, 3.0),
                                        //             )
                                        //           ],
                                        //           borderRadius:
                                        //           BorderRadius.circular(
                                        //               8.0),
                                        //         ),
                                        //         child: Padding(
                                        //           padding: EdgeInsetsDirectional
                                        //               .fromSTEB(
                                        //               0.0, 5.0, 0.0, 10.0),
                                        //           child: Row(
                                        //             mainAxisSize:
                                        //             MainAxisSize.min,
                                        //             children: [
                                        //               Expanded(
                                        //                 child: Padding(
                                        //                   padding:
                                        //                   EdgeInsetsDirectional
                                        //                       .fromSTEB(
                                        //                       12.0,
                                        //                       0.0,
                                        //                       0.0,
                                        //                       0.0),
                                        //                   child: Column(
                                        //                     mainAxisSize:
                                        //                     MainAxisSize
                                        //                         .max,
                                        //                     mainAxisAlignment:
                                        //                     MainAxisAlignment
                                        //                         .start,
                                        //                     crossAxisAlignment:
                                        //                     CrossAxisAlignment
                                        //                         .start,
                                        //                     children: [
                                        //                       Text(
                                        //                         listViewLibrairiesRecord
                                        //                             .name,
                                        //                         style: AppTheme.of(
                                        //                             context)
                                        //                             .headlineSmall
                                        //                             .override(
                                        //                           fontFamily:
                                        //                           'Lexend',
                                        //                           fontSize:
                                        //                           14.0,
                                        //                           fontWeight:
                                        //                           FontWeight
                                        //                               .bold,
                                        //                         ),
                                        //                       ),
                                        //                       Padding(
                                        //                         padding:
                                        //                         EdgeInsetsDirectional
                                        //                             .fromSTEB(
                                        //                             0.0,
                                        //                             10.0,
                                        //                             0.0,
                                        //                             0.0),
                                        //                         child: Row(
                                        //                           mainAxisSize:
                                        //                           MainAxisSize
                                        //                               .max,
                                        //                           crossAxisAlignment:
                                        //                           CrossAxisAlignment
                                        //                               .center,
                                        //                           children: [
                                        //                             Padding(
                                        //                               padding: EdgeInsetsDirectional.fromSTEB(
                                        //                                   0.0,
                                        //                                   0.0,
                                        //                                   4.0,
                                        //                                   0.0),
                                        //                               child:
                                        //                               Text(
                                        //                                 FFLocalizations.of(context)
                                        //                                     .getText(
                                        //                                   '4hto11pu' /* Par : */,
                                        //                                 ),
                                        //                                 style: AppTheme.of(context)
                                        //                                     .bodyMedium
                                        //                                     .override(
                                        //                                   fontFamily: 'Lexend',
                                        //                                   fontSize: 13.0,
                                        //                                 ),
                                        //                               ),
                                        //                             ),
                                        //                             Text(
                                        //                               listViewLibrairiesRecord
                                        //                                   .creatorName,
                                        //                               style: AppTheme.of(
                                        //                                   context)
                                        //                                   .bodyMedium
                                        //                                   .override(
                                        //                                 fontFamily:
                                        //                                 'Lexend',
                                        //                                 fontSize:
                                        //                                 13.0,
                                        //                               ),
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //               Padding(
                                        //                 padding:
                                        //                 EdgeInsetsDirectional
                                        //                     .fromSTEB(
                                        //                     12.0,
                                        //                     0.0,
                                        //                     12.0,
                                        //                     0.0),
                                        //                 child: Column(
                                        //                   mainAxisSize:
                                        //                   MainAxisSize.max,
                                        //                   mainAxisAlignment:
                                        //                   MainAxisAlignment
                                        //                       .start,
                                        //                   crossAxisAlignment:
                                        //                   CrossAxisAlignment
                                        //                       .end,
                                        //                   children: [
                                        //                     Text(
                                        //                       dateTimeFormat(
                                        //                         'd/M/y',
                                        //                         listViewLibrairiesRecord
                                        //                             .createdDate!,
                                        //                         locale: FFLocalizations.of(
                                        //                             context)
                                        //                             .languageCode,
                                        //                       ),
                                        //                       textAlign:
                                        //                       TextAlign.end,
                                        //                       style: AppTheme
                                        //                           .of(context)
                                        //                           .titleSmall
                                        //                           .override(
                                        //                         fontFamily:
                                        //                         'Lexend',
                                        //                         color: AppTheme.of(
                                        //                             context)
                                        //                             .secondaryText,
                                        //                       ),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     );
                                        //   },
                                        // ),
                                        Container()),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                                    child:
                                        // ListView.builder(
                                        //   padding: EdgeInsets.zero,
                                        //   shrinkWrap: true,
                                        //   scrollDirection: Axis.vertical,
                                        //   itemCount:
                                        //   listViewLibrairiesRecordList
                                        //       .length,
                                        //   itemBuilder:
                                        //       (context, listViewIndex) {
                                        //     final listViewLibrairiesRecord =
                                        //     listViewLibrairiesRecordList[
                                        //     listViewIndex];
                                        //     return Padding(
                                        //       padding: EdgeInsetsDirectional
                                        //           .fromSTEB(0.0, 0.0, 0.0, 8.0),
                                        //       child: Container(
                                        //         decoration: BoxDecoration(
                                        //           color: AppTheme.of(
                                        //               context)
                                        //               .secondaryBackground,
                                        //           boxShadow: [
                                        //             BoxShadow(
                                        //               blurRadius: 4.0,
                                        //               color: Color(0x3F14181B),
                                        //               offset: Offset(0.0, 3.0),
                                        //             )
                                        //           ],
                                        //           borderRadius:
                                        //           BorderRadius.circular(
                                        //               8.0),
                                        //         ),
                                        //         child: Padding(
                                        //           padding: EdgeInsetsDirectional
                                        //               .fromSTEB(
                                        //               0.0, 5.0, 0.0, 10.0),
                                        //           child: Row(
                                        //             mainAxisSize:
                                        //             MainAxisSize.min,
                                        //             children: [
                                        //               Expanded(
                                        //                 child: Padding(
                                        //                   padding:
                                        //                   EdgeInsetsDirectional
                                        //                       .fromSTEB(
                                        //                       12.0,
                                        //                       0.0,
                                        //                       0.0,
                                        //                       0.0),
                                        //                   child: Column(
                                        //                     mainAxisSize:
                                        //                     MainAxisSize
                                        //                         .max,
                                        //                     mainAxisAlignment:
                                        //                     MainAxisAlignment
                                        //                         .start,
                                        //                     crossAxisAlignment:
                                        //                     CrossAxisAlignment
                                        //                         .start,
                                        //                     children: [
                                        //                       Text(
                                        //                         listViewLibrairiesRecord
                                        //                             .name,
                                        //                         style: AppTheme.of(
                                        //                             context)
                                        //                             .headlineSmall
                                        //                             .override(
                                        //                           fontFamily:
                                        //                           'Lexend',
                                        //                           fontSize:
                                        //                           14.0,
                                        //                           fontWeight:
                                        //                           FontWeight
                                        //                               .bold,
                                        //                         ),
                                        //                       ),
                                        //                       Padding(
                                        //                         padding:
                                        //                         EdgeInsetsDirectional
                                        //                             .fromSTEB(
                                        //                             0.0,
                                        //                             10.0,
                                        //                             0.0,
                                        //                             0.0),
                                        //                         child: Row(
                                        //                           mainAxisSize:
                                        //                           MainAxisSize
                                        //                               .max,
                                        //                           crossAxisAlignment:
                                        //                           CrossAxisAlignment
                                        //                               .center,
                                        //                           children: [
                                        //                             Padding(
                                        //                               padding: EdgeInsetsDirectional.fromSTEB(
                                        //                                   0.0,
                                        //                                   0.0,
                                        //                                   4.0,
                                        //                                   0.0),
                                        //                               child:
                                        //                               Text(
                                        //                                 FFLocalizations.of(context)
                                        //                                     .getText(
                                        //                                   '51kwlhcb' /* Par : */,
                                        //                                 ),
                                        //                                 style: AppTheme.of(context)
                                        //                                     .bodyMedium
                                        //                                     .override(
                                        //                                   fontFamily: 'Lexend',
                                        //                                   fontSize: 13.0,
                                        //                                 ),
                                        //                               ),
                                        //                             ),
                                        //                             Text(
                                        //                               listViewLibrairiesRecord
                                        //                                   .creatorName,
                                        //                               style: AppTheme.of(
                                        //                                   context)
                                        //                                   .bodyMedium
                                        //                                   .override(
                                        //                                 fontFamily:
                                        //                                 'Lexend',
                                        //                                 fontSize:
                                        //                                 13.0,
                                        //                               ),
                                        //                             ),
                                        //                           ],
                                        //                         ),
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //               Padding(
                                        //                 padding:
                                        //                 EdgeInsetsDirectional
                                        //                     .fromSTEB(
                                        //                     12.0,
                                        //                     0.0,
                                        //                     12.0,
                                        //                     0.0),
                                        //                 child: Column(
                                        //                   mainAxisSize:
                                        //                   MainAxisSize.max,
                                        //                   mainAxisAlignment:
                                        //                   MainAxisAlignment
                                        //                       .start,
                                        //                   crossAxisAlignment:
                                        //                   CrossAxisAlignment
                                        //                       .end,
                                        //                   children: [
                                        //                     Text(
                                        //                       dateTimeFormat(
                                        //                         'd/M/y',
                                        //                         listViewLibrairiesRecord
                                        //                             .createdDate!,
                                        //                         locale: FFLocalizations.of(
                                        //                             context)
                                        //                             .languageCode,
                                        //                       ),
                                        //                       textAlign:
                                        //                       TextAlign.end,
                                        //                       style: AppTheme
                                        //                           .of(context)
                                        //                           .titleSmall
                                        //                           .override(
                                        //                         fontFamily:
                                        //                         'Lexend',
                                        //                         color: AppTheme.of(
                                        //                             context)
                                        //                             .secondaryText,
                                        //                       ),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     );
                                        //   },
                                        // ),
                                        Container()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
