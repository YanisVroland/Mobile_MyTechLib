import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/views/library/widget/create_company_library_widget.dart';
import 'package:my_tech_lib/views/library/widget/create_public_library_widget.dart';
import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../app/widgets/icon_custom.dart';
import '../../services/models/user_model.dart';

class CreateLibraryWidget extends StatefulWidget {
  const CreateLibraryWidget(this.user, {Key? key}) : super(key: key);
  final UserModel user;

  @override
  _CreateLibraryWidgetState createState() => _CreateLibraryWidgetState();
}

class _CreateLibraryWidgetState extends State<CreateLibraryWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int idxSwitch = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).tertiary,
        body: SingleChildScrollView(
          child: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Nouvelle Librairie",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: AppTheme.of(context).background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: IconCustom(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          buttonSize: 48.0,
                          icon: const Icon(
                            Icons.close_rounded,
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
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      idxSwitch = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: idxSwitch == 1
                                          ? AppTheme.of(context).primary
                                          : AppTheme.of(context).background,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Color(0x33000000),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        topLeft: Radius.circular(20.0),
                                      ),
                                      border: Border.all(
                                        color: idxSwitch == 1
                                            ? AppTheme.of(context).primary
                                            : AppTheme.of(context).background,
                                      ),
                                    ),
                                    alignment: const AlignmentDirectional(0.00, 0.00),
                                    child: Align(
                                      alignment: const AlignmentDirectional(0.00, 0.00),
                                      child: Text(
                                        "Personnel",
                                        style: TextStyle(
                                            color: idxSwitch == 1 ? Colors.white : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      idxSwitch = 2;
                                    });
                                  },
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: idxSwitch == 2
                                          ? AppTheme.of(context).primary
                                          : AppTheme.of(context).background,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Color(0x33000000),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(20.0),
                                        topLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                      border: Border.all(
                                        color: idxSwitch == 2
                                            ? AppTheme.of(context).primary
                                            : AppTheme.of(context).background,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: const AlignmentDirectional(0.00, 0.00),
                                      child: Text(
                                        "Entreprise",
                                        style: TextStyle(
                                          color: idxSwitch == 2 ? Colors.white : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (idxSwitch == 1)
                          CreatePublicLibraryWidget(widget.user)
                        else
                          CreateCompanyLibraryWidget(widget.user)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
