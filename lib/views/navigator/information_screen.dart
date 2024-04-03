import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tech_lib/services/models/company_model.dart';

import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/tools.dart';
import '../../app/widgets/appBar_custom.dart';
import '../../services/models/information_model.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/repositories/information_repository.dart';

class InformationWidget extends StatefulWidget {
  const InformationWidget(this.company, {Key? key}) : super(key: key);
  final Company? company;

  @override
  _InformationWidgetState createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> with TickerProviderStateMixin {
  int filterIdx = 1;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Information> listInformation = [];
  List<Information> listInformationTmp = [];
  bool _loader = true;
  bool hadCompany = false;
  int nbNewInformation = 0;
  int nbDeleteInformation = 0;
  int nbUpdateInformation = 0;

  @override
  void initState() {
    super.initState();
    hadCompany = widget.company != null;
    if (hadCompany) {
      initInformation();
    }
  }

  Future<void> initInformation() async {
    setState(() {
      _loader = true;
    });

    ResponseApi? response =
        await InformationRepository().getInformationByCompany(context, widget.company!.uuid);
    if (response != null && response.status == 200) {
      List<dynamic> result = await response.body.map((doc) => Information.fromJson(doc)).toList();

      setState(() {
        listInformationTmp = result.cast<Information>();
        listInformation = result.cast<Information>();
        updateGlobalList();
      });
    }

    setState(() {
      _loader = false;
    });
  }

  updateGlobalList() {
    DateTime now = DateTime.now();

    switch (filterIdx) {
      case 1:
        DateTime startOfDay = DateTime(now.year, now.month, now.day);
        DateTime endOfDay = DateTime(now.year, now.month, now.day + 1);

        listInformation = listInformationTmp
            .where((element) =>
        element.createdAt!.isAfter(startOfDay) &&
            element.createdAt!.isBefore(endOfDay))
            .toList();
        break;
      case 2:
        DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));

        listInformation = listInformationTmp
            .where((element) =>
                element.createdAt!.isAfter(sevenDaysAgo) && element.createdAt!.isBefore(now))
            .toList();
        break;
      case 3:
        int currentMonth = now.month;
        DateTime firstDayOfMonth = DateTime(now.year, currentMonth, 1);
        DateTime firstDayOfNextMonth = DateTime(now.year, currentMonth + 1, 1);

        listInformation = listInformationTmp
            .where((element) =>
        element.createdAt!.isAfter(firstDayOfMonth) &&
            element.createdAt!.isBefore(firstDayOfNextMonth))
            .toList();
        break;
    }


    setState(() {
      nbNewInformation = listInformation.where((element) => element.type == 'NEW').length;
      nbDeleteInformation = listInformation.where((element) => element.type == 'DELETE').length;
      nbUpdateInformation = listInformation.where((element) => element.type == 'UPDATE').length;
    });

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
      appBar: const CustomAppBar(),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (filterIdx != 1) {
                          setState(() {
                            filterIdx = 1;
                            updateGlobalList();
                          });
                        }
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
                            bottomLeft: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0),
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
                        if (filterIdx != 2) {
                          setState(() {
                            filterIdx = 2;
                            updateGlobalList();
                          });
                        }
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
                        if (filterIdx != 3) {
                          setState(() {
                            filterIdx = 3;
                            updateGlobalList();
                          });
                        }
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
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
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
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                            child: Text(
                              nbNewInformation.toString(),
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
                              nbUpdateInformation.toString(),
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
                            "Suppression",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: AppTheme.of(context).secondary,
                              fontSize: 12.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                            child: Text(
                              nbDeleteInformation.toString(),
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
            hadCompany
                ? Expanded(
                    child: _loader
                        ? Center(
                            child: Lottie.asset(
                              'assets/lottie/list_loader.json',
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: listInformation.isEmpty
                                ? Center(
                                    child: Lottie.asset(
                                      'assets/lottie/list_empty.json',
                                    ),
                                  )
                                : ListView.builder(
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
                                          child: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 0.0, 10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                                "Client : " + element.core_library),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsetsDirectional
                                                                .fromSTEB(0.0, 4.0, 0.0, 0.0),
                                                            child: Text("Type : " + element.type),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                                        12.0, 0.0, 12.0, 0.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          Tools.formatDate(element.createdAt!),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional.fromSTEB(
                                                                  0.0, 4.0, 0.0, 0.0),
                                                          child: Text("Par : " + element.createdBy),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                  )
                : Column(
                    children: [
                      Lottie.asset(
                        'assets/lottie/without_company.json',
                        height: 200.h,
                        width: 300.w,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Text(
                          "Vous n'avez pas encore d'entreprise",
                          style: TextStyle(
                            color: AppTheme.of(context).primary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
