import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/routes/router.dart';

class InformationWidget extends StatefulWidget {
  const InformationWidget({Key? key}) : super(key: key);

  @override
  _InformationWidgetState createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> with TickerProviderStateMixin {
  int filterIdx = 1;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).background,
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).background,
        automaticallyImplyLeading: false,
        title: Text("Actualités"),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
            child: InkWell(
              onTap: () async {
                Navigator.pushNamed(context, AppRouter.PROFILE);
              },
              child: Icon(
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
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        setState(() {
                          filterIdx = 1;
                        });
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: filterIdx == 1
                              ? AppTheme.of(context).primary
                              : AppTheme.of(context).background,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x33000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(0.0),
                          ),
                          border: Border.all(
                            color: filterIdx == 1
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).background,
                          ),
                        ),
                        alignment: AlignmentDirectional(0.00, 0.00),
                        child: Align(
                          alignment: AlignmentDirectional(0.00, 0.00),
                          child: Text(
                            "Aujourd'hui ",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        setState(() {
                          filterIdx = 2;
                        });
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: filterIdx == 2
                              ? AppTheme.of(context).primary
                              : AppTheme.of(context).background,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x33000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                          border: Border.all(
                            color: filterIdx == 2
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).background,
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.00, 0.00),
                          child: Text("Semaine"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        setState(() {
                          filterIdx = 3;
                        });
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: filterIdx == 3
                              ? AppTheme.of(context).primary
                              : AppTheme.of(context).background,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x33000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(20.0),
                            topLeft: Radius.circular(0.0),
                            topRight: Radius.circular(20.0),
                          ),
                          border: Border.all(
                            color: filterIdx == 3
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).background,
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.00, 0.00),
                          child: Text(
                            "Mois",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.25,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x3F14181B),
                          offset: Offset(0.0, 3.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Nouveau",
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                            child: Text(
                              "12",
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.25,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x3F14181B),
                          offset: Offset(0.0, 3.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Mise à jour",
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                            child: Text(
                              filterIdx.toString(),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.25,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x3F14181B),
                          offset: Offset(0.0, 3.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Supression",
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                            child: Text(
                              "23",
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.of(context).secondaryBackground,
                  boxShadow: [
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
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20.0, 12.0, 20.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("Aujourd'hui"),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                        child:
                            // ListView.builder(
                            //   padding: EdgeInsets.zero,
                            //   shrinkWrap: true,
                            //   scrollDirection: Axis.vertical,
                            //   itemCount: listViewUsersRecordList.length,
                            //   itemBuilder: (context, listViewIndex) {
                            //     final listViewUsersRecord =
                            //     listViewUsersRecordList[listViewIndex];
                            //     return Padding(
                            //       padding: EdgeInsetsDirectional.fromSTEB(
                            //           0.0, 0.0, 0.0, 8.0),
                            //       child: Container(
                            //         height: 70.0,
                            //         decoration: BoxDecoration(
                            //           color: AppTheme.of(context)
                            //               .secondaryBackground,
                            //           boxShadow: [
                            //             BoxShadow(
                            //               blurRadius: 4.0,
                            //               color: Color(0x3F14181B),
                            //               offset: Offset(0.0, 3.0),
                            //             )
                            //           ],
                            //           borderRadius: BorderRadius.circular(8.0),
                            //         ),
                            //         child: Padding(
                            //           padding: EdgeInsetsDirectional.fromSTEB(
                            //               0.0, 3.0, 0.0, 0.0),
                            //           child: Row(
                            //             mainAxisSize: MainAxisSize.min,
                            //             children: [
                            //               Expanded(
                            //                 child: Padding(
                            //                   padding:
                            //                   EdgeInsetsDirectional.fromSTEB(
                            //                       12.0, 0.0, 0.0, 0.0),
                            //                   child: Column(
                            //                     mainAxisSize: MainAxisSize.max,
                            //                     mainAxisAlignment:
                            //                     MainAxisAlignment.start,
                            //                     crossAxisAlignment:
                            //                     CrossAxisAlignment.start,
                            //                     children: [
                            //                       Flexible(
                            //                         child: Text(
                            //                           FFLocalizations.of(context)
                            //                               .getText(
                            //                             '0ux8q945' /* Microsoft : Client */,
                            //                           ),
                            //                           style: AppTheme.of(
                            //                               context)
                            //                               .headlineSmall
                            //                               .override(
                            //                             fontFamily: 'Lexend',
                            //                             fontSize: 14.0,
                            //                             fontWeight:
                            //                             FontWeight.bold,
                            //                           ),
                            //                         ),
                            //                       ),
                            //                       Padding(
                            //                         padding: EdgeInsetsDirectional
                            //                             .fromSTEB(
                            //                             0.0, 4.0, 0.0, 0.0),
                            //                         child: Text(
                            //                           FFLocalizations.of(context)
                            //                               .getText(
                            //                             'wjf27zoc' /* Nouveau shelf : Amazon */,
                            //                           ),
                            //                           style: AppTheme.of(
                            //                               context)
                            //                               .bodyMedium
                            //                               .override(
                            //                             fontFamily: 'Lexend',
                            //                             fontSize: 13.0,
                            //                           ),
                            //                         ),
                            //                       ),
                            //                       Padding(
                            //                         padding: EdgeInsetsDirectional
                            //                             .fromSTEB(
                            //                             0.0, 4.0, 0.0, 0.0),
                            //                         child: Text(
                            //                           FFLocalizations.of(context)
                            //                               .getText(
                            //                             'l2s9qs1n' /* Par : Yanis Vroland */,
                            //                           ),
                            //                           style: AppTheme.of(
                            //                               context)
                            //                               .bodyMedium
                            //                               .override(
                            //                             fontFamily: 'Lexend',
                            //                             fontSize: 13.0,
                            //                           ),
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               ),
                            //               Padding(
                            //                 padding:
                            //                 EdgeInsetsDirectional.fromSTEB(
                            //                     12.0, 0.0, 12.0, 0.0),
                            //                 child: Column(
                            //                   mainAxisSize: MainAxisSize.max,
                            //                   mainAxisAlignment:
                            //                   MainAxisAlignment.start,
                            //                   crossAxisAlignment:
                            //                   CrossAxisAlignment.end,
                            //                   children: [
                            //                     Text(
                            //                       FFLocalizations.of(context)
                            //                           .getText(
                            //                         'vfijb5nf' /* 12/07/2022 */,
                            //                       ),
                            //                       textAlign: TextAlign.end,
                            //                       style:
                            //                       AppTheme.of(context)
                            //                           .titleSmall
                            //                           .override(
                            //                         fontFamily: 'Lexend',
                            //                         color: AppTheme
                            //                             .of(context)
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
            ),
          ],
        ),
      ),
    );
  }
}
