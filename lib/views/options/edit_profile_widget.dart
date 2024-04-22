import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/services/models/responseAPI_model.dart';
import 'package:my_tech_lib/services/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tech_lib/services/repositories/user_repository.dart';

import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../../app/theme/snackBar_const.dart';
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
  String? uploadedFileUrl;
  final _formKey = GlobalKey<FormState>();
  bool _loader = false;

  late TextEditingController lastNameController;
  late TextEditingController firstNameController;

  @override
  void initState() {
    super.initState();

    lastNameController = TextEditingController();
    lastNameController.text = widget.user.lastname;
    firstNameController = TextEditingController();
    firstNameController.text = widget.user.name;
  }

  @override
  void dispose() {
    super.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
  }

  validButton() async {
    setState(() {
      _loader = true;
    });
    if (_formKey.currentState!.validate()) {
      if(uploadedFileUrl != null){
          ResponseApi? response = await UserRepository().updateProfileImageUser(context, widget.user,uploadedFileUrl!);
          if (response == null || response.status != 201) {
            SnackConst.SnackCustom("Erreur lors du changement d'image", context, duration: 3, color: Colors.red);
          }
      }
      widget.user.name = firstNameController.text;
      widget.user.lastname = lastNameController.text;
      ResponseApi? response = await UserRepository().updateUser(context, widget.user);
      if (response == null || response.status != 200) {
        SnackConst.SnackCustom("Erreur lors de la mise à jour profil", context, duration: 3, color: Colors.red);
      }else{
        SnackConst.SnackCustom("Profil mis à jour", context, duration: 3, color: Colors.green);
        UserModel result = UserModel.fromJson(response.body);
        widget.user = result;

        Navigator.pop(context);
      }
    }
    setState(() {
      _loader = false;
    });
  }

  Future<void> getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery, requestFullMetadata: false);

    if (pickedFile != null) {
      setState(() {
        uploadedFileUrl = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget formRegister = Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Stack(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: AppTheme.of(context).primary,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                      child: Container(
                        width: 90.0,
                        height: 90.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: uploadedFileUrl != null
                            ? Image.file(
                                File(uploadedFileUrl!),
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : widget.user.profileUrl.isEmpty
                                ? Image.asset(
                                    'assets/images/tlchargement.png',
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    widget.user.profileUrl,
                                    fit: BoxFit.cover,
                                  ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      height: 35.0,
                      width: 35.0,
                      decoration: BoxDecoration(
                        color: AppTheme.of(context).primary,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () async {
                          getImageFromGallery();
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
                      text: "Valider",
                      isLoading: _loader,
                      onTap: () async {
                        await validButton();
                      }),
                ],
              ),
            ),
          ],
        ));

    return Scaffold(
      backgroundColor: AppTheme.of(context).background,
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left_rounded,
            size: 32.0,
          ),
        ),
        title: const Text(
          "Modifier profil",
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
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
            vertical: 50.h,
          ),
          child: SingleChildScrollView(
            child: formRegister,
          ),
        ),
      ),
    );
  }
}
