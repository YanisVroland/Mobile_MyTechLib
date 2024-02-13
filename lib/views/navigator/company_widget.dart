import 'package:auto_size_text/auto_size_text.dart';
import 'package:my_tech_lib/app/widgets/button_custom.dart';

import '../../app/routes/router.dart';
import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/validators.dart';
import '../../app/widgets/icon_custom.dart';

class CompanyWidget extends StatefulWidget {
  const CompanyWidget({Key? key}) : super(key: key);

  @override
  _CompanyWidgetState createState() => _CompanyWidgetState();
}

class _CompanyWidgetState extends State<CompanyWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  // ParticipantsRecord? participantUser;
  // Stores action output result for [Firestore Query - Query a collection] action in IconButton widget.
  int? countParticipant;

  // State field(s) for nameCompany widget.
  TextEditingController? nameCompanyController;
  String? Function(BuildContext, String?)? nameCompanyControllerValidator;

  // Stores action output result for [Firestore Query - Query a collection] action in Button-Login widget.
  int? countCompany;

  // Stores action output result for [Backend Call - Create Document] action in Button-Login widget.
  // CompaniesRecord? newCompany;
  // State field(s) for codeCompany widget.
  TextEditingController? codeCompanyController;
  String? Function(BuildContext, String?)? codeCompanyControllerValidator;

  // Stores action output result for [Firestore Query - Query a collection] action in Button-Login widget.
  // CompaniesRecord? companFindByCode;

  @override
  void initState() {
    super.initState();

    nameCompanyController ??= TextEditingController();
    codeCompanyController ??= TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameCompanyController?.dispose();
    codeCompanyController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).background,
      // floatingActionButton: Visibility(
      //   // visible: valueOrDefault<bool>(currentUserDocument?.hasCompany, false) ==
      //   //     true,
      //   child: AuthUserStreamWidget(
      //     builder: (context) => FloatingActionButton(
      //       onPressed: () async {
      //       //TODO Nav (
      //           'createCompanyLibrary',
      //           extra: <String, dynamic>{
      //             kTransitionInfoKey: TransitionInfo(
      //               hasTransition: true,
      //               transitionType: PageTransitionType.bottomToTop,
      //               duration: Duration(milliseconds: 220),
      //             ),
      //           },
      //         );
      //       },
      //       backgroundColor: AppTheme.of(context).tertiary,
      //       elevation: 8.0,
      //       child: Icon(
      //         Icons.post_add_rounded,
      //         color: AppTheme.of(context).textColor,
      //         size: 32.0,
      //       ),
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).background,
        automaticallyImplyLeading: false,
        title: const Text("Compagnie"),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
            child: InkWell(
              onTap: () async {
                Navigator.pushNamed(context, AppRouter.PROFILE);              },
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
          // if (valueOrDefault<bool>(currentUserDocument?.hasCompany, false) ==
          //     true)
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
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
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 35.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context).secondary,
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: IconCustom(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30.0,
                                                buttonSize: 45.0,
                                                icon: Icon(
                                                  Icons.edit,
                                                  size: 20.0,
                                                ),
                                                onPressed: () async {
                                                  //TODO Nav ('compagnyEdit'
                                                },
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 0.0, 0.0),
                                              child: Text(
                                                "Modification :",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                                            child: Text(
                                              "name",
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Création :",
                                              ),
                                              Text(
                                                'd/M/y',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 20.0, 0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 35.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                color: AppTheme.of(context).secondary,
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: IconCustom(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30.0,
                                                buttonSize: 45.0,
                                                icon: Icon(
                                                  Icons.people,
                                                  size: 20.0,
                                                ),
                                                onPressed: () async {
                                                  //TODO Nav ('compagnyListPeople'
                                                },
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 0.0, 0.0),
                                              child: Text("Participants :"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(10.0, 30.0, 10.0, 30.0),
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
                                        child: const Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              10.0, 10.0, 10.0, 10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Librairies",
                                                textAlign: TextAlign.start,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 5.0, 0.0, 0.0),
                                                child: Text(
                                                  "library.length",
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
                                        child: const Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              10.0, 10.0, 10.0, 10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Dépenses",
                                                textAlign: TextAlign.start,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 5.0, 0.0, 0.0),
                                                child: Text(
                                                  "spendingCardCount",
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
                                        child: const Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              10.0, 10.0, 10.0, 10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Projets",
                                                textAlign: TextAlign.start,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 5.0, 0.0, 0.0),
                                                child: Text(
                                                  "spendingCardCount",
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
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        20.0, 10.0, 20.0, 20.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppTheme.of(context).secondaryBackground,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              const Expanded(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      "Code :",
                                                    ),
                                                    SelectionArea(
                                                        child: Text(
                                                      "companyCode",
                                                    )),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 35.0,
                                                height: 35.0,
                                                decoration: BoxDecoration(
                                                  color: AppTheme.of(context).success,
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: IconCustom(
                                                  borderColor: Colors.transparent,
                                                  borderRadius: 30.0,
                                                  buttonSize: 46.0,
                                                  icon: Icon(
                                                    Icons.loop,
                                                    size: 20.0,
                                                  ),
                                                  onPressed: () async {},
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                0.0, 10.0, 0.0, 10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Description :"),
                                                Flexible(
                                                  child: AutoSizeText(
                                                    "description",
                                                    maxLines: 5,
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
                              Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF0000),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: IconCustom(
                                  borderColor: Colors.transparent,
                                  borderRadius: 30.0,
                                  buttonSize: 46.0,
                                  icon: Icon(
                                    Icons.login_rounded,
                                    size: 20.0,
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          // if (valueOrDefault<bool>(currentUserDocument?.hasCompany, false) ==
          //     false)
          if (true)
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                          child: Container(
                            width: double.infinity,
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
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(70.0),
                                topRight: Radius.circular(70.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 40.0, 12.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).secondaryBackground,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Text(
                                          "Ajouter votre compagnie ",
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 30.0, 0.0, 0.0),
                                          child: TextFormField(
                                            controller: nameCompanyController,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: "Nom compagnie ...",
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.of(context).primary,
                                                  width: 2.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 2.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFFF0000),
                                                  width: 2.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFFF0000),
                                                  width: 2.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor: AppTheme.of(context).secondaryBackground,
                                              contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 24.0, 20.0, 24.0),
                                              prefixIcon: const Icon(
                                                Icons.home_work_sharp,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 30.0, 0.0, 0.0),
                                          child: CustomButton(
                                            text: "Ajouter",
                                            onTap: () async {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 50.0,
                                    thickness: 1.0,
                                    color: AppTheme.of(context).primary,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).secondaryBackground,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Text("Rejoindre une companie"),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 30.0, 0.0, 0.0),
                                          child: TextFormField(
                                              controller: codeCompanyController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintText: "Code compagnie",
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: AppTheme.of(context).primary,
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFFF0000),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                focusedErrorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFFFF0000),
                                                    width: 2.0,
                                                  ),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                filled: true,
                                                fillColor: AppTheme.of(context).secondaryBackground,
                                                contentPadding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                        20.0, 24.0, 20.0, 24.0),
                                                prefixIcon: const Icon(
                                                  Icons.link,
                                                ),
                                              ),
                                              validator: Validators.validateEmpty),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 30.0, 0.0, 0.0),
                                          child: CustomButton(
                                            text: "Rejoindre",
                                            onTap: () async {},
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
              ],
            )
        ],
      ),
    );
  }
}
