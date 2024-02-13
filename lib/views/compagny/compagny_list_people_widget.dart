import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CompagnyListPeopleWidget extends StatefulWidget {
  const CompagnyListPeopleWidget({Key? key}) : super(key: key);

  @override
  _CompagnyListPeopleWidgetState createState() =>
      _CompagnyListPeopleWidgetState();
}

class _CompagnyListPeopleWidgetState extends State<CompagnyListPeopleWidget>
    with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // State field(s) for TextField widget.
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;


  @override
  void initState() {
    super.initState();

    textController ??= TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).background,
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).background,
        automaticallyImplyLeading: true,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 24.0,
          ),
        ),
        title: const Text(
          "Compagnie",
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                //TODO Nav ('profilePage');
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
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).background,
                    boxShadow: [
                      const BoxShadow(
                        blurRadius: 3.0,
                        color: Color(0x33000000),
                        offset: Offset(0.0, 4.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  alignment: const AlignmentDirectional(0.00, 0.00),
                  child: TextFormField(
                    controller: textController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "Recherche par nom ...",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      fillColor: AppTheme.of(context).secondaryBackground,
                      contentPadding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 14.0, 0.0, 0.0),
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 20.0, 0.0, 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).secondaryBackground,
                        boxShadow: [
                          const BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(0.0, 2.0),
                          )
                        ],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(70.0),
                          topRight: Radius.circular(70.0),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Text(
                              "Liste des participants :",
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      AppTheme.of(context).secondaryBackground,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20.0, 20.0, 20.0, 20.0),
                                  child: Container(),

                                  // ListView.builder(
                                  //   padding: EdgeInsets.zero,
                                  //   scrollDirection: Axis.vertical,
                                  //   itemCount: listViewParticipantsRecordList.length,
                                  //   itemBuilder:
                                  //       (context, listViewIndex) {
                                  //     final listViewParticipantsRecord =
                                  //     listViewParticipantsRecordList[
                                  //     listViewIndex];
                                  //     return Padding(
                                  //       padding:
                                  //       EdgeInsetsDirectional
                                  //           .fromSTEB(0.0, 5.0,
                                  //           0.0, 0.0),
                                  //       child: Row(
                                  //         mainAxisSize:
                                  //         MainAxisSize.max,
                                  //         mainAxisAlignment:
                                  //         MainAxisAlignment
                                  //             .center,
                                  //         children: [
                                  //           if (functions.showSearchResult(
                                  //               _model
                                  //                   .textController!
                                  //                   .text,
                                  //               listViewParticipantsRecord
                                  //                   .userName))
                                  //             Flexible(
                                  //               child: Material(
                                  //                 color: Colors
                                  //                     .transparent,
                                  //                 elevation: 3.0,
                                  //                 shape:
                                  //                 RoundedRectangleBorder(
                                  //                   borderRadius:
                                  //                   BorderRadius
                                  //                       .circular(
                                  //                       8.0),
                                  //                 ),
                                  //                 child: Container(
                                  //                   decoration:
                                  //                   BoxDecoration(
                                  //                     color: AppTheme.of(
                                  //                         context)
                                  //                         .textColor,
                                  //                     boxShadow: [
                                  //                       BoxShadow(
                                  //                         blurRadius:
                                  //                         4.0,
                                  //                         color: Color(
                                  //                             0x33000000),
                                  //                         offset: Offset(
                                  //                             0.0,
                                  //                             2.0),
                                  //                       )
                                  //                     ],
                                  //                     borderRadius:
                                  //                     BorderRadius
                                  //                         .circular(
                                  //                         8.0),
                                  //                     border: Border
                                  //                         .all(
                                  //                       color: AppTheme.of(
                                  //                           context)
                                  //                           .accent2,
                                  //                       width: 0.0,
                                  //                     ),
                                  //                   ),
                                  //                   child: Padding(
                                  //                     padding: EdgeInsetsDirectional
                                  //                         .fromSTEB(
                                  //                         5.0,
                                  //                         5.0,
                                  //                         5.0,
                                  //                         5.0),
                                  //                     child: Row(
                                  //                       mainAxisSize:
                                  //                       MainAxisSize
                                  //                           .max,
                                  //                       mainAxisAlignment:
                                  //                       MainAxisAlignment
                                  //                           .spaceBetween,
                                  //                       children: [
                                  //                         Row(
                                  //                           mainAxisSize:
                                  //                           MainAxisSize.max,
                                  //                           children: [
                                  //                             Padding(
                                  //                               padding: EdgeInsetsDirectional.fromSTEB(
                                  //                                   0.0,
                                  //                                   3.0,
                                  //                                   0.0,
                                  //                                   3.0),
                                  //                               child:
                                  //                               Container(
                                  //                                 width: 40.0,
                                  //                                 height: 40.0,
                                  //                                 clipBehavior: Clip.antiAlias,
                                  //                                 decoration: BoxDecoration(
                                  //                                   shape: BoxShape.circle,
                                  //                                 ),
                                  //                                 child: Image.asset(
                                  //                                   'assets/images/user_2@2x.png',
                                  //                                 ),
                                  //                               ),
                                  //                             ),
                                  //                             Padding(
                                  //                               padding: EdgeInsetsDirectional.fromSTEB(
                                  //                                   5.0,
                                  //                                   0.0,
                                  //                                   0.0,
                                  //                                   0.0),
                                  //                               child:
                                  //                               Text(
                                  //                                 listViewParticipantsRecord.userName,
                                  //                               ),
                                  //                             ),
                                  //                           ],
                                  //                         ),
                                  //                         Flexible(
                                  //                           child:
                                  //                           Row(
                                  //                             mainAxisSize:
                                  //                             MainAxisSize.max,
                                  //                             mainAxisAlignment:
                                  //                             MainAxisAlignment.end,
                                  //                             children: [
                                  //                               if (listViewParticipantsRecord.isAdmin ==
                                  //                                   true)
                                  //                                 Padding(
                                  //                                   padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                  //                                   child: Container(
                                  //                                     width: 70.0,
                                  //                                     height: 30.0,
                                  //                                     decoration: BoxDecoration(
                                  //                                       color: AppTheme.of(context).secondary,
                                  //                                       boxShadow: [
                                  //                                         BoxShadow(
                                  //                                           blurRadius: 4.0,
                                  //                                           color: Color(0x33000000),
                                  //                                           offset: Offset(0.0, 2.0),
                                  //                                         )
                                  //                                       ],
                                  //                                       borderRadius: BorderRadius.circular(30.0),
                                  //                                       shape: BoxShape.rectangle,
                                  //                                     ),
                                  //                                     child: Align(
                                  //                                       alignment: AlignmentDirectional(0.00, 0.00),
                                  //                                       child: Text("Admin",
                                  //                                       ),
                                  //                                     ),
                                  //                                   ),
                                  //                                 ),
                                  //                             ],
                                  //                           ),
                                  //                         ),
                                  //                       ],
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //         ],
                                  //       ),
                                  //     );
                                  //   },
                                  // )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
