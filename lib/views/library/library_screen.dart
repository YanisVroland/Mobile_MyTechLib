
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tech_lib/services/models/project_model.dart';

import '../../app/routes/router.dart';
import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/color_const.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/icon_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/library_model.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/repositories/project_repository.dart';

class LibraryWidget extends StatefulWidget {
  const LibraryWidget(
    this.library, {
    Key? key,
  }) : super(key: key);
  final Library library;

  @override
  _LibraryWidgetState createState() => _LibraryWidgetState();
}

class _LibraryWidgetState extends State<LibraryWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController textController;
  late TabController tabBarController;
  List<Project> listProject = [];
  List<Project> listAPIProject = [];
  List<Project> listWebProject = [];
  List<Project> listMobileProject = [];
  bool _loader = false;

  @override
  void initState() {
    super.initState();

    textController = TextEditingController();

    initProjects();

    tabBarController = TabController(
      vsync: this,
      length: 4,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    textController.dispose();
    tabBarController?.dispose();
    super.dispose();
  }

  Future<void> initProjects() async {
    setState(() {
      _loader = true;
    });

    ResponseApi? response =
        await ProjectRepository().getProjectByLibrary(context, widget.library.uuid);
    if (response != null && response.status == 200) {
      List<dynamic> result = await response.body.map((doc) => Project.fromJson(doc)).toList();
      setState(() {
        listProject.addAll(result.cast<Project>());
        listAPIProject = listProject.where((element) => element.type == "API").toList();
        listWebProject = listProject.where((element) => element.type == "WEB").toList();
        listMobileProject = listProject.where((element) => element.type == "MOBILE").toList();
      });
    }
    setState(() {
      _loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).background,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, AppRouter.CREATE_PROJECT, arguments: widget.library);
        },
        backgroundColor: AppTheme.of(context).primary,
        child: const Icon(
          Icons.post_add_rounded,
          color: ColorConst.background,
          size: 32.0,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: IconCustom(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          borderWidth: 1.0,
                          buttonSize: 50.0,
                          icon: const Icon(
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 24.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                          child: Text(
                            widget.library.name,
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
                              Tab(text: "API"),
                              Tab(text: "WEB"),
                              Tab(text: "MOBILE"),
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
                                  : listProject.isEmpty
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
                                            itemCount: listProject.length,
                                            itemBuilder: (context, listViewIndex) {
                                              final element = listProject[listViewIndex];
                                              return Padding(
                                                padding: EdgeInsets.only(bottom: 10.h),
                                                child: InkWell(
                                                  onTap: () async {
                                                    Navigator.pushNamed(context, AppRouter.PROJECT,
                                                        arguments: element);
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
                                          ),
                                        ),
                              _loader
                                  ? Center(
                                      child: Lottie.asset(
                                        'assets/lottie/list_loader.json',
                                      ),
                                    )
                                  : listAPIProject.isEmpty
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
                                            itemCount: listAPIProject.length,
                                            itemBuilder: (context, listViewIndex) {
                                              final element = listAPIProject[listViewIndex];
                                              return Padding(
                                                padding: EdgeInsets.only(bottom: 10.h),
                                                child: InkWell(
                                                  onTap: () async {
                                                    Navigator.pushNamed(context, AppRouter.PROJECT,
                                                        arguments: element);
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
                                          ),
                                        ),
                              _loader
                                  ? Center(
                                      child: Lottie.asset(
                                        'assets/lottie/list_loader.json',
                                      ),
                                    )
                                  : listWebProject.isEmpty
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
                                            itemCount: listWebProject.length,
                                            itemBuilder: (context, listViewIndex) {
                                              final element = listWebProject[listViewIndex];
                                              return Padding(
                                                padding: EdgeInsets.only(bottom: 10.h),
                                                child: InkWell(
                                                  onTap: () async {
                                                    Navigator.pushNamed(context, AppRouter.PROJECT,
                                                        arguments: element);
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
                                          ),
                                        ),
                              _loader
                                  ? Center(
                                      child: Lottie.asset(
                                        'assets/lottie/list_loader.json',
                                      ),
                                    )
                                  : listMobileProject.isEmpty
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
                                            itemCount: listMobileProject.length,
                                            itemBuilder: (context, listViewIndex) {
                                              final element = listMobileProject[listViewIndex];
                                              return Padding(
                                                padding: EdgeInsets.only(bottom: 10.h),
                                                child: InkWell(
                                                  onTap: () async {
                                                    Navigator.pushNamed(context, AppRouter.PROJECT,
                                                        arguments: element);
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
