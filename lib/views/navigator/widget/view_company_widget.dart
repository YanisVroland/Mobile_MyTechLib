import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/app/theme/color_const.dart';

import '../../../../app/routes/router.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../app/widgets/DeleteDialog_custom.dart';
import '../../../services/local/pref.dart';
import '../../../services/models/company_model.dart';
import '../../../services/models/globalData_model.dart';
import '../../../services/models/responseAPI_model.dart';
import '../../../services/repositories/company_repository.dart';

class ViewCompany extends StatefulWidget {
  const ViewCompany(this.globalData, {Key? key}) : super(key: key);
  final GlobalData globalData;

  @override
  _ViewCompanyState createState() => _ViewCompanyState();
}

class _ViewCompanyState extends State<ViewCompany> {
  @override
  void initState() {
    super.initState();
    getStatistiques();
  }

  getStatistiques() async {
    final ResponseApi? response =
        await CompanyRepository().getStatistiqueCompany(context, widget.globalData.company!.uuid);
    if (response != null && response.status == 200) {
      widget.globalData.company!.projectCpt = response.body["projectCpt"];
      widget.globalData.company!.libraryCpt = response.body["libraryCpt"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).secondaryBackground,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(0.0, 2.0),
                          )
                        ],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                          topLeft: Radius.circular(70.0),
                          topRight: Radius.circular(70.0),
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        if (widget.globalData.user.companyAdmin) {
                                          await Navigator.pushNamed(context, AppRouter.COMPANY_EDIT,
                                              arguments: widget.globalData.company!);

                                          setState(() {
                                            getStatistiques();
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 35.0,
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                          color: widget.globalData.user.companyAdmin
                                              ? AppTheme.of(context).primary
                                              : AppTheme.of(context).primary.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: ColorConst.background,
                                          size: 20.0,
                                        ),
                                      )),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                    child: Text(
                                      "Modification",
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    widget.globalData.company!.name.toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        widget.globalData.company!.createdAt,
                                        style: const TextStyle(
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, AppRouter.COMPANY_LIST_POEPLE,
                                            arguments: widget.globalData);
                                      },
                                      child: Container(
                                        width: 35.0,
                                        height: 35.0,
                                        decoration: BoxDecoration(
                                          color: AppTheme.of(context).primary,
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: const Icon(
                                          Icons.people,
                                          color: ColorConst.background,
                                          size: 20.0,
                                        ),
                                      )),
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                    child: Text(
                                      "Participants",
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ))),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  "Librairies",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppTheme.of(context).secondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                  child: Text(
                                    widget.globalData.company!.libraryCpt.toString(),
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
                                  "Projets",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: AppTheme.of(context).secondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                  child: Text(
                                    widget.globalData.company!.projectCpt.toString(),
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
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 15.w,
                              top: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).secondaryBackground,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(70.0),
                                bottomRight: Radius.circular(70.0),
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x3F14181B),
                                  offset: Offset(0.0, 3.0),
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: widget.globalData.user.companyAdmin,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                          child: InkWell(
                                        onTap: () async {
                                          Clipboard.setData(
                                              ClipboardData(text: widget.globalData.company!.code));
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Code copié"),
                                              backgroundColor: Colors.green,
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const Text(
                                              "Code : ",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                widget.globalData.company!.code,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                      Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(right: 10.w),
                                              child: InkWell(
                                                  onTap: () async {
                                                    Clipboard.setData(ClipboardData(
                                                        text: widget.globalData.company!.code));
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                        content: Text("Code copié"),
                                                        backgroundColor: Colors.green,
                                                        duration: Duration(seconds: 1),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 35.0,
                                                    height: 35.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue.shade300,
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                    child: const Icon(
                                                      Icons.copy,
                                                      color: ColorConst.background,
                                                      size: 20.0,
                                                    ),
                                                  ))),
                                          InkWell(
                                              onTap: () async {
                                                if (widget.globalData.user.companyAdmin) {
                                                  ResponseApi? response = await CompanyRepository()
                                                      .changeCodeCompany(
                                                          context, widget.globalData.company!.uuid);
                                                  if (response != null && response.status == 200) {
                                                    setState(() {
                                                      widget.globalData.company!.code =
                                                          response.body['code'];
                                                    });
                                                  }
                                                }
                                              },
                                              child: Container(
                                                width: 35.0,
                                                height: 35.0,
                                                decoration: BoxDecoration(
                                                  color: widget.globalData.user.companyAdmin
                                                      ? Colors.green.shade300
                                                      : Colors.green.shade300.withOpacity(0.5),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: const Icon(
                                                  Icons.loop,
                                                  color: ColorConst.background,
                                                  size: 20.0,
                                                ),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                                  child: const Text(
                                    "Description : ",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                widget.globalData.company!.description.isNotEmpty
                                    ? AutoSizeText(
                                        widget.globalData.company!.description,
                                        maxLines: 10,
                                        textAlign: TextAlign.justify,
                                      )
                                    : const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Pas de description disponible",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      )
                              ],
                            ),
                          )))
                ],
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0.00, -1.00),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).secondaryBackground,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Color(0x33000000),
                        offset: Offset(0.0, 2.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(33.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: widget.globalData.company!.logoUrl.isNotEmpty
                        ? Image.network(
                            widget.globalData.company!.logoUrl,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/tlchargement.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.globalData.user.companyAdmin
                      ? Container(
                          width: 70.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: AppTheme.of(context).secondary,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x33000000),
                                offset: Offset(0.0, 2.0),
                              )
                            ],
                            borderRadius: BorderRadius.circular(30.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: const Align(
                            alignment: AlignmentDirectional(0.00, 0.00),
                            child: Text(
                              "ADMIN",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: AppTheme.of(context).primary,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x33000000),
                                offset: Offset(0.0, 2.0),
                              )
                            ],
                            borderRadius: BorderRadius.circular(30.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: const Align(
                            alignment: AlignmentDirectional(0.00, 0.00),
                            child: Text(
                              "  COLLABORATEUR  ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                  InkWell(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DeleteDialog(
                                title: "Partir de l'entreprise ?",
                                content: "Êtes-vous sûr ?",
                                onCancel: () {
                                  Navigator.of(context).pop();
                                },
                                onDelete: () async {
                                  String uuidUser = await LocalPref().getString("uuid_user");
                                  ResponseApi? response =
                                      await CompanyRepository().leaveCompany(context, uuidUser);
                                  if (response != null && response.status == 200) {
                                    await Navigator.pushNamed(context, AppRouter.MAIN,
                                        arguments: uuidUser);
                                  }
                                },
                              );
                            });
                      },
                      child: Container(
                        width: 35.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                          color: ColorConst.delete,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Icon(
                          Icons.login,
                          color: ColorConst.background,
                          size: 20.0,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
