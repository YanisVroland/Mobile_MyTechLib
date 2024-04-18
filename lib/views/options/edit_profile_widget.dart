import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/services/models/user_model.dart';

import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/textField_custom.dart';

class EditProfileWidget extends StatefulWidget {
  EditProfileWidget(this.user, {Key? key}) : super(key: key);
  UserModel user;

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDataUploading = false;
  String uploadedFileUrl = '';
  final _formKey = GlobalKey<FormState>();
  bool _loader = false;

  late TextEditingController lastNameController;
  late TextEditingController firstNameController;

  @override
  void initState() {
    super.initState();

    lastNameController = TextEditingController();
    firstNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      text: "Créer un compte",
                      isLoading: _loader,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          // await validButton();
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
                    // Navigator.pushNamed(context, AppRouter.LOGIN);
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
