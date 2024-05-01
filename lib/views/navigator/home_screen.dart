import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tech_lib/app/theme/color_const.dart';

import '../../app/routes/router.dart';
import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/tools.dart';
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
  List<Library> searchListLibrairies = [];
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
      listPersonalLibrairies.clear();
      globalListLibrairies.clear();
      listCompanyLibrairies.clear();
      searchListLibrairies.clear();
    });
    await getPersonalLibraries();
    if (inCompany) {
      await getCompanyLibraries();
    }

    searchListLibrairies.sort((a, b) {
      if (a.updatedAt != null && b.updatedAt != null) {
        return b.updatedAt!.compareTo(a.updatedAt!);
      } else {
        if (a.updatedAt == null && b.updatedAt == null) {
          return 0;
        } else if (a.updatedAt == null) {
          return -1;
        } else {
          return 1;
        }
      }
    });

    globalListLibrairies = searchListLibrairies;
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
        searchListLibrairies.addAll(result.cast<Library>());
      });
      listPersonalLibrairies.sort((a, b) {
        if (a.updatedAt != null && b.updatedAt != null) {
          return b.updatedAt!.compareTo(a.updatedAt!);
        } else {
          if (a.updatedAt == null && b.updatedAt == null) {
            return 0;
          } else if (a.updatedAt == null) {
            return -1;
          } else {
            return 1;
          }
        }
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
        searchListLibrairies.addAll(result.cast<Library>());
      });
      listCompanyLibrairies.sort((a, b) {
        if (a.updatedAt != null && b.updatedAt != null) {
          return b.updatedAt!.compareTo(a.updatedAt!);
        } else {
          if (a.updatedAt == null && b.updatedAt == null) {
            return 0;
          } else if (a.updatedAt == null) {
            return -1;
          } else {
            return 1;
          }
        }
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
          await Navigator.pushNamed(context, AppRouter.CREATE_LIBRARY, arguments: widget.user);
          await initData();
        },
        backgroundColor: AppTheme.of(context).primary,
        child: const Icon(
          Icons.post_add_rounded,
          color: ColorConst.background,
          size: 32.0,
        ),
      ),
      appBar: CustomAppBar(widget.user),
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
                  onChanged: (value) {
                    List<Library> filteredLibraries = searchListLibrairies.where((library) {
                      return library.name.toLowerCase().contains(value.toLowerCase());
                    }).toList();

                    setState(() {
                      globalListLibrairies = filteredLibraries;
                      listCompanyLibrairies = filteredLibraries.where((library) {
                        return library.core_company != null && library.core_company!.isNotEmpty;
                      }).toList();
                      listPersonalLibrairies = filteredLibraries.where((library) {
                        return library.core_company == null || library.core_company!.isEmpty;
                      }).toList();
                    });
                  },
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
                                                    await Navigator.pushNamed(
                                                        context, AppRouter.LIBRARY,
                                                        arguments: [widget.user, element]);
                                                    await initData();
                                                  },
                                                  child: Container(
                                                    height: 70.0,
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
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: 7.w, bottom: 7.w),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                children: [
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding:
                                                                          const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              12.0, 0.0, 0.0, 0.0),
                                                                      child: Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                        children: [
                                                                          Text(
                                                                            element.name,
                                                                            style: const TextStyle(
                                                                                fontSize: 17.0,
                                                                                fontWeight:
                                                                                    FontWeight
                                                                                        .bold),
                                                                          ),
                                                                          Text(
                                                                            element.projectCount
                                                                                    .toString() +
                                                                                " projets",
                                                                            style: const TextStyle(
                                                                                fontSize: 12.0,
                                                                                color: Color(
                                                                                    0xFF8B97A2)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      child: Padding(
                                                                    padding:
                                                                        EdgeInsets.only(right: 10.w),
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.end,
                                                                      children: [
                                                                        element.isPersonal
                                                                            ? Container()
                                                                            : Container(
                                                                                width: 65.w,
                                                                                height: 14.h,
                                                                                decoration:
                                                                                    BoxDecoration(
                                                                                  color: AppTheme.of(
                                                                                          context)
                                                                                      .secondary,
                                                                                  borderRadius:
                                                                                      BorderRadius
                                                                                          .circular(
                                                                                              8.0),
                                                                                ),
                                                                                child: const Center(
                                                                                  child: Text(
                                                                                    "ENTREPRISE",
                                                                                    style:
                                                                                        TextStyle(
                                                                                      fontSize: 9,
                                                                                      color: Colors
                                                                                          .white,
                                                                                      fontWeight:
                                                                                          FontWeight
                                                                                              .bold,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .end,
                                                                          children: [
                                                                            const Text(
                                                                              "Mise à jour :",
                                                                              style: TextStyle(
                                                                                fontSize: 10.0,
                                                                                color: Color(
                                                                                    0xFF8E8E93),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              Tools.formatDate(
                                                                                  element
                                                                                      .updatedAt!),
                                                                              style: TextStyle(
                                                                                  fontSize: 12.0,
                                                                                  color: AppTheme.of(
                                                                                          context)
                                                                                      .primary),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )),
                                                                ],
                                                              )),
                                                        ),
                                                        Container(
                                                            width: 50.w,
                                                            height: 70.h,
                                                            decoration: BoxDecoration(
                                                              color: AppTheme.of(context).tertiary,
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius.circular(8.0),
                                                                  bottomRight: Radius.circular(8.0)),
                                                            ),
                                                            child: const Icon(
                                                              Icons.send,
                                                              color: ColorConst.background,
                                                            )),
                                                      ],
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
                                      ? listCompanyLibrairies.isEmpty
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
                                                itemCount: listCompanyLibrairies.length,
                                                itemBuilder: (context, listViewIndex) {
                                                  final element =
                                                      listCompanyLibrairies[listViewIndex];
                                                  return Padding(
                                                    padding: EdgeInsets.only(bottom: 10.h),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        await Navigator.pushNamed(
                                                            context, AppRouter.LIBRARY,
                                                            arguments: [widget.user, element]);
                                                        await initData();
                                                      },
                                                      child: Container(
                                                        height: 70.0,
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
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: 7.w, bottom: 7.w),
                                                                  child: Row(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.spaceBetween,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                    children: [
                                                                      Expanded(
                                                                        child: Padding(
                                                                          padding:
                                                                          const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              12.0, 0.0, 0.0, 0.0),
                                                                          child: Column(
                                                                            mainAxisSize:
                                                                            MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceBetween,
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                            children: [
                                                                              Text(
                                                                                element.name,
                                                                                style: const TextStyle(
                                                                                    fontSize: 17.0,
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .bold),
                                                                              ),
                                                                              Text(
                                                                                element.projectCount
                                                                                    .toString() +
                                                                                    " projets",
                                                                                style: const TextStyle(
                                                                                    fontSize: 12.0,
                                                                                    color: Color(
                                                                                        0xFF8B97A2)),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                          child: Padding(
                                                                            padding:
                                                                            EdgeInsets.only(right: 10.w),
                                                                            child: Column(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment
                                                                                  .spaceBetween,
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                              children: [
                                                                                element.isPersonal
                                                                                    ? Container()
                                                                                    : Container(
                                                                                  width: 65.w,
                                                                                  height: 14.h,
                                                                                  decoration:
                                                                                  BoxDecoration(
                                                                                    color: AppTheme.of(
                                                                                        context)
                                                                                        .secondary,
                                                                                    borderRadius:
                                                                                    BorderRadius
                                                                                        .circular(
                                                                                        8.0),
                                                                                  ),
                                                                                  child: const Center(
                                                                                    child: Text(
                                                                                      "ENTREPRISE",
                                                                                      style:
                                                                                      TextStyle(
                                                                                        fontSize: 9,
                                                                                        color: Colors
                                                                                            .white,
                                                                                        fontWeight:
                                                                                        FontWeight
                                                                                            .bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Column(
                                                                                  mainAxisSize:
                                                                                  MainAxisSize.min,
                                                                                  mainAxisAlignment:
                                                                                  MainAxisAlignment.end,
                                                                                  crossAxisAlignment:
                                                                                  CrossAxisAlignment
                                                                                      .end,
                                                                                  children: [
                                                                                    const Text(
                                                                                      "Mise à jour :",
                                                                                      style: TextStyle(
                                                                                        fontSize: 10.0,
                                                                                        color: Color(
                                                                                            0xFF8E8E93),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      Tools.formatDate(
                                                                                          element
                                                                                              .updatedAt!),
                                                                                      style: TextStyle(
                                                                                          fontSize: 12.0,
                                                                                          color: AppTheme.of(
                                                                                              context)
                                                                                              .primary),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  )),
                                                            ),
                                                            Container(
                                                                width: 50.w,
                                                                height: 70.h,
                                                                decoration: BoxDecoration(
                                                                  color: AppTheme.of(context).tertiary,
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight: Radius.circular(8.0),
                                                                      bottomRight: Radius.circular(8.0)),
                                                                ),
                                                                child: const Icon(
                                                                  Icons.send,
                                                                  color: ColorConst.background,
                                                                )),
                                                          ],
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
                                                    await Navigator.pushNamed(
                                                        context, AppRouter.LIBRARY,
                                                        arguments: [widget.user, element]);
                                                    await initData();
                                                  },
                                                  child: Container(
                                                    height: 70.0,
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
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: 7.w, bottom: 7.w),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceBetween,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                                children: [
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          12.0, 0.0, 0.0, 0.0),
                                                                      child: Column(
                                                                        mainAxisSize:
                                                                        MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                        children: [
                                                                          Text(
                                                                            element.name,
                                                                            style: const TextStyle(
                                                                                fontSize: 17.0,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .bold),
                                                                          ),
                                                                          Text(
                                                                            element.projectCount
                                                                                .toString() +
                                                                                " projets",
                                                                            style: const TextStyle(
                                                                                fontSize: 12.0,
                                                                                color: Color(
                                                                                    0xFF8B97A2)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      child: Padding(
                                                                        padding:
                                                                        EdgeInsets.only(right: 10.w),
                                                                        child: Column(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment.end,
                                                                          children: [
                                                                            element.isPersonal
                                                                                ? Container()
                                                                                : Container(
                                                                              width: 65.w,
                                                                              height: 14.h,
                                                                              decoration:
                                                                              BoxDecoration(
                                                                                color: AppTheme.of(
                                                                                    context)
                                                                                    .secondary,
                                                                                borderRadius:
                                                                                BorderRadius
                                                                                    .circular(
                                                                                    8.0),
                                                                              ),
                                                                              child: const Center(
                                                                                child: Text(
                                                                                  "ENTREPRISE",
                                                                                  style:
                                                                                  TextStyle(
                                                                                    fontSize: 9,
                                                                                    color: Colors
                                                                                        .white,
                                                                                    fontWeight:
                                                                                    FontWeight
                                                                                        .bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Column(
                                                                              mainAxisSize:
                                                                              MainAxisSize.min,
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .end,
                                                                              children: [
                                                                                const Text(
                                                                                  "Mise à jour :",
                                                                                  style: TextStyle(
                                                                                    fontSize: 10.0,
                                                                                    color: Color(
                                                                                        0xFF8E8E93),
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  Tools.formatDate(
                                                                                      element
                                                                                          .updatedAt!),
                                                                                  style: TextStyle(
                                                                                      fontSize: 12.0,
                                                                                      color: AppTheme.of(
                                                                                          context)
                                                                                          .primary),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )),
                                                                ],
                                                              )),
                                                        ),
                                                        Container(
                                                            width: 50.w,
                                                            height: 70.h,
                                                            decoration: BoxDecoration(
                                                              color: AppTheme.of(context).tertiary,
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius.circular(8.0),
                                                                  bottomRight: Radius.circular(8.0)),
                                                            ),
                                                            child: const Icon(
                                                              Icons.send,
                                                              color: ColorConst.background,
                                                            )),
                                                      ],
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
