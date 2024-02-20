import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/app/theme/app_const.dart';

import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/routes/router.dart';
import '../../services/models/information.dart';

class InformationWidget extends StatefulWidget {
  const InformationWidget({Key? key}) : super(key: key);

  @override
  _InformationWidgetState createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> with TickerProviderStateMixin {
  int filterIdx = 1;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Information> listInformation;

  @override
  void initState() {
    super.initState();
    listInformation = [
      Information(id: "1", createdBy: "Yanis", createdAt: "12/12/2001", updatedAt: "12/12/2001"),
      Information(id: "2", createdBy: "Yanis", createdAt: "12/12/2001", updatedAt: "12/12/2001"),
      Information(id: "3", createdBy: "Yanis", createdAt: "12/12/2001", updatedAt: "12/12/2001"),
    ];
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
        backgroundColor: AppTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title:
            const Text(AppConst.appName, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
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
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
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
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x33000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                          ),
                          border: Border.all(
                            color: filterIdx == 1
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).background,
                          ),
                        ),
                        alignment: const AlignmentDirectional(0.00, 0.00),
                        child: Text(
                          "Aujourd'hui ",
                          style: TextStyle(
                            color: filterIdx == 1 ? Colors.white : Colors.black,
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
                          boxShadow: const [
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
                        alignment: const AlignmentDirectional(0.00, 0.00),
                        child: Text(
                          "Semaine",
                          style: TextStyle(
                            color: filterIdx == 2 ? Colors.white : Colors.black,
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
                          filterIdx = 3;
                        });
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: filterIdx == 3
                              ? AppTheme.of(context).primary
                              : AppTheme.of(context).background,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x33000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          border: Border.all(
                            color: filterIdx == 3
                                ? AppTheme.of(context).primary
                                : AppTheme.of(context).background,
                          ),
                        ),
                        alignment: const AlignmentDirectional(0.00, 0.00),
                        child: Text(
                          "Mois",
                          style: TextStyle(
                            color: filterIdx == 3 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 20.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.25,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x3F14181B),
                          offset: Offset(0.0, 3.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Nouveau",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppTheme.of(context).secondary,
                              fontSize: 12.0,
                            ),
                          ),
                          const Padding(
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
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x3F14181B),
                          offset: Offset(0.0, 3.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Mise à jour",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppTheme.of(context).secondary,
                              fontSize: 12.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
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
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x3F14181B),
                          offset: Offset(0.0, 3.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Supression",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppTheme.of(context).secondary,
                              fontSize: 12.0,
                            ),
                          ),
                          const Padding(
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
            Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  "Liste des informations",
                  style: TextStyle(
                    color: AppTheme.of(context).primary,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listInformation.length,
                  itemBuilder: (context, listViewIndex) {
                    final element = listInformation[listViewIndex];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Container(
                        height: 70.0,
                        decoration: BoxDecoration(
                          color: AppTheme.of(context).secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x3F14181B),
                              offset: Offset(0.0, 3.0),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text("Client : Microsoft "),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                        child: Text("Nouveau shelf : Amazon "),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                        child: Text("Par : Yanis Vroland "),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      " 12/07/2022 ",
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
