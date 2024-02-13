import '../../app/theme/app_theme.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../app/widgets/button_custom.dart';
import '../../app/widgets/icon_custom.dart';

class ProjectWidget extends StatefulWidget {
  const ProjectWidget({Key? key}) : super(key: key);

  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> with TickerProviderStateMixin {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final unfocusNode = FocusNode();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;


  @override
  void initState() {
    super.initState();

    tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: AppTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: IconCustom(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 30.0,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          title: const Text("Article Title"),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Align(
                alignment: const Alignment(0.0, 0),
                child: TabBar(
                  unselectedLabelStyle: const TextStyle(),
                  indicatorColor: AppTheme.of(context).primary,
                  padding: const EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                  tabs: [
                    const Tab(text: "Production"),
                    const Tab(text: "Preproduction"),
                  ],
                  controller: tabBarController,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabBarController,
                  children: [
                    Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 44.0,
                                  height: 44.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: AppTheme.of(context).primary,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        'https://source.unsplash.com/random/1280x720?profile&5',
                                        width: 44.0,
                                        height: 44.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Haily Brown",
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                          child: Text("3 Days Ago - 5 Min Read"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                CustomButton(
                                  text: "Télécharger",

                                  onTap: () {
                                    print('Button pressed ...');
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 240.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.network(
                                    'https://picsum.photos/seed/669/600',
                                    width: double.infinity,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(-1.00, 1.00),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 6.0,
                                          sigmaY: 2.0,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              2.0, 2.0, 2.0, 2.0),
                                          child: Container(
                                            width: 64.0,
                                            height: 64.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            alignment: const AlignmentDirectional(0.00, 0.00),
                                            child: Icon(
                                              Icons.document_scanner_outlined,
                                              color: AppTheme.of(context).primary,
                                              size: 44.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                            child: Text(
                              "How to keep yourself productiv...",
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(mainAxisSize: MainAxisSize.max, children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                child: Container(
                                  height: 32.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: AppTheme.of(context).primary,
                                    ),
                                  ),
                                  child: const Align(
                                    alignment: AlignmentDirectional(0.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                      child: Text("website"),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                child: Container(
                                  height: 32.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: AppTheme.of(context).secondary,
                                    ),
                                  ),
                                  child: const Align(
                                    alignment: AlignmentDirectional(0.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                      child: Text("ux"),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                                // .divide(SizedBox(width: 8.0))
                                // .addToStart(SizedBox(width: 16.0))
                                // .addToEnd(SizedBox(width: 16.0)),
                                ),
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                            child: Text("Introduction"),
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                            child: Text("Elevate your casual look with ..."),
                          ),
                        ]
                        // .divide(SizedBox(height: 12.0)),
                        ),
                    Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 44.0,
                                  height: 44.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: AppTheme.of(context).primary,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        'https://source.unsplash.com/random/1280x720?profile&5',
                                        width: 44.0,
                                        height: 44.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Haily Brown"),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                          child: Text("3 Days Ago - 5 Min Read"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                CustomButton(
                                  text: "Subscribe",

                                  onTap: () {
                                    print('Button pressed ...');
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 240.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.network(
                                    'https://picsum.photos/seed/669/600',
                                    width: double.infinity,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(-1.00, 1.00),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 6.0,
                                          sigmaY: 2.0,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              2.0, 2.0, 2.0, 2.0),
                                          child: Container(
                                            width: 64.0,
                                            height: 64.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            alignment: const AlignmentDirectional(0.00, 0.00),
                                            child: Icon(
                                              Icons.document_scanner_outlined,
                                              color: AppTheme.of(context).primary,
                                              size: 44.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                            child: Text(
                              "How to keep yourself productiv...",
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(mainAxisSize: MainAxisSize.max, children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                child: Container(
                                  height: 32.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: AppTheme.of(context).primary,
                                    ),
                                  ),
                                  child: const Align(
                                    alignment: AlignmentDirectional(0.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                      child: Text(
                                        "website",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                                child: Container(
                                  height: 32.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: AppTheme.of(context).secondary,
                                    ),
                                  ),
                                  child: const Align(
                                    alignment: AlignmentDirectional(0.00, 0.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                      child: Text("ux"),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                                // .divide(SizedBox(width: 8.0))
                                // .addToStart(SizedBox(width: 16.0))
                                // .addToEnd(SizedBox(width: 16.0)),
                                ),
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                            child: Text(
                              "Introduction",
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                            child: Text(
                              "Elevate your casual look with ...",
                            ),
                          ),
                        ]
                        // .divide(SizedBox(height: 12.0)),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
