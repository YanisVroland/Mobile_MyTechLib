import 'package:flutter/material.dart';
import '../../app/routes/router.dart';
import '../../app/theme/app_theme.dart';
import '../../app/theme/validators.dart';

class RegisterAccountWidget extends StatefulWidget {
  const RegisterAccountWidget({Key? key}) : super(key: key);

  @override
  _RegisterAccountWidgetState createState() => _RegisterAccountWidgetState();
}

class _RegisterAccountWidgetState extends State<RegisterAccountWidget> {
  TextEditingController? lastNameController;
  String? Function(BuildContext, String?)? lastNameControllerValidator;
  TextEditingController? firstNameController;
  String? Function(BuildContext, String?)? firstNameControllerValidator;
  TextEditingController? emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  TextEditingController? passwordCreateController;
  late bool passwordCreateVisibility;
  String? Function(BuildContext, String?)? passwordCreateControllerValidator;
  TextEditingController? passwordConfirmController;
  late bool passwordConfirmVisibility;
  String? Function(BuildContext, String?)? passwordConfirmControllerValidator;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    passwordCreateVisibility = false;
    passwordConfirmVisibility = false;

    lastNameController ??= TextEditingController();
    firstNameController ??= TextEditingController();
    emailAddressController ??= TextEditingController();
    passwordCreateController ??= TextEditingController();
    passwordConfirmController ??= TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    lastNameController?.dispose();
    firstNameController?.dispose();
    emailAddressController?.dispose();
    passwordCreateController?.dispose();
    passwordConfirmController?.dispose();
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
                      'assets/images/createAccount_bg@2x.png',
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Commencer",
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                                      child: Text("Créez votre compte ci-dessous."),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                                      child: TextFormField(
                                        controller: lastNameController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: "Nom",
                                          hintText: "Entrer votre nom...",
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
                                        validator: Validators.validateEmpty,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: firstNameController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: "Prénom",
                                        hintText: "Entrer votre prénom...",
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
                                      validator: Validators.validateEmpty,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                                child: TextFormField(
                                  controller: emailAddressController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    hintText: "Entrer votre email...",
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
                                  validator: Validators.validateEmpty,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                                child: TextFormField(
                                  controller: passwordCreateController,
                                  obscureText: !passwordCreateVisibility,
                                  decoration: InputDecoration(
                                    labelText: "Mot de passe",
                                    hintText: "Entrer votre mot de passe...",
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
                                        () => passwordCreateVisibility = !passwordCreateVisibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        passwordCreateVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: AppTheme.of(context).secondaryText,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                  validator: Validators.validatePassword,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                                child: TextFormField(
                                  controller: passwordConfirmController,
                                  obscureText: !passwordConfirmVisibility,
                                  decoration: InputDecoration(
                                    labelText: "Confirmer le mot de passe",
                                    hintText: "Entrer votre mot de passe...",
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
                                        () =>
                                            passwordConfirmVisibility = !passwordConfirmVisibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        passwordConfirmVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: AppTheme.of(context).secondaryText,
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                  validator: Validators.validatePassword,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 30.0),
                                // child: ButtonCustom(
                                //   onPressed: () async {
                                //     if (passwordCreateController!.text !=
                                //         passwordConfirmController!.text) {
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(
                                //           content: Text(
                                //             'Passwords don\'t match!',
                                //           ),
                                //         ),
                                //       );
                                //       return;
                                //     }
                                //     UserData userTmp = UserData(
                                //         email: emailAddressController!.text,
                                //         pwd: passwordCreateController!.text);
                                //     final user = await UserRepository().signUp(userTmp);
                                //     if (user == null) {
                                //       return;
                                //     }
                                //     //TODO nav onboarding
                                //     // Navigator.pushNamed(context, AppRouter.onboardingRoute);
                                //     // context.goNamedAuth('onboarding', context.mounted);
                                //   },
                                //   text: "Créer un compte",
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
                                  Container(
                                    width: MediaQuery.sizeOf(context).width * 0.8,
                                    height: 44.0,
                                    decoration: BoxDecoration(
                                      color: AppTheme.of(context).secondaryBackground,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        Navigator.pushNamed(context, AppRouter.LOGIN);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.arrow_back_rounded,
                                            color: AppTheme.of(context).primary,
                                            size: 24.0,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 10.0, 0.0),
                                            child: Text("Connexion"),
                                          ),
                                          const Text(
                                            "Vous avez déjà un compte ?",
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
