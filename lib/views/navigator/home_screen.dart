import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/app/theme/color_const.dart';

import '../../app/routes/router.dart';
import '../../app/theme/app_const.dart';
import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/validators.dart';
import '../../app/widgets/appBar_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/library_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController textController;
  late TabController tabBarController;
  late List<Library> listLibrairies;

  int get tabBarCurrentIndex => tabBarController.index;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    listLibrairies = [
      Library(
          id: "1",
          name: "Library 1",
          createdBy: "Yanis",
          createdAt: "12/12/2001",
          updatedAt: "12/12/2001"),
      Library(
          id: "2",
          name: "Library 2",
          createdBy: "Yanis",
          createdAt: "12/12/2001",
          updatedAt: "12/12/2001"),
      Library(
          id: "2",
          name: "Library 2",
          createdBy: "Yanis",
          createdAt: "12/12/2001",
          updatedAt: "12/12/2001")
    ];
    tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
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
                        fontSize: 16.0,
                      ),
                      tabs: const [
                        Tab(
                          text: "TOUT",
                        ),
                        Tab(
                          text: "PUBLIC",
                        ),
                        Tab(text: "TEAM"),
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
                            itemCount: listLibrairies.length,
                            itemBuilder: (context, listViewIndex) {
                              final element = listLibrairies[listViewIndex];
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 10.0),
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
                                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                                        0.0, 10.0, 0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        const Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                0.0, 0.0, 4.0, 0.0),
                                                            child: Text("Par :")),
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
                        Padding(padding: EdgeInsets.all(10.w), child: Container()),
                        Padding(padding: EdgeInsets.all(10.w), child: Container()),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
