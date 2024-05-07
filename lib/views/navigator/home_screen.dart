import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tech_lib/app/theme/color_const.dart';
import 'package:my_tech_lib/services/repositories/copy_repository.dart';

import '../../app/routes/router.dart';
import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/tools.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/appBar_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/globalData_model.dart';
import '../../services/models/library_model.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/repositories/library_repository.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget(this.globalData, {Key? key}) : super(key: key);
  final GlobalData globalData;

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

  int get tabBarCurrentIndex => tabBarController.index;

  @override
  void initState() {
    super.initState();

    initData();

    tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  Future<void> refreshData() async {
    searchListLibrairies.clear();
    listPersonalLibrairies.clear();
    listCompanyLibrairies.clear();
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
  }

  Future<void> initData() async {
    setState(() {
      searchListLibrairies.clear();
      listPersonalLibrairies.clear();
      listCompanyLibrairies.clear();

      inCompany = widget.globalData.user.companyUuid.isNotEmpty;

      listPersonalLibrairies = widget.globalData.listPersonalLibrairies;
      listCompanyLibrairies = widget.globalData.listCompanyLibrairies;

      searchListLibrairies.addAll(listPersonalLibrairies);
      searchListLibrairies.addAll(listCompanyLibrairies);

      textController = TextEditingController();
    });

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
  }

  Future<void> getPersonalLibraries() async {
    ResponseApi? response = await LibraryRepository().getPersonalLibrary(context);
    if (response != null && response.status == 200) {
      List<dynamic> result = await response.body.map((doc) => Library.fromJson(doc)).toList();

      setState(() {
        listPersonalLibrairies = result.cast<Library>();
        widget.globalData.listPersonalLibrairies = listPersonalLibrairies;
        searchListLibrairies = result.cast<Library>();
      });
    }
  }

  Future<void> getCompanyLibraries() async {
    ResponseApi? response =
        await LibraryRepository().getCompanyLibrary(context, widget.globalData.user.companyUuid);
    if (response != null && response.status == 200) {
      List<dynamic> result = await response.body.map((doc) => Library.fromJson(doc)).toList();

      setState(() {
        listCompanyLibrairies = result.cast<Library>();
        widget.globalData.listCompanyLibrairies = listCompanyLibrairies;
        searchListLibrairies.addAll(result.cast<Library>());
      });
    }
  }

  Future<void> copyLibrary(Library library) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Partager la librairie ${library.name}"),
          content: const Text("Etes-vous sûr de vouloir partager ?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () async {
                ResponseApi? response =
                    await CopyRepository().createCopyLibrary(context, library.uuid);
                if (response != null && response.status == 201) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 5),
                      content: Row(
                        children: [
                          const Text(
                            "Code de partage :",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            " ${response.body["code"]}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: response.body["code"]));
                              },
                              icon: const Icon(Icons.copy, color: Colors.white)),
                        ],
                      ),
                    ),
                  );
                }
              },
              child: const Text("Continuer"),
            ),
          ],
        );
      },
    );
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
          await Navigator.pushNamed(context, AppRouter.CREATE_LIBRARY,
              arguments: widget.globalData.user);
          await refreshData();
        },
        backgroundColor: AppTheme.of(context).primary,
        child: const Icon(
          Icons.post_add_rounded,
          color: ColorConst.background,
          size: 32.0,
        ),
      ),
      appBar: CustomAppBar(widget.globalData.user),
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
                              globalListLibrairies.isEmpty
                                  ? Center(
                                      child: Lottie.asset(
                                        'assets/lottie/list_empty.json',
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: RefreshIndicator(
                                        color: AppTheme.of(context).primary,
                                        backgroundColor: AppTheme.of(context).secondaryBackground,
                                        onRefresh: refreshData,
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height,
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
                                                        context, AppRouter.LIBRARY, arguments: [
                                                      widget.globalData.user,
                                                      element
                                                    ]);
                                                    await refreshData();
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
                                                                    padding: EdgeInsets.only(
                                                                        right: 10.w),
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
                                                        InkWell(
                                                          onTap: () async {
                                                            await copyLibrary(element);
                                                          },
                                                          child: Container(
                                                            width: 50.w,
                                                            height: 70.h,
                                                            decoration: BoxDecoration(
                                                              color: AppTheme.of(context).tertiary,
                                                              borderRadius: const BorderRadius.only(
                                                                  topRight: Radius.circular(8.0),
                                                                  bottomRight:
                                                                      Radius.circular(8.0)),
                                                            ),
                                                            child: const Icon(
                                                              Icons.send,
                                                              color: ColorConst.background,
                                                            ),
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
                                    ),
                              inCompany
                                  ? listCompanyLibrairies.isEmpty
                                      ? Center(
                                          child: Lottie.asset(
                                            'assets/lottie/list_empty.json',
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.all(10.w),
                                          child: RefreshIndicator(
                                            color: AppTheme.of(context).primary,
                                            backgroundColor:
                                                AppTheme.of(context).secondaryBackground,
                                            onRefresh: refreshData,
                                            child: SizedBox(
                                              height: MediaQuery.of(context).size.height,
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
                                                            context, AppRouter.LIBRARY, arguments: [
                                                          widget.globalData.user,
                                                          element
                                                        ]);
                                                        await refreshData();
                                                      },
                                                      child: Container(
                                                        height: 70.0,
                                                        decoration: BoxDecoration(
                                                          color: AppTheme.of(context)
                                                              .secondaryBackground,
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
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                    children: [
                                                                      Expanded(
                                                                        child: Padding(
                                                                          padding:
                                                                              const EdgeInsetsDirectional
                                                                                  .fromSTEB(12.0,
                                                                                  0.0, 0.0, 0.0),
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
                                                                        padding: EdgeInsets.only(
                                                                            right: 10.w),
                                                                        child: Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment
                                                                                  .spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .end,
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
                                                                                    child:
                                                                                        const Center(
                                                                                      child: Text(
                                                                                        "ENTREPRISE",
                                                                                        style:
                                                                                            TextStyle(
                                                                                          fontSize:
                                                                                              9,
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
                                                                                  MainAxisAlignment
                                                                                      .end,
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
                                                                                      fontSize:
                                                                                          12.0,
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
                                                            InkWell(
                                                              onTap: () async {
                                                                await copyLibrary(element);
                                                              },
                                                              child: Container(
                                                                width: 50.w,
                                                                height: 70.h,
                                                                decoration: BoxDecoration(
                                                                  color:
                                                                      AppTheme.of(context).tertiary,
                                                                  borderRadius:
                                                                      const BorderRadius.only(
                                                                          topRight:
                                                                              Radius.circular(8.0),
                                                                          bottomRight:
                                                                              Radius.circular(8.0)),
                                                                ),
                                                                child: const Icon(
                                                                  Icons.send,
                                                                  color: ColorConst.background,
                                                                ),
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
                                            "Cette partie est réservée aux communautés d'entreprise",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppTheme.of(context).primary,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              listPersonalLibrairies.isEmpty
                                  ? Center(
                                      child: Lottie.asset(
                                        'assets/lottie/list_empty.json',
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: RefreshIndicator(
                                        color: AppTheme.of(context).primary,
                                        backgroundColor: AppTheme.of(context).secondaryBackground,
                                        onRefresh: refreshData,
                                        child: SizedBox(
                                          height: MediaQuery.of(context).size.height,
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
                                                        context, AppRouter.LIBRARY, arguments: [
                                                      widget.globalData.user,
                                                      element
                                                    ]);
                                                    await refreshData();
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
                                                                    padding: EdgeInsets.only(
                                                                        right: 10.w),
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
                                                        InkWell(
                                                          onTap: () async {
                                                            await copyLibrary(element);
                                                          },
                                                          child: Container(
                                                            width: 50.w,
                                                            height: 70.h,
                                                            decoration: BoxDecoration(
                                                              color: AppTheme.of(context).tertiary,
                                                              borderRadius: const BorderRadius.only(
                                                                  topRight: Radius.circular(8.0),
                                                                  bottomRight:
                                                                      Radius.circular(8.0)),
                                                            ),
                                                            child: const Icon(
                                                              Icons.send,
                                                              color: ColorConst.background,
                                                            ),
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
