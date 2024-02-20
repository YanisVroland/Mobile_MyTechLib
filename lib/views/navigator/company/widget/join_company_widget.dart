import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_theme.dart';
import '../../../../app/theme/validators.dart';
import '../../../../app/widgets/button_custom.dart';

class JoinCompany extends StatefulWidget {

  const JoinCompany({Key? key}) : super(key: key);

  @override
  _JoinCompanyState createState() => _JoinCompanyState();


}

class _JoinCompanyState extends State<JoinCompany> {
  late TextEditingController nameCompanyController;
  late TextEditingController codeCompanyController;

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

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
            child: Stack(
              children: [
                Padding(
                  padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(70.0),
                        topRight: Radius.circular(70.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20.0, 40.0, 12.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).secondaryBackground,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Text(
                                  "Ajouter votre compagnie ",
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 30.0, 0.0, 0.0),
                                  child: TextFormField(
                                    controller: nameCompanyController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: "Nom compagnie ...",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context).primary,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0x00000000),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF0000),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xFFFF0000),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor:
                                      AppTheme.of(context).secondaryBackground,
                                      contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          20.0, 24.0, 20.0, 24.0),
                                      prefixIcon: const Icon(
                                        Icons.home_work_sharp,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 30.0, 0.0, 0.0),
                                  child: CustomButton(
                                    text: "Ajouter",
                                    onTap: () async {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 50.0,
                            thickness: 1.0,
                            color: AppTheme.of(context).primary,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).secondaryBackground,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Text("Rejoindre une companie"),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 30.0, 0.0, 0.0),
                                  child: TextFormField(
                                      controller: codeCompanyController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "Code compagnie",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppTheme.of(context).primary,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFFF0000),
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xFFFF0000),
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        filled: true,
                                        fillColor: AppTheme.of(context)
                                            .secondaryBackground,
                                        contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 24.0, 20.0, 24.0),
                                        prefixIcon: const Icon(
                                          Icons.link,
                                        ),
                                      ),
                                      validator: Validators.validateEmpty),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 30.0, 0.0, 0.0),
                                  child: CustomButton(
                                    text: "Rejoindre",
                                    onTap: () async {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


}
