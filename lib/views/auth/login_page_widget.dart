import 'package:flutter/material.dart';

import '../../app/routes/router.dart';
import '../../app/theme/app_theme.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? emailAddressLoginController;
  String? Function(BuildContext, String?)? emailAddressLoginControllerValidator;
  TextEditingController? passwordLoginController;
  late bool passwordLoginVisibility;
  String? Function(BuildContext, String?)? passwordLoginControllerValidator;

  @override
  void initState() {
    super.initState();
    passwordLoginVisibility = false;

    emailAddressLoginController ??= TextEditingController();
    passwordLoginController ??= TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailAddressLoginController?.dispose();
    passwordLoginController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: Image.asset(
                      'assets/images/login_bg@2x.png',
                    ).image,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 0.0, 20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (Theme.of(context).brightness == Brightness.dark)
                              Image.asset(
                                'assets/images/finWallet_logo_landscape.png',
                                width: 170.0,
                                height: 60.0,
                                fit: BoxFit.fitWidth,
                              ),
                            if (!(Theme.of(context).brightness == Brightness.dark))
                              Image.asset(
                                'assets/images/finWallet_logo_landscapeDark@3x.png',
                                width: 170.0,
                                height: 60.0,
                                fit: BoxFit.fitWidth,
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text("Bienvenue"),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                                        child: Text("Connectez-vous pour accéder à "),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                child: TextFormField(
                                  controller: emailAddressLoginController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    hintText: "Entrer votre email",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: AppTheme.of(context).secondaryBackground,
                                    contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                        20.0, 24.0, 20.0, 24.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                child: TextFormField(
                                  controller: passwordLoginController,
                                  obscureText: !passwordLoginVisibility,
                                  decoration: InputDecoration(
                                    labelText: "Mot de passe",
                                    hintText: "Entrer votre mot de passe",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: AppTheme.of(context).secondaryBackground,
                                    contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                        20.0, 24.0, 20.0, 24.0),
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => passwordLoginVisibility = !passwordLoginVisibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        passwordLoginVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: const Color(0x98FFFFFF),
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // ButtonCustom(
                                  //   onPressed: () async {
                                  //     Navigator.pushNamed(context, AppRouter.FORGOTPASSWORD);
                                  //   },
                                  //   text: "Mot de passe oublié ?",
                                  //   options: ButtonOptionsCustom(
                                  //     width: 170.0,
                                  //     height: 40.0,
                                  //     padding:
                                  //         const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                  //     iconPadding:
                                  //         const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                  //     color: const Color(0x001A1F24),
                                  //     elevation: 0.0,
                                  //     borderSide: const BorderSide(
                                  //       color: Colors.transparent,
                                  //       width: 1.0,
                                  //     ),
                                  //     borderRadius: BorderRadius.circular(8.0),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 30.0),
                                // child: ButtonCustom(
                                //   onPressed: () async {
                                //     /*final user = await UserRepository().signInWithCredentials(
                                //       emailAddressLoginController!.text,
                                //       passwordLoginController!.text,
                                //     );
                                //     if (user == null) {
                                //       return;
                                //     }*/
                                //     Navigator.pushNamed(context, AppRouter.HOME);
                                //   },
                                //   text: "Connexion",
                                //   options: ButtonOptionsCustom(
                                //     width: double.infinity,
                                //     height: 50.0,
                                //     padding:
                                //         const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                //     iconPadding:
                                //         const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                //     color: AppTheme.of(context).primary,
                                //     elevation: 3.0,
                                //     borderSide: const BorderSide(
                                //       color: Colors.transparent,
                                //       width: 1.0,
                                //     ),
                                //     borderRadius: BorderRadius.circular(30.0),
                                //   ),
                                // ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      Navigator.pushNamed(context, AppRouter.REGISTER);
                                    },
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width * 0.8,
                                      height: 44.0,
                                      decoration: BoxDecoration(
                                        color: AppTheme.of(context).secondaryBackground,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text("Vous n'avez pas de compte ?"),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(
                                                24.0, 0.0, 4.0, 0.0),
                                            child: Text("Créer",
                                                style: TextStyle(
                                                    fontFamily: 'Lexend',
                                                    color: AppTheme.of(context).primary)),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            color: AppTheme.of(context).primary,
                                            size: 24.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
