import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../app/routes/router.dart';
import '../../../../app/theme/app_theme.dart';
import '../../../services/models/company_model.dart';
import '../../../services/models/responseAPI_model.dart';
import '../../../services/repositories/company_repository.dart';

class ViewCompany extends StatefulWidget {
  const ViewCompany(this.companyUuid, {Key? key}) : super(key: key);
  final String companyUuid;

  @override
  _ViewCompanyState createState() => _ViewCompanyState();
}

class _ViewCompanyState extends State<ViewCompany> {
  int? countCompany;
  int? countParticipant;
  bool _loader = true;
  Company? company;

  @override
  void initState() {
    super.initState();
    initCompany();
  }

  initCompany() async {
    setState(() {
      _loader = true;
    });

    ResponseApi? response = await CompanyRepository().getCompany(context, widget.companyUuid);
    if (response != null && response.status == 200) {
      company = Company.fromJson(response.body);
    }

    setState(() {
      _loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loader
        ? Expanded(
            child: Center(
                child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 50.h),
                  child: const Text("Chargement : ")),
              const CircularProgressIndicator(),
            ],
          )))
        //TODO componat custom error request + text
        : company == null
            ? Expanded(
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/400.json',
                  ),
                ),
              )
            : Padding(
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
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 20.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, AppRouter.COMPANY_EDIT);
                                              },
                                              child: Container(
                                                width: 35.0,
                                                height: 35.0,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.of(context).primary,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: const Icon(
                                                  Icons.edit,
                                                  size: 20.0,
                                                ),
                                              )),
                                          const Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
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
                                            company!.name.toUpperCase(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Création :",
                                                style: TextStyle(
                                                  color: AppTheme.of(context).secondary,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                               Text(
                                                company!.createdAt,
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
                                                Navigator.pushNamed(
                                                    context, AppRouter.COMPANY_LIST_POEPLE);
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
                                                  size: 20.0,
                                                ),
                                              )),
                                          const Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
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
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 10.0, 10.0),
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
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                          child: Text(
                                            "0",
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
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 10.0, 10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Dépenses",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: AppTheme.of(context).secondary,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                          child: Text(
                                            "0",
                                            textAlign: TextAlign.start,
                                          ),
                                        )
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
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 10.0, 10.0),
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
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        const Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                          child: Text(
                                            "0",
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
                          Container(
                            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
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
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                     Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          const Text(
                                            "Code : ",
                                          ),
                                         Expanded(
                                           child: Text(
                                             company!.code,
                                             overflow: TextOverflow.ellipsis,
                                           ),
                                         )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, AppRouter.COMPANY_EDIT);
                                        },
                                        child: Container(
                                          width: 35.0,
                                          height: 35.0,
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade300,
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: const Icon(
                                            Icons.loop,
                                            size: 20.0,
                                          ),
                                        )),
                                  ],
                                ),
                                 Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Description : "),
                                      Flexible(
                                        child: AutoSizeText(
                                          company!.description,
                                          maxLines: 5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                            child: Image.network(
                              // stackCompaniesRecord.urlPicture,
                              'https://w7.pngwing.com/pngs/981/645/png-transparent-default-profile-united-states-computer-icons-desktop-free-high-quality-person-icon-miscellaneous-silhouette-symbol-thumbnail.png',
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
                          Container(
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
                                "Admin",
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, AppRouter.COMPANY_EDIT);
                              },
                              child: Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade300,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Icon(
                                  Icons.login,
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
