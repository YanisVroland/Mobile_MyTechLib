import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tech_lib/services/repositories/company_repository.dart';
import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../../app/theme/snackBar_const.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/company_model.dart';
import '../../services/models/responseAPI_model.dart';

class CompanyEditWidget extends StatefulWidget {
  CompanyEditWidget(this.company, {Key? key}) : super(key: key);
  Company company;

  @override
  _CompanyEditWidgetState createState() => _CompanyEditWidgetState();
}

class _CompanyEditWidgetState extends State<CompanyEditWidget> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDataUploading = false;
  String? uploadedFileUrl;
  final _formKey = GlobalKey<FormState>();
  bool _loader = false;

  late TextEditingController nameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    nameController.text = widget.company.name;
    descriptionController = TextEditingController();
    descriptionController.text = widget.company.description;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
  }

  validButton() async {
    setState(() {
      _loader = true;
    });
    if (_formKey.currentState!.validate()) {
      if (uploadedFileUrl != null) {
        ResponseApi? response =
            await CompanyRepository().updateLogoCompany(context, widget.company, uploadedFileUrl!);
        if (response == null || response.status != 201) {
          SnackConst.SnackCustom("Erreur lors du changement d'image", context,
              duration: 3, color: Colors.red);
        }
      }
      widget.company.name = nameController.text;
      widget.company.description = descriptionController.text;
      ResponseApi? response = await CompanyRepository().updateCompany(context, widget.company);
      if (response == null || response.status != 200) {
        SnackConst.SnackCustom("Erreur lors de la mise à jour", context,
            duration: 3, color: Colors.red);
      } else {
        SnackConst.SnackCustom("Entreprise mise à jour", context, duration: 3, color: Colors.green);
        Company result = Company.fromJsonUpdate(response.body);
        setState(() {
          widget.company = result;
        });

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
                            : widget.company.logoUrl.isEmpty
                                ? Image.asset(
                                    'assets/images/tlchargement.png',
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    widget.company.logoUrl,
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
            CustomTextField(
              controller: nameController,
              obscureText: false,
              labelText: "Nom",
              hintText: "Entrer votre nom...",
              validator: Validators.validateEmpty,
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: CustomTextField(
                controller: descriptionController,
                obscureText: false,
                labelText: "Description",
                hintText: "Entrer votre description...",
                validator: Validators.validateEmpty,
                maxLines: 5,
              ),
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
          "Modifier entreprise",
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
