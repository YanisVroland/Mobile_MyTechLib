import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/app/theme/validators.dart';

import '../../app/routes/router.dart';
import '../../app/theme/app_theme.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/repositories/user_repository.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late TextEditingController emailAddressLoginController;
  late TextEditingController passwordLoginController;
  final _formKey = GlobalKey<FormState>();
  late bool passwordLoginVisibility;
  final bool _loader = false;

  @override
  void initState() {
    super.initState();
    passwordLoginVisibility = false;
    emailAddressLoginController = TextEditingController();
    emailAddressLoginController.text = 'yanis.vroland@gmail.com';
    passwordLoginController = TextEditingController();
    passwordLoginController.text = 'Ascvbn.10';
  }

  @override
  void dispose() {
    super.dispose();
    emailAddressLoginController.dispose();
    passwordLoginController.dispose();
  }

  validButton() async {
    UserRepository userRepository = UserRepository();
    ResponseApi? response = await userRepository.signIn(
        context, emailAddressLoginController.text, passwordLoginController.text);

    if (response != null && response.status == 200) {
      String uuid = response.body['uuid_user'];
      Navigator.pushNamedAndRemoveUntil(context, AppRouter.MAIN, (Route<dynamic> route) => false,
          arguments: uuid);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget formLogin = Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo_landscape.png',
            width: 300.0,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h, bottom: 20.h),
            child: const Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Connectez vous à votre compte ci-dessous."),
              ],
            ),
          ),
          CustomTextField(
            controller: emailAddressLoginController,
            labelText: "Email",
            hintText: "Entrer votre email",
            validator: Validators.validateEmail,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: CustomTextField(
              controller: passwordLoginController,
              obscureText: !passwordLoginVisibility,
              labelText: "Mot de passe",
              hintText: "Entrer votre mot de passe",
              validator: Validators.validatePassword,
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
          Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pushNamed(context, AppRouter.FORGOT_PASSWORD);
                    },
                    child: const Text("Mot de passe oublié ?"),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    text: 'Connexion',
                    isLoading: _loader,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await validButton();
                      }
                    }),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.REGISTER);
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
      ),
    );

    return Scaffold(
      backgroundColor: AppTheme.of(context).background,
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
            child: formLogin,
          ),
        ),
      ),
    );
  }
}
