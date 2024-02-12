import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/routes/router.dart';
import '../../app/theme/app_theme.dart';
import '../../app/theme/color_const.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/textField_custom.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController emailAddressLoginController;
  late TextEditingController passwordLoginController;
  late bool passwordLoginVisibility;

  @override
  void initState() {
    super.initState();
    passwordLoginVisibility = false;
    emailAddressLoginController = TextEditingController();
    passwordLoginController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailAddressLoginController.dispose();
    passwordLoginController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: Container(
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
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 70.h,
          ),
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/finWallet_logo_landscapeDark@3x.png',
                width: 170.0,
                height: 60.0,
                fit: BoxFit.fitWidth,
              ),
              const Text("Bienvenue"),
              SizedBox(height: 10.h),
              const Text("Connectez-vous pour accéder à"),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: CustomTextField(
                  controller: emailAddressLoginController,
                  labelText: "Email",
                  hintText: "Entrer votre email",
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: CustomTextField(
                  controller: passwordLoginController,
                  obscureText: !passwordLoginVisibility,
                  labelText: "Mot de passe",
                  hintText: "Entrer votre mot de passe",
                  suffixIcon: InkWell(
                    onTap: () => setState(() => passwordLoginVisibility = !passwordLoginVisibility),
                    focusNode: FocusNode(skipTraversal: true),
                    child: Icon(
                      passwordLoginVisibility
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
              const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // CustomButton(
                  //   text: "Mot de passe oublié ?",
                  //   onTap: () async {
                  //     Navigator.pushNamed(context, AppRouter.FORGOTPASSWORD);
                  //   },
                  // ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 30.0),
                    child: CustomButton(
                      text: "Connexion",
                      onTap: () async {
                        /*final user = await UserRepository().signInWithCredentials(
                                  emailAddressLoginController!.text,
                                  passwordLoginController!.text,
                                );
                                if (user == null) {
                                  return;
                                }*/
                        Navigator.pushNamed(context, AppRouter.HOME);
                      },
                    ),
                  ),
                ],
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
                            padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 4.0, 0.0),
                            child: Text("Créer",
                                style: TextStyle(
                                    fontFamily: 'Lexend', color: AppTheme.of(context).primary)),
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
          )),
        ),
      ),
    );
  }
}
