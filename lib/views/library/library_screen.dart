import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tech_lib/services/models/apiProject_model.dart';
import 'package:my_tech_lib/services/models/mobileProject_model.dart';
import 'package:my_tech_lib/services/models/project_model.dart';
import 'package:my_tech_lib/services/models/user_model.dart';
import 'package:my_tech_lib/services/models/webProject_model.dart';

import '../../app/routes/router.dart';
import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/color_const.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/DeleteDialog_custom.dart';
import '../../app/widgets/icon_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/library_model.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/repositories/library_repository.dart';
import '../../services/repositories/project_repository.dart';

class LibraryWidget extends StatefulWidget {
  LibraryWidget(
    this.user,
    this.library, {
    Key? key,
  }) : super(key: key);
  Library library;
  final UserModel user;

  @override
  _LibraryWidgetState createState() => _LibraryWidgetState();
}

class _LibraryWidgetState extends State<LibraryWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController textController;
  late TabController tabBarController;
  List<Project> listProject = [];
  List<Project> searchListMobileProject = [];

  List<Project> listAPIProject = [];
  List<Project> listWebProject = [];
  List<Project> listMobileProject = [];
  int nbProject = 0;
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
      searchListMobileProject.clear();
      List<dynamic> resultApi = await response.body.where((doc) => doc['type'] == 'API').map((doc) => ApiProject.fromJson(doc)).toList();
      List<dynamic> resultWeb = await response.body.where((doc) => doc['type'] == 'WEB').map((doc) => WebProject.fromJson(doc)).toList();
      List<dynamic> resultMobile =
          await response.body.where((doc) => doc['type'] == 'MOBILE').map((doc) => MobileProject.fromJson(doc)).toList();

      setState(() {
        nbProject = response.body.length;

        searchListMobileProject.addAll(resultApi.cast<ApiProject>());
        searchListMobileProject.addAll(resultWeb.cast<WebProject>());
        searchListMobileProject.addAll(resultMobile.cast<MobileProject>());

        listProject = searchListMobileProject;
        listAPIProject = resultApi.cast<ApiProject>();
        listWebProject = resultWeb.cast<WebProject>();
        listMobileProject = resultMobile.cast<MobileProject>();
      });
    }
    setState(() {
      _loader = false;
    });
  }

  Future<void> deleteLibrary() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          title: "Supprimer le Client ?",
          content: "Etes-vous sûr de vouloir supprimer ?",
          onCancel: () {
            Navigator.of(context).pop();
          },
          onDelete: () async {
            await LibraryRepository().deleteLibrary(context, widget.library.uuid);
            await initProjects();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).background,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, AppRouter.CREATE_PROJECT, arguments: widget.library);
          await initProjects();
        },
        backgroundColor: AppTheme.of(context).primary,
        child: const Icon(
          Icons.post_add_rounded,
          color: ColorConst.background,
          size: 32.0,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: widget.library.bannerUrl.isEmpty ? AppTheme.of(context).primary : null,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
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
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    widget.library.name,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 16.0, 5.0),
                          child: Text(
                            nbProject.toString() + " Projets",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ])),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (widget.library.logoUrl.isNotEmpty)
                          Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: AppTheme.of(context).primary,
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: widget.library.logoUrl.isNotEmpty
                                    ? Image.network(
                                        widget.library.logoUrl,
                                        key: UniqueKey(),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/images/tlchargement.png',
                                        key: UniqueKey(),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                ]),
            centerTitle: true,
            expandedTitleScale: 1.0,
            background: widget.library.bannerUrl.isNotEmpty
                ? Image.network(
                    widget.library.bannerUrl,
                    key: UniqueKey(),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          elevation: 0.0,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: SizedBox(
                  width: double.infinity,
                  height: 80.0,
                  child: Row(
                    children: [
                      Expanded(
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
                            onChanged: (value) {
                              List<Project> filteredLibraries =
                                  searchListMobileProject.where((project) {
                                return project.name.toLowerCase().contains(value.toLowerCase());
                              }).toList();
                              setState(() {
                                listProject = filteredLibraries;
                                listAPIProject = filteredLibraries
                                    .where((element) => element.type == "API")
                                    .toList();
                                listWebProject = filteredLibraries
                                    .where((element) => element.type == "WEB")
                                    .toList();
                                listMobileProject = filteredLibraries
                                    .where((element) => element.type == "MOBILE")
                                    .toList();
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              onTap: () async {
                                Object? newData = await Navigator.pushNamed(
                                    context, AppRouter.MODIFY_LIBRARY,
                                    arguments: [widget.user, widget.library]);
                                if (newData != null) {
                                  setState(() {
                                    widget.library = newData as Library;
                                  });
                                }
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.edit),
                                  Text('Modifier'),
                                ],
                              ),
                            ),
                            PopupMenuItem<String>(
                              textStyle: const TextStyle(color: Colors.red),
                              onTap: deleteLibrary,
                              child: const Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  Text('Supprimer', style: TextStyle(color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: ColorConst.primary,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
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
                                                    if(element.type == "API") {
                                                      await Navigator.pushNamed(context, AppRouter.PROJECT_API, arguments: element);
                                                    } else if(element.type == "WEB") {
                                                      await Navigator.pushNamed(context, AppRouter.PROJECT_WEB, arguments: element);
                                                    } else if(element.type == "MOBILE") {
                                                      await Navigator.pushNamed(context, AppRouter.PROJECT_MOBILE, arguments: element);
                                                    }
                                                    await initProjects();
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
                                                    await Navigator.pushNamed(
                                                        context, AppRouter.PROJECT_API,
                                                        arguments: element);
                                                    await initProjects();
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
                                                    await Navigator.pushNamed(
                                                        context, AppRouter.PROJECT_WEB,
                                                        arguments: element);
                                                    await initProjects();
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
                                                    await Navigator.pushNamed(
                                                        context, AppRouter.PROJECT_MOBILE,
                                                        arguments: element);
                                                    await initProjects();
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
