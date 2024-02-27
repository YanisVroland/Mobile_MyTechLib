import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/app/widgets/textField_custom.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/widgets/button_custom.dart';

class JoinCompany extends StatefulWidget {
  const JoinCompany({Key? key}) : super(key: key);

  @override
  _JoinCompanyState createState() => _JoinCompanyState();
}

class _JoinCompanyState extends State<JoinCompany> {
  late TextEditingController nameCompanyController;
  late TextEditingController codeCompanyController;
  int filterIdx = 1;

  @override
  void initState() {
    super.initState();

    nameCompanyController = TextEditingController();
    codeCompanyController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameCompanyController.dispose();
    codeCompanyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      setState(() {
                        filterIdx = 1;
                      });
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: filterIdx == 1
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
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                        ),
                        border: Border.all(
                          color: filterIdx == 1
                              ? AppTheme.of(context).primary
                              : AppTheme.of(context).background,
                        ),
                      ),
                      alignment: const AlignmentDirectional(0.00, 0.00),
                      child: Text(
                        "Nouvelle entreprise",
                        style: TextStyle(
                          color: filterIdx == 1 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      setState(() {
                        filterIdx = 2;
                      });
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: filterIdx == 2
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
                          bottomRight: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        border: Border.all(
                          color: filterIdx == 2
                              ? AppTheme.of(context).primary
                              : AppTheme.of(context).background,
                        ),
                      ),
                      alignment: const AlignmentDirectional(0.00, 0.00),
                      child: Text(
                        "Rejoindre entreprise",
                        style: TextStyle(
                          color: filterIdx == 2 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          filterIdx == 1
              ? Column(
                  children: [
                    Text(
                      "Ajouter votre entreprise",
                      style: TextStyle(
                        color: AppTheme.of(context).primary,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h, top: 40.h),
                      child: CustomTextField(
                        controller: nameCompanyController,
                        obscureText: false,
                        prefixIcon: const Icon(Icons.business_outlined),
                        hintText: "Nom entreprise ...",
                      ),
                    ),
                    CustomButton(
                      text: "Ajouter",
                      onTap: () async {},
                    ),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      "Rejoindre une entreprise",
                      style: TextStyle(
                        color: AppTheme.of(context).primary,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h, top: 40.h),
                      child: CustomTextField(
                          controller: codeCompanyController,
                          obscureText: false,
                          prefixIcon: const Icon(Icons.lock_outlined),
                          hintText: "Code entreprise ..."),
                    ),
                    CustomButton(
                      text: "Rejoindre",
                      onTap: () async {},
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
