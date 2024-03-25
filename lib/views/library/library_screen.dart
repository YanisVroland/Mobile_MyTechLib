import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/widgets/icon_custom.dart';

class LibraryWidget extends StatefulWidget {
  const LibraryWidget({
    Key? key,
  }) : super(key: key);

  @override
  _LibraryWidgetState createState() => _LibraryWidgetState();
}

class _LibraryWidgetState extends State<LibraryWidget> with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState() {
    super.initState();

    tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: AppTheme.of(context).primary,
            automaticallyImplyLeading: false,
            actions: [],
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                          child: IconCustom(
                            borderColor: Colors.transparent,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 50.0,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 24.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                            child: Text(
                              "Titre",
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              expandedTitleScale: 1.0,
            ),
            elevation: 0.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).primary,
                ),
                child: const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 16.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "12 Projects",
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
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
                                    Tab(
                                      text: "TEAM",
                                    ),
                                  ],
                                  controller: tabBarController,
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: tabBarController,
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
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
                                            //           .fromSTEB(
                                            //           0.0, 0.0, 0.0, 8.0),
                                            //       child: InkWell(
                                            //         splashColor:
                                            //         Colors.transparent,
                                            //         focusColor:
                                            //         Colors.transparent,
                                            //         hoverColor:
                                            //         Colors.transparent,
                                            //         highlightColor:
                                            //         Colors.transparent,
                                            //         onTap: () async {
                                            //           context
                                            //               .pushNamed('Project');
                                            //         },
                                            //         child: Container(
                                            //           decoration: BoxDecoration(
                                            //             color: AppTheme
                                            //                 .of(context)
                                            //                 .secondaryBackground,
                                            //             boxShadow: [
                                            //               BoxShadow(
                                            //                 blurRadius: 4.0,
                                            //                 color:
                                            //                 Color(0x3F14181B),
                                            //                 offset:
                                            //                 Offset(0.0, 3.0),
                                            //               )
                                            //             ],
                                            //             borderRadius:
                                            //             BorderRadius.circular(
                                            //                 8.0),
                                            //           ),
                                            //           child: Padding(
                                            //             padding:
                                            //             EdgeInsetsDirectional
                                            //                 .fromSTEB(
                                            //                 0.0,
                                            //                 5.0,
                                            //                 0.0,
                                            //                 10.0),
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
                                            //                             FontWeight.bold,
                                            //                           ),
                                            //                         ),
                                            //                         Padding(
                                            //                           padding: EdgeInsetsDirectional
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
                                            //                                   FFLocalizations.of(context).getText(
                                            //                                     '65wu5b6y' /* Par : */,
                                            //                                   ),
                                            //                                   style: AppTheme.of(context).bodyMedium.override(
                                            //                                     fontFamily: 'Lexend',
                                            //                                     fontSize: 13.0,
                                            //                                   ),
                                            //                                 ),
                                            //                               ),
                                            //                               Text(
                                            //                                 listViewLibrairiesRecord
                                            //                                     .creatorName,
                                            //                                 style: AppTheme.of(context)
                                            //                                     .bodyMedium
                                            //                                     .override(
                                            //                                   fontFamily: 'Lexend',
                                            //                                   fontSize: 13.0,
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
                                            //                     MainAxisSize
                                            //                         .max,
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
                                            //                         TextAlign
                                            //                             .end,
                                            //                         style: AppTheme.of(
                                            //                             context)
                                            //                             .titleSmall
                                            //                             .override(
                                            //                           fontFamily:
                                            //                           'Lexend',
                                            //                           color: AppTheme.of(context)
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
                                        padding:
                                            EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
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
                                            //           .fromSTEB(
                                            //           0.0, 0.0, 0.0, 8.0),
                                            //       child: Container(
                                            //         decoration: BoxDecoration(
                                            //           color: AppTheme
                                            //               .of(context)
                                            //               .secondaryBackground,
                                            //           boxShadow: [
                                            //             BoxShadow(
                                            //               blurRadius: 4.0,
                                            //               color:
                                            //               Color(0x3F14181B),
                                            //               offset:
                                            //               Offset(0.0, 3.0),
                                            //             )
                                            //           ],
                                            //           borderRadius:
                                            //           BorderRadius.circular(
                                            //               8.0),
                                            //         ),
                                            //         child: Padding(
                                            //           padding:
                                            //           EdgeInsetsDirectional
                                            //               .fromSTEB(
                                            //               0.0,
                                            //               5.0,
                                            //               0.0,
                                            //               10.0),
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
                                            //                           FontWeight.bold,
                                            //                         ),
                                            //                       ),
                                            //                       Padding(
                                            //                         padding: EdgeInsetsDirectional
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
                                            //                                 FFLocalizations.of(context).getText(
                                            //                                   'prik7jy8' /* Par : */,
                                            //                                 ),
                                            //                                 style: AppTheme.of(context).bodyMedium.override(
                                            //                                   fontFamily: 'Lexend',
                                            //                                   fontSize: 13.0,
                                            //                                 ),
                                            //                               ),
                                            //                             ),
                                            //                             Text(
                                            //                               listViewLibrairiesRecord
                                            //                                   .creatorName,
                                            //                               style: AppTheme.of(context)
                                            //                                   .bodyMedium
                                            //                                   .override(
                                            //                                 fontFamily: 'Lexend',
                                            //                                 fontSize: 13.0,
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
                                            //                   MainAxisSize
                                            //                       .max,
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
                                            //                       TextAlign
                                            //                           .end,
                                            //                       style: AppTheme.of(
                                            //                           context)
                                            //                           .titleSmall
                                            //                           .override(
                                            //                         fontFamily:
                                            //                         'Lexend',
                                            //                         color: AppTheme.of(context)
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
                                            // )
                                            Container()),
                                    Padding(
                                        padding:
                                            EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
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
                                            //           .fromSTEB(
                                            //           0.0, 0.0, 0.0, 8.0),
                                            //       child: Container(
                                            //         decoration: BoxDecoration(
                                            //           color: AppTheme
                                            //               .of(context)
                                            //               .secondaryBackground,
                                            //           boxShadow: [
                                            //             BoxShadow(
                                            //               blurRadius: 4.0,
                                            //               color:
                                            //               Color(0x3F14181B),
                                            //               offset:
                                            //               Offset(0.0, 3.0),
                                            //             )
                                            //           ],
                                            //           borderRadius:
                                            //           BorderRadius.circular(
                                            //               8.0),
                                            //         ),
                                            //         child: Padding(
                                            //           padding:
                                            //           EdgeInsetsDirectional
                                            //               .fromSTEB(
                                            //               0.0,
                                            //               5.0,
                                            //               0.0,
                                            //               10.0),
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
                                            //                           FontWeight.bold,
                                            //                         ),
                                            //                       ),
                                            //                       Padding(
                                            //                         padding: EdgeInsetsDirectional
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
                                            //                                 FFLocalizations.of(context).getText(
                                            //                                   'pb6rz6ez' /* Par : */,
                                            //                                 ),
                                            //                                 style: AppTheme.of(context).bodyMedium.override(
                                            //                                   fontFamily: 'Lexend',
                                            //                                   fontSize: 13.0,
                                            //                                 ),
                                            //                               ),
                                            //                             ),
                                            //                             Text(
                                            //                               listViewLibrairiesRecord
                                            //                                   .creatorName,
                                            //                               style: AppTheme.of(context)
                                            //                                   .bodyMedium
                                            //                                   .override(
                                            //                                 fontFamily: 'Lexend',
                                            //                                 fontSize: 13.0,
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
                                            //                   MainAxisSize
                                            //                       .max,
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
                                            //                       TextAlign
                                            //                           .end,
                                            //                       style: AppTheme.of(
                                            //                           context)
                                            //                           .titleSmall
                                            //                           .override(
                                            //                         fontFamily:
                                            //                         'Lexend',
                                            //                         color: AppTheme.of(context)
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
                                            // )
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
