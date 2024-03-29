import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/routes/router.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/textField_custom.dart';

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({Key? key}) : super(key: key);

  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  late TextEditingController emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    emailAddressController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    emailAddressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).background,
      body: Container(
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
          padding: EdgeInsets.symmetric(
            horizontal: 30.w,
            vertical: 70.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/finWallet_logo_landscapeDark@3x.png',
                width: 300.0,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 100.h, bottom: 40.h),
                  child: const Text(
                    "Entrez l'e-mail associé à votre compte",
                    textAlign: TextAlign.center,
                  )),
              CustomTextField(
                controller: emailAddressController,
                obscureText: false,
                labelText: "Adresse e-mail",
                hintText: "Entrer votre adresse e-mail...",
                validator: Validators.validateEmail,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 30.h, bottom: 30.h),
                  child: CustomButton(
                    text: "Envoyer",
                    onTap: () async {
                      if (emailAddressController!.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Email required!',
                            ),
                          ),
                        );
                        return;
                      }
                      //TODO RESET PASSWORD
                      // await authManager.resetPassword(
                      //   email: emailAddressController!.text,
                      //   context: context,
                      // );
                    },
                  )),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.LOGIN);
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      height: 44.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_rounded,
                            color: AppTheme.of(context).primary,
                            size: 24.0,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 22.0, 0.0),
                            child: Text("Connexion",
                                style: TextStyle(
                                    fontFamily: 'Lexend', color: AppTheme.of(context).primary)),
                          ),
                          const Text(
                            "Vous avez vos identifiants ?",
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
    );
  }
}
