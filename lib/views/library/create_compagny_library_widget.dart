import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/theme/validators.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/icon_custom.dart';

class CreateCompagnyLibraryWidget extends StatefulWidget {
  const CreateCompagnyLibraryWidget({Key? key}) : super(key: key);

  @override
  _CreateCompagnyLibraryWidgetState createState() => _CreateCompagnyLibraryWidgetState();
}

class _CreateCompagnyLibraryWidgetState extends State<CreateCompagnyLibraryWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int idxSwitch = 1;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();

  // State field(s) for TextField widget.
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;

  // State field(s) for TextField widget.
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState() {
    super.initState();

    textController1 ??= TextEditingController();
    textController2 ??= TextEditingController();
  }

  @override
  void dispose() {
    textController1?.dispose();
    textController2?.dispose();
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
                      "Librairie companie",
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
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                            child: TextFormField(
                              controller: textController1,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: "Nom",
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
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
                                  child: Text(
                                    "Admin seulement",
                                  ),
                                ),
                                Switch.adaptive(
                                  value: switchValue ??= false,
                                  onChanged: (newValue) async {
                                    setState(() => switchValue = newValue);
                                  },
                                  activeColor: AppTheme.of(context).primary,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
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
