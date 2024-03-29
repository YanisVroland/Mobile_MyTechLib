import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tech_lib/app/theme/color_const.dart';

import '../../app/routes/router.dart';
import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/validators.dart';
import '../../app/widgets/appBar_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/library_model.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/models/user_model.dart';
import '../../services/repositories/library_repository.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget(this.user, {Key? key}) : super(key: key);
  final UserModel user;

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController textController;
  late TabController tabBarController;
  List<Library> listPersonalLibrairies = [];
  List<Library> listCompanyLibrairies = [];
  List<Library> globalListLibrairies = [];
  late bool inCompany;
  bool _loader = true;

  int get tabBarCurrentIndex => tabBarController.index;

  @override
  void initState() {
    super.initState();

    // TODO ajouter vraie variable
    inCompany = widget.user.companyUuid.isNotEmpty;
    initData();

    textController = TextEditingController();

    tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  Future<void> initData() async {
    setState(() {
      _loader = true;
    });
    await getPersonalLibraries();
    if (inCompany) {
      await getCompanyLibraries();
    }
    setState(() {
      _loader = false;
    });
  }

  Future<void> getPersonalLibraries() async {
    ResponseApi? response = await LibraryRepository().getPersonalLibrary(context);
    if (response != null && response.status == 200) {
      List<dynamic> result = await response.body.map((doc) => Library.fromJson(doc)).toList();

      setState(() {
        listPersonalLibrairies.addAll(result.cast<Library>());
        globalListLibrairies.addAll(result.cast<Library>());
      });
    }
  }

  Future<void> getCompanyLibraries() async {
    ResponseApi? response =
        await LibraryRepository().getCompanyLibrary(context, widget.user.companyUuid);
    if (response != null && response.status == 200) {
      List<dynamic> result = await response.body.map((doc) => Library.fromJson(doc)).toList();

      setState(() {
        listCompanyLibrairies.addAll(result.cast<Library>());
        globalListLibrairies.addAll(result.cast<Library>());
      });
    }
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
          Navigator.pushNamed(context, AppRouter.CREATE_LIBRARY, arguments: widget.user);
        },
        backgroundColor: AppTheme.of(context).primary,
        child: const Icon(
          Icons.post_add_rounded,
          color: ColorConst.background,
          size: 32.0,
        ),
      ),
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.h, top: 15.h),
              child: Container(
                width: double.infinity,
                height: 50.0,
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
                child: CustomTextField(
                  fillColor: AppTheme.of(context).secondaryBackground,
                  controller: textController,
                  hintText: "Recherche par nom ...",
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                    color: ColorConst.primary,
                    size: 24.0,
                  ),
                  validator: Validators.validateEmpty,
                ),
              ),
            ),
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        Align(
                          child: TabBar(
                            indicatorColor: AppTheme.of(context).secondary,
                            padding: EdgeInsets.all(4.h),
                            labelColor: AppTheme.of(context).primary,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                            tabs: const [
                              Tab(text: "TOUT"),
                              Tab(
                                text: "ENTREPRISE",
                              ),
                              Tab(
                                text: "PERSONNEL",
                              ),
                            ],
                            controller: tabBarController,
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabBarController,
                            children: [
                              _loader
                                  ? Center(
                                      child: Lottie.asset(
                                        'assets/lottie/list_loader.json',
                                      ),
                                    )
                                  : globalListLibrairies.isEmpty
                                      ? Center(
                                          child: Lottie.asset(
                                            'assets/lottie/list_empty.json',
                                          ),
                                        )
                                  : Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: globalListLibrairies.length,
                                        itemBuilder: (context, listViewIndex) {
                                          final element = globalListLibrairies[listViewIndex];
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 10.h),
                                            child: InkWell(
                                              onTap: () async {
                                                Navigator.pushNamed(context, AppRouter.LIBRARY, arguments: element);
                                              },
                                              child: Container(
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
                                                          padding:
                                                              const EdgeInsetsDirectional.fromSTEB(
                                                                  12.0, 0.0, 0.0, 0.0),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                element.name,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.center,
                                                                  children: [
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsetsDirectional
                                                                                .fromSTEB(0.0, 0.0,
                                                                                    4.0, 0.0),
                                                                        child: Text("Créée par :")),
                                                                    Text(
                                                                      element.createdBy,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                                12.0, 0.0, 12.0, 0.0),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              element.createdAt,
                                                              textAlign: TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              _loader
                                  ? Expanded(
                                      child: Center(
                                        child: Lottie.asset(
                                          'assets/lottie/list_loader.json',
                                        ),
                                      ),
                                    )
                                  : inCompany
                                      ?  listCompanyLibrairies.isEmpty
                                  ? Center(
                                child: Lottie.asset(
                                  'assets/lottie/list_empty.json',
                                ),
                              )
                                  :Padding(
                                           padding: EdgeInsets.all(10.w),
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: listCompanyLibrairies.length,
                                            itemBuilder: (context, listViewIndex) {
                                              final element = listCompanyLibrairies[listViewIndex];
                                              return Padding(
                                                padding: EdgeInsets.only(bottom: 10.h),
                                                child: InkWell(
                                                  onTap: () async {
                                                    Navigator.pushNamed(context, AppRouter.LIBRARY, arguments: element);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppTheme.of(context).secondaryBackground,
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
                                                              padding: const EdgeInsetsDirectional
                                                                  .fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment.start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    element.name,
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsetsDirectional
                                                                            .fromSTEB(
                                                                            0.0, 10.0, 0.0, 0.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize.max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.center,
                                                                      children: [
                                                                        const Padding(
                                                                            padding:
                                                                                EdgeInsetsDirectional
                                                                                    .fromSTEB(
                                                                                        0.0,
                                                                                        0.0,
                                                                                        4.0,
                                                                                        0.0),
                                                                            child: Text(
                                                                                "Créée par :")),
                                                                        Text(
                                                                          element.createdBy,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsetsDirectional
                                                                .fromSTEB(12.0, 0.0, 12.0, 0.0),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment.end,
                                                              children: [
                                                                Text(
                                                                  element.createdAt,
                                                                  textAlign: TextAlign.end,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ))
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
                              _loader
                                  ? Expanded(
                                      child: Center(
                                        child: Lottie.asset(
                                          'assets/lottie/list_loader.json',
                                        ),
                                      ),
                                    )
                                  : listPersonalLibrairies.isEmpty
                                      ? Center(
                                          child: Lottie.asset(
                                            'assets/lottie/list_empty.json',
                                          ),
                                        )
                                      : Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: listPersonalLibrairies.length,
                                        itemBuilder: (context, listViewIndex) {
                                          final element = listPersonalLibrairies[listViewIndex];
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 10.h),
                                            child: InkWell(
                                              onTap: () async {
                                                Navigator.pushNamed(context, AppRouter.LIBRARY, arguments: element);
                                              },
                                              child: Container(
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
                                                          padding:
                                                              const EdgeInsetsDirectional.fromSTEB(
                                                                  12.0, 0.0, 0.0, 0.0),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                element.name,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.center,
                                                                  children: [
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsetsDirectional
                                                                                .fromSTEB(0.0, 0.0,
                                                                                    4.0, 0.0),
                                                                        child: Text("Créée par :")),
                                                                    Text(
                                                                      element.createdBy,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional.fromSTEB(
                                                                12.0, 0.0, 12.0, 0.0),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              element.createdAt,
                                                              textAlign: TextAlign.end,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
