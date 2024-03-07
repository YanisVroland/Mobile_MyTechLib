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
import '../../services/repositories/library_repository.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController textController;
  late TabController tabBarController;
  List<Library> listPersonalLibrairies = [];
  List<Library> listCompanyLibrairies = [];
  late bool inCompany;
  bool _loader = true;

  int get tabBarCurrentIndex => tabBarController.index;

  @override
  void initState() {
    super.initState();
    getPersonalLibraries();

    textController = TextEditingController();

    //TODO relier value
    inCompany = false;

    tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  Future<void> getPersonalLibraries() async {
    setState(() {
      _loader = true;
    });

    ResponseApi? response = await LibraryRepository().getPersonalLibrary(context);
    if (response != null && response.status == 200) {
      List<dynamic> result = await response.body.map((doc) => Library.fromJson(doc)).toList();
      listPersonalLibrairies.addAll(result.cast<Library>());
    }

    setState(() {
      _loader = false;
    });
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
            _loader
                ? Expanded(
                    child: Center(
                      child: Lottie.asset(
                        'assets/lottie/list_loader.json',
                      ),
                    ),
                  )
                :
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
                              Padding(
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
                                          //TODO Nav (
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
                                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          element.name,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional.fromSTEB(
                                                                  0.0, 10.0, 0.0, 0.0),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                            children: [
                                                              const Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(0.0, 0.0, 4.0, 0.0),
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
                                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                                      12.0, 0.0, 12.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                              inCompany
                                  ? Padding(padding: EdgeInsets.all(10.w), child: Container())
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
                              Padding(
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
                                          //TODO Nav (
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
                                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                                        12.0, 0.0, 0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          element.name,
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsetsDirectional.fromSTEB(
                                                              0.0, 10.0, 0.0, 0.0),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                              const Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(0.0, 0.0, 4.0, 0.0),
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
                                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                                      12.0, 0.0, 12.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
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
