import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tech_lib/app/theme/color_const.dart';
import 'package:my_tech_lib/services/repositories/copy_repository.dart';
import '../../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../app/widgets/icon_custom.dart';
import '../../app/theme/snackBar_const.dart';
import '../../app/theme/validators.dart';
import '../../app/widgets/button_custom.dart';
import '../../app/widgets/textField_custom.dart';
import '../../services/models/library_model.dart';
import '../../services/models/responseAPI_model.dart';
import '../../services/models/user_model.dart';
import '../../services/repositories/library_repository.dart';

class CreateLibraryWidget extends StatefulWidget {
  const CreateLibraryWidget(this.user, {Key? key}) : super(key: key);
  final UserModel user;

  @override
  _CreateLibraryWidgetState createState() => _CreateLibraryWidgetState();
}

class _CreateLibraryWidgetState extends State<CreateLibraryWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool toCompany = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController codeController;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  bool _loader = false;
  String logoImage = "";
  String bannerImage = "";
  int idxSwitch = 1;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  validButton() async {
    setState(() {
      _loader = true;
    });
    Library library = Library(
      name: nameController.text,
      description: descriptionController.text,
      isPersonal: !toCompany,
      logoUrl: logoImage,
      bannerUrl: bannerImage,
    );
    if (!toCompany) {
      library.belongsTo = widget.user.uuid;
    } else {
      library.core_company = widget.user.companyUuid;
    }
    ResponseApi? response = await LibraryRepository().createLibrary(context, library);

    if (response != null && response.status == 201) {
      SnackConst.SnackCustom("Nouvelle librairie créée", context, color: Colors.green);
      Navigator.pop(context);
    }
    setState(() {
      _loader = false;
    });
  }

  validCopyLibraryButton() async {
    setState(() {
      _loader = true;
    });
    ResponseApi? response = await CopyRepository().useCopyLibrary(context, codeController.text);

    if (response != null && response.status == 200) {
      SnackConst.SnackCustom("Nouvelle librairie créée", context, color: Colors.green);
      Navigator.pop(context);
    }
    setState(() {
      _loader = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        orientation: Orientation.portrait);

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).tertiary,
        body: SingleChildScrollView(
          child: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Nouvelle Librairie",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: AppTheme.of(context).background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: IconCustom(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          buttonSize: 48.0,
                          icon: const Icon(
                            Icons.close_rounded,
                            size: 30.0,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      idxSwitch = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: idxSwitch == 1
                                          ? AppTheme.of(context).primary
                                          : AppTheme.of(context).background,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Color(0x33000000),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        topLeft: Radius.circular(20.0),
                                      ),
                                      border: Border.all(
                                        color: idxSwitch == 1
                                            ? AppTheme.of(context).primary
                                            : AppTheme.of(context).background,
                                      ),
                                    ),
                                    alignment: const AlignmentDirectional(0.00, 0.00),
                                    child: Align(
                                      alignment: const AlignmentDirectional(0.00, 0.00),
                                      child: Text(
                                        "NOUVELLE",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: idxSwitch == 1 ? Colors.white : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      idxSwitch = 2;
                                    });
                                  },
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: idxSwitch == 2
                                          ? AppTheme.of(context).primary
                                          : AppTheme.of(context).background,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 4.0,
                                          color: Color(0x33000000),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(20.0),
                                        topLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                      border: Border.all(
                                        color: idxSwitch == 2
                                            ? AppTheme.of(context).primary
                                            : AppTheme.of(context).background,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: const AlignmentDirectional(0.00, 0.00),
                                      child: Text(
                                        "PAR CODE",
                                        style: TextStyle(
                                          color: idxSwitch == 2 ? Colors.white : Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        idxSwitch == 1
                            ? Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextField(
                                      controller: nameController,
                                      labelText: "Nom",
                                      hintText: "Entrer le nom de la librairie",
                                      validator: Validators.validateEmpty,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: CustomTextField(
                                        controller: descriptionController,
                                        labelText: "Description",
                                        hintText: "Entrer la description de la librairie",
                                        validator: Validators.validateEmpty,
                                        maxLines: 5,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(right: 10.w),
                                                  child: Text(
                                                    "Logo :",
                                                    style: TextStyle(fontSize: 16.sp),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    final pickedFile = await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource.gallery,
                                                            requestFullMetadata: false);
                                                    if (pickedFile != null) {
                                                      setState(() {
                                                        logoImage = pickedFile.path;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 50.w,
                                                    height: 50.w,
                                                    decoration: BoxDecoration(
                                                      color: ColorConst.background,
                                                      borderRadius: BorderRadius.circular(20.0.r),
                                                    ),
                                                    child: logoImage == ""
                                                        ? Center(
                                                            child: SvgPicture.asset(
                                                              "assets/icons/camera.svg",
                                                              width: 20.w,
                                                            ),
                                                          )
                                                        : ClipRRect(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(12)),
                                                            child: Image.file(
                                                              File(logoImage),
                                                              fit: BoxFit.cover,
                                                              width: ScreenUtil().setWidth(70),
                                                              height: ScreenUtil().setWidth(70),
                                                            )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(right: 10.w),
                                                  child: Text(
                                                    "Bannière :",
                                                    style: TextStyle(fontSize: 16.sp),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    final pickedFile = await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource.gallery,
                                                            requestFullMetadata: false);
                                                    if (pickedFile != null) {
                                                      setState(() {
                                                        bannerImage = pickedFile.path;
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 80.w,
                                                    height: 50.w,
                                                    decoration: BoxDecoration(
                                                      color: ColorConst.background,
                                                      borderRadius: BorderRadius.circular(20.0.r),
                                                    ),
                                                    child: bannerImage == ""
                                                        ? Center(
                                                            child: SvgPicture.asset(
                                                              "assets/icons/camera.svg",
                                                              width: 20.w,
                                                            ),
                                                          )
                                                        : ClipRRect(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(12)),
                                                            child: Image.file(
                                                              File(bannerImage),
                                                              fit: BoxFit.cover,
                                                              width: ScreenUtil().setWidth(70),
                                                              height: ScreenUtil().setWidth(70),
                                                            )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    if (widget.user.companyAdmin)
                                      Padding(
                                          padding: EdgeInsets.only(top: 10.h),
                                          child: Row(
                                            children: [
                                              Text("Librairie entreprise ",
                                                  style: TextStyle(
                                                      color: Colors.black, fontSize: 16.sp)),
                                              Checkbox(
                                                value: toCompany,
                                                onChanged: (bool? value) {
                                                  if (widget.user.companyAdmin) {
                                                    setState(() {
                                                      toCompany = value!;
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                          )),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomButton(
                                              text: 'Ajouter',
                                              isLoading: _loader,
                                              onTap: () async {
                                                if (_formKey.currentState!.validate()) {
                                                  await validButton();
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20.h),
                                      child: CustomTextField(
                                        controller: codeController,
                                        labelText: "Code de la librairie",
                                        hintText: "Entrer le code de la librairie",
                                        validator: Validators.validateEmpty,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomButton(
                                              text: 'Ajouter',
                                              isLoading: _loader,
                                              onTap: () async {
                                                if (_formKey.currentState!.validate()) {
                                                  await validCopyLibraryButton();
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
