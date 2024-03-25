import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/services/models/user_model.dart';

import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/color_const.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/repositories/company_repository.dart';

class CompanyListPeopleWidget extends StatefulWidget {
  CompanyListPeopleWidget(this.listCompanyUser, {Key? key}) : super(key: key);
  List<UserModel> listCompanyUser = [];

  @override
  _CompanyListPeopleWidgetState createState() => _CompanyListPeopleWidgetState();
}

class _CompanyListPeopleWidgetState extends State<CompanyListPeopleWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).background,
      //TODO changr la appbar
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).background,
        automaticallyImplyLeading: true,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 24.0,
          ),
        ),
        title: const Text(
          "Compagnie",
        ),
        actions: [],
        centerTitle: true,
        elevation: 5.0,
      ),
      body: Column(
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
          Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Text(
                "Liste des informations",
                style: TextStyle(
                  color: AppTheme.of(context).primary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: widget.listCompanyUser.length,
                itemBuilder: (context, listViewIndex) {
                  final element = widget.listCompanyUser[listViewIndex];
                  return Container(
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
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text("Name : " + element.name + " " + element.lastname,
                                      style: TextStyle(
                                        color: AppTheme.of(context).primary,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  " 12/07/2022 ",
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
