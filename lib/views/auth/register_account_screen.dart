import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app/routes/router.dart';
import '../../app/theme/app_theme.dart';
import '../../app/theme/snackBar_const.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/models/user_model.dart';
import '../../services/repositories/user_repository.dart';

class RegisterAccountWidget extends StatefulWidget {
  const RegisterAccountWidget({Key? key}) : super(key: key);

  @override
  _RegisterAccountWidgetState createState() => _RegisterAccountWidgetState();
}

class _RegisterAccountWidgetState extends State<RegisterAccountWidget> {
  late TextEditingController lastNameController;
  late TextEditingController firstNameController;
  late TextEditingController emailAddressController;
  late TextEditingController passwordCreateController;
  late TextEditingController passwordConfirmController;

  late bool _passwordCreateVisibility;
  late bool _passwordConfirmVisibility;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final bool _loader = false;

  @override
  void initState() {
    super.initState();
    _passwordCreateVisibility = false;
    _passwordConfirmVisibility = false;

    lastNameController = TextEditingController();
    firstNameController = TextEditingController();
    emailAddressController = TextEditingController();
    passwordCreateController = TextEditingController();
    passwordConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    emailAddressController.dispose();
    passwordCreateController.dispose();
    passwordConfirmController.dispose();
  }

  Future<void> validButton() async {
    final UserModel user = UserModel(
      email: emailAddressController.text,
      name: firstNameController.text,
      lastname: lastNameController.text,
      password: passwordCreateController.text,
    );

    final ResponseApi? response = await UserRepository().signUp(context, user);
    if (response != null) {
      if (response.status == 200) {
        final String uuid = response.body['uuid_user'];
        _navigateToMainScreen(uuid);
      } else {
        _handleError(response.body['message']);
      }
    } else {
      _handleError('Une erreur est survenue lors de la création de votre compte.');
    }
  }

  void _navigateToMainScreen(String uuid) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.MAIN,
      (Route<dynamic> route) => false,
      arguments: uuid,
    );
  }

  void _handleError(String errorMessage) {
    final errorMessageToShow =
        errorMessage == "A user with this email address has already been registered"
            ? "Un utilisateur avec cette adresse email est déjà enregistré."
            : "Une erreur est survenue lors de la création de votre compte.";
    SnackConst.SnackCustom(errorMessageToShow, context, duration: 3, color: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);

    Widget formRegister = Form(
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
                  Text("Créez votre compte ci-dessous."),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                    child: CustomTextField(
                      key: const Key('lastNameTextField'),
                      controller: lastNameController,
                      obscureText: false,
                      labelText: "Nom",
                      hintText: "Entrer votre nom...",
                      validator: Validators.validateEmpty,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    key: const Key('firstNameTextField'),
                    controller: firstNameController,
                    obscureText: false,
                    labelText: "Prénom",
                    hintText: "Entrer votre prénom...",
                    validator: Validators.validateEmpty,
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: CustomTextField(
                  key: const Key('emailTextField'),
                  controller: emailAddressController,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  labelText: "Adresse e-mail",
                  hintText: "Entrer votre adresse e-mail...",
                  validator: Validators.validateEmail,
                )),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
              child: CustomTextField(
                key: const Key('passwordCreateTextField'),
                controller: passwordCreateController,
                obscureText: !_passwordCreateVisibility,
                labelText: "Mot de passe",
                hintText: "Entrer votre mot de passe...",
                suffixIcon: InkWell(
                  onTap: () =>
                      setState(() => _passwordCreateVisibility = !_passwordCreateVisibility),
                  focusNode: FocusNode(skipTraversal: true),
                  child: Icon(
                    _passwordCreateVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 20.0,
                  ),
                ),
                validator: Validators.validatePassword,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
              child: CustomTextField(
                key: const Key('passwordConfirmTextField'),
                controller: passwordConfirmController,
                obscureText: !_passwordConfirmVisibility,
                labelText: "Confirmer le mot de passe",
                hintText: "Confirmer votre mot de passe...",
                suffixIcon: InkWell(
                  onTap: () =>
                      setState(() => _passwordConfirmVisibility = !_passwordConfirmVisibility),
                  focusNode: FocusNode(skipTraversal: true),
                  child: Icon(
                    _passwordConfirmVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 20.0,
                  ),
                ),
                validator: (value) {
                  if (value != passwordCreateController.text) {
                    return "Mot de passe non identique";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      text: "Créer un compte",
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
                          "Vous avez déjà un compte ?",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));

    return Scaffold(
      key: _scaffoldKey,
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
          child: SingleChildScrollView(
            child: formRegister,
          ),
        ),
      ),
    );
  }
}
