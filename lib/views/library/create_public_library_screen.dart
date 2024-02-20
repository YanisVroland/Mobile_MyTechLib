import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/validators.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/icon_custom.dart';

class CreatePublicLibraryWidget extends StatefulWidget {
  const CreatePublicLibraryWidget({Key? key}) : super(key: key);

  @override
  _CreatePublicLibraryWidgetState createState() => _CreatePublicLibraryWidgetState();
}

class _CreatePublicLibraryWidgetState extends State<CreatePublicLibraryWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int idxSwitch = 1;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();

  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;

  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return "Field is required";
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }
    //
    // if (!RegExp(kTextValidatorUsernameRegex).hasMatch(val)) {
    //   return 'Must start with a letter and can only contain letters, digits and - or _.';
    // }
    // return null;
  }

  // State field(s) for TextField widget.
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  String? _textController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return "Field is required";
    }

    if (val.length < 1) {
      return 'Requires at least 1 characters.';
    }

    // if (!RegExp(kTextValidatorUsernameRegex).hasMatch(val)) {
    //   return 'Must start with a letter and can only contain letters, digits and - or _.';
    // }
    return null;
  }

  // Stores action output result for [Backend Call - Create Document] action in Button-Login widget.
  // State field(s) for codeCompany widget.
  TextEditingController? codeCompanyController;
  String? Function(BuildContext, String?)? codeCompanyControllerValidator;

  // Stores action output result for [Firestore Query - Query a collection] action in Button-Login widget.

  @override
  void initState() {
    super.initState();
    textController1 ??= TextEditingController();
    textController2 ??= TextEditingController();
    codeCompanyController ??= TextEditingController();

    textController1Validator = _textController1Validator;
    textController2Validator = _textController2Validator;
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
    codeCompanyController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).tertiary,
      body: SafeArea(
        top: true,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
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
                      "Librairie",
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
                        icon: Icon(
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
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  elevation: 3.0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 10.0, 0.0),
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
                                        idxSwitch = 1;
                                      });
                                    },
                                    child: Container(
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: idxSwitch == 1
                                            ? AppTheme.of(context).primary
                                            : AppTheme.of(context).background,
                                        boxShadow: [
                                          const BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x33000000),
                                            offset: Offset(0.0, 2.0),
                                          )
                                        ],
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20.0),
                                          bottomRight: Radius.circular(0.0),
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(0.0),
                                        ),
                                        border: Border.all(
                                          color: idxSwitch == 1
                                              ? AppTheme.of(context).primary
                                              : AppTheme.of(context).background,
                                        ),
                                      ),
                                      alignment: const AlignmentDirectional(0.00, 0.00),
                                      child: const Align(
                                        alignment: AlignmentDirectional(0.00, 0.00),
                                        child: Text(
                                          "Ajouter",
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
                                        idxSwitch = 2;
                                      });
                                    },
                                    child: Container(
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: idxSwitch == 2
                                            ? AppTheme.of(context).primary
                                            : AppTheme.of(context).background,
                                        boxShadow: [
                                          const BoxShadow(
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
                                      child: const Align(
                                        alignment: AlignmentDirectional(0.00, 0.00),
                                        child: Text(
                                          "Rejoindre",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (idxSwitch == 1)
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                                  child: TextFormField(
                                    controller: textController1,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: "Nom :",
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context).primary,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context).error,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context).error,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    validator: Validators.validateEmpty,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                                  child: TextFormField(
                                    controller: textController2,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: "Description :",
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context).primary,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context).error,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.of(context).error,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    maxLines: 4,
                                    validator: Validators.validateEmpty,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
                                  child: CustomButton(
                                    text: "Ajouter",
                                    onTap: () async {
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          if (idxSwitch == 2)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
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
                                          "Rejoindre une librairie",
                                        ),
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
                                              fillColor: AppTheme.of(context).secondaryBackground,
                                              contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 24.0, 20.0, 24.0),
                                              prefixIcon: const Icon(
                                                Icons.link,
                                              ),
                                            ),
                                            validator: Validators.validateEmpty,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 30.0, 0.0, 0.0),
                                          child: CustomButton(
                                            text: "Rejoindre",
                                            onTap: () async {
                                              // verif code existe
                                              Navigator.pop(context);

                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
