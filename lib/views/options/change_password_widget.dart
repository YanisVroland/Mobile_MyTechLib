import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/services/models/responseAPI_model.dart';
import 'package:my_tech_lib/services/repositories/user_repository.dart';

import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/routes/router.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/user_model.dart';

class ChangePasswordWidget extends StatefulWidget {
  ChangePasswordWidget(this.user, {Key? key}) : super(key: key);
  UserModel user;

  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  late TextEditingController emailAddressController;
  String? Function(BuildContext, String?)? emailAddressControllerValidator;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    emailAddressController.text = widget.user.email;
  }

  @override
  void dispose() {
    super.dispose();
    emailAddressController.dispose();
  }

  sendEmail() async {
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
    ResponseApi? responseApi = await UserRepository().forgotPassword(
      context,
      emailAddressController!.text.trim(),
    );

    if (responseApi != null && responseApi.status == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Email envoyé',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Limite de débit de courrier électronique dépassée',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: Form(
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
                      padding: EdgeInsets.only(top: 100.h, bottom: 40.h),
                      child: const Text(
                        "Entrez l'e-mail associé à votre compte",
                        textAlign: TextAlign.center,
                      )),
                  CustomTextField(
                    controller: emailAddressController,
                    keyboardType: TextInputType.emailAddress,
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
                          if (_formKey.currentState!.validate()) {
                            await sendEmail();
                          }
                        },
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
